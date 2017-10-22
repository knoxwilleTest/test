//
//  WTTradeDataSource.m
//  WorkTest
//
//  Created by Anton Krivchicov on 22.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import "WTTradeDataSource.h"
#import "WTTradeItem.h"

@interface WTTradeDataSource() {
    NSMutableSet<WTTradeItem *> *_tradeModel;
    id<WTTradeDataSourceDelegate> _delegate;
}

@end


@implementation WTTradeDataSource

-(instancetype)init {
    if (self = [super init]) {
        _tradeModel = [NSMutableSet new];
    }
    return self;
}


-(void)setDataSourceDelegate:(id<WTTradeDataSourceDelegate>)delegate {
    _delegate = delegate;
}


-(void)newTradeItemIsCome:(WTTradeItem *)item {
    [_tradeModel addObject:item];
    if (_delegate) {
        [_delegate newCandleIsCome:item];
    }
}

@end
