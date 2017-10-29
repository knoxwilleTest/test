//
//  WTTradeDataSource.m
//  WorkTest
//
//  Created by Anton Krivchicov on 22.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import "WTTradeDataSource.h"
#import "WTTradeItem.h"
#import "WTCandleModel.h"
#import "WTNetworkService.h"

static const NSInteger kCandleLenght = 60; // candle lenght in seconds

typedef NS_ENUM(NSInteger, WTTradeDataSourceState) {
    WTTradeDataSourceStateConnect = 0,
    WTTradeDataSourceStateFirstMessage,
    WTTradeDataSourceStateIdle
};

@interface WTTradeDataSource()<WTNetworkServiceDelegate> {
    NSMutableSet<WTTradeItem *> *_tradeModel;
    __weak id<WTTradeDataSourceDelegate> _delegate;
    NSTimer *_timer;
    NSMutableArray<WTTradeItem *> *_currentTicks;
    WTTradeDataSourceState _currentState;
    id<WTTradeDataSourceInjection> _injection;
}

@end


@implementation WTTradeDataSource

-(instancetype)initWithInjection:(id<WTTradeDataSourceInjection>)injection {
    if (self = [super init]) {
        _tradeModel = [NSMutableSet new];
        _currentTicks = [NSMutableArray new];
        _currentState = WTTradeDataSourceStateConnect;
        _injection = injection;
    }
    return self;
}


-(void)setDelegate:(id<WTTradeDataSourceDelegate>)delegate {
    if (delegate == _delegate) {
        return;
    }
    if (delegate) {
        [_injection.networkService setDelegate:self];
    }
    else {
        [_injection.networkService setDelegate:nil];
    }
    _delegate = delegate;
}


-(void)reset {
    [_timer invalidate];
    _timer = nil;
    _currentState = WTTradeDataSourceStateConnect;
    [_currentTicks removeAllObjects];
    [_tradeModel removeAllObjects];
}


-(id<WTTradeDataSourceDelegate>)delegate {
    return _delegate;
}


-(void)onTick:(NSTimer *)timer {
    if (_currentTicks.count) {
        [self configeCandle];
    }
}


-(void)startNextAfterFirstCandles {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:kCandleLenght
                                              target:self
                                            selector:@selector(onTick:)
                                            userInfo:nil
                                             repeats:YES];
}


// config candle after kCandleLenght
-(BOOL)configeCandle {
    double startValue = [_currentTicks firstObject].tradeBid;
    double finishValue = [_currentTicks lastObject].tradeBid;
    
    NSArray *descriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"tradeBid" ascending:NO]];
    NSArray *sortedArray = [_currentTicks sortedArrayUsingDescriptors:descriptors];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"tradeBid >= %g", 0];
    NSArray<WTTradeItem *> *filteredArray = [sortedArray filteredArrayUsingPredicate:predicate];
    double maxTrick = 0;
    double minTrick = 0;
    if (filteredArray.count) {
        maxTrick = [filteredArray firstObject].tradeBid;
        minTrick = [filteredArray lastObject].tradeBid;
    }
    
    WTCandleModel *candleModel = [[WTCandleModel alloc] initWithStartValue:startValue
                                                               finishValue:finishValue
                                                                  maxValue:maxTrick
                                                                  minValue:minTrick
                                                                      date:[NSDate date]];
    
    [_currentTicks removeAllObjects];
    
    if (_delegate) {
        return [_delegate newCandleIsCome:candleModel];
    }
    return NO;
}


//only for updating last candle data
-(void)updateCurrentCandleWithTick:(WTTradeItem *)tradeItem {
    if (_delegate) {
        WTCandleModel *candleModel = [[WTCandleModel alloc] initWithStartValue:tradeItem.tradeBid
                                                                   finishValue:tradeItem.tradeBid
                                                                      maxValue:tradeItem.tradeBid
                                                                      minValue:tradeItem.tradeBid
                                                                          date:[NSDate date]];
        [_delegate updateCurrentCandleWithCandle:candleModel];
    }
}


-(void)WTSocketOpen {
    [_injection.networkService subscribe];
}


-(void)WTSocketDidReceiveMessage:(NSData *)data {
    NSError *jsonError;
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
    
    WTTradeItem *tradeItem = [[WTTradeItem alloc] initWithDictionary:json];
    [_currentTicks addObject:tradeItem];
    if (_currentState == WTTradeDataSourceStateConnect) {
        if ([self configeCandle]) {
            _currentState = WTTradeDataSourceStateFirstMessage;
        }
    }
    else {
        if (_currentState == WTTradeDataSourceStateFirstMessage) {
            [self startNextAfterFirstCandles];
            _currentState = WTTradeDataSourceStateIdle;
        }
        else if (_currentState == WTTradeDataSourceStateIdle) {
            [self updateCurrentCandleWithTick:tradeItem];
        }
        
    }
}


-(void)WTSocketDidFail {
    [self reset];
}


-(void)WTSocketDidClosed {
    [self reset];
}

@end
