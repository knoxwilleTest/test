//
//  WTTraideViewModel.m
//  WorkTest
//
//  Created by Anton Krivchicov on 22.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import "WTTraideViewModel.h"
#import "WTTradeDataSourceProtocol.h"
#import "WTTraiderView.h"
#import "WTTraiderCostsViewModel.h"
#import "WTTraidersCandlesViewModel.h"
#import "WTCandleModel.h"
#import "WTTraidersCandlesView.h"

static NSInteger kTimeCandleCount = 6; //show time after each 3 candles

@interface WTTraideViewModel ()<UIScrollViewDelegate> {
    id<WTTradeDataSourceProtocol> _dataSource;
    WTTraiderView *_view;
    UIView *_targetView;
    WTTraiderCostsViewModel *_costsViewModel;
    NSMutableArray<WTTraidersCandlesViewModel *> *_candleViewModels;
}

@end


@implementation WTTraideViewModel

-(instancetype)initWithDataSource:(id<WTTradeDataSourceProtocol>)dataSource
                       targetView:(UIView *)aTargetView {
    if (self = [super init]) {
        
        _dataSource = dataSource;
        _view = [WTTraiderView new];
        _view.scrollView.delegate = self;
        
        _targetView = aTargetView;
        
        _costsViewModel = [[WTTraiderCostsViewModel alloc] init];
        
        [self startObserveStrongNotifications];
        
        _candleViewModels = [NSMutableArray new];
    }
    return self;
}


-(void)startObserveStrongNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification  object:nil];
}


-(void)viewWillLayout:(UIView *)view {
    [_costsViewModel updateUI];
    [_view updateDottedNet];
}


-(void)setupUI {
    _view.translatesAutoresizingMaskIntoConstraints = NO;
    _view.backgroundColor = [UIColor grayColor];
    
    [_targetView addSubview:_view];
    [_costsViewModel attachToView:_targetView topOffset:kTopBottomViewHeigth bottomOffset:kTopBottomViewHeigth];
    [_view attachToView:_targetView rightView:[_costsViewModel view]];
}

#pragma mark DataSource delegate


-(void)updateCurrentCandleWithCandle:(WTCandleModel *)canleModel {

    WTTraidersCandlesViewModel *lastCandle = [_candleViewModels lastObject];
    [lastCandle updateViewWithTradeItem:canleModel];

    [self calculateCandlesWithNewCostsWithLastFrame:_view.scrollView.bounds withAnimation:YES];
}


-(BOOL)newCandleIsCome:(WTCandleModel *)item {
    if (CGRectEqualToRect(_view.frame, CGRectZero)) {
        return NO;
    }
    NSLog(@"New candle is come %@", item.description);
    
    [_costsViewModel newCandleDisplayed:item];
    
    //create candle view model
    WTTraidersCandlesViewModel *candleViewModel = [[WTTraidersCandlesViewModel alloc] initWithTradeItem:item maxViewWidth:kCandleWidth];
    
    
    //for candle layour prevCandleView -> newCandleView -> scrollview right border
    WTTraidersCandlesViewModel *lastCandle = nil;
    if (_candleViewModels.count) {
        lastCandle = [_candleViewModels lastObject];
    }
    
    //add new candle model to cache
    [_candleViewModels addObject:candleViewModel];
    
    [_view updateScrollViewContentSizeWithcCandleWidth:kCandleWidth + kDistanceBeetwenCandles];
    [candleViewModel attachViewToTargetView: _view.scrollViewContainerView prevCandle:lastCandle calculatingWithCostsModel:_costsViewModel];
    
    if (_candleViewModels.count % kTimeCandleCount == 0 || _candleViewModels.count == 1) {
        [_view addTimeLabelUnderCandle:[candleViewModel view] dateText:[self timestampInTextFormat:item.date]];
    }
    CGRect lastScrollFrame = _view.scrollView.bounds;
    [self calculateCandlesWithNewCostsWithLastFrame:lastScrollFrame withAnimation:NO];
    return YES;
}


#pragma mark candles calculations


-(void)calculateCandlesWithNewCostsWithLastFrame:(CGRect)rect withAnimation:(BOOL)animation{
    __block NSMutableArray<WTTraidersCandlesViewModel *> *visibleCandles = [NSMutableArray new];
    __block NSMutableArray<WTCandleModel *> *visibleCandlesDataModels = [NSMutableArray new];
    [_candleViewModels enumerateObjectsUsingBlock:^(WTTraidersCandlesViewModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (CGRectIntersectsRect(rect, [obj view].frame)) {
            [visibleCandles addObject:obj];
            [visibleCandlesDataModels addObject:obj.candleItem];
        }
        else if (CGRectEqualToRect([obj view].frame, CGRectZero)) { // only for new item
            [visibleCandles addObject:obj];
            [visibleCandlesDataModels addObject:obj.candleItem];
        }
    }];
    
    [_costsViewModel updateWithVisibleCandles:visibleCandlesDataModels withCompletion:^{
        NSLog(@"setting new max cost %g min cost %g", _costsViewModel.maxCost, _costsViewModel.minCost);
        [visibleCandles enumerateObjectsUsingBlock:^(WTTraidersCandlesViewModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == visibleCandles.count - 1) {
                [obj calculateViewSizeWithCostsModel:_costsViewModel targetView:_view.scrollViewContainerView withAnimation:animation];
            }
            else {
                [obj calculateViewSizeWithCostsModel:_costsViewModel targetView:_view.scrollViewContainerView withAnimation:NO];//updating with animation only last candle
            }
        }];
    }];
}

#pragma mark orientation changes 

- (void)orientationChanged:(NSNotification *)notification{
    [self viewWillLayout:_targetView];
    
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortraitUpsideDown) {
        return;
    }
    
    //need to frame before changing the orientation
    CGRect lastScrollFrame = CGRectMake(CGRectGetMinX(_view.scrollView.bounds),
                                        CGRectGetMinY(_view.scrollView.bounds),
                                        CGRectGetWidth(_view.scrollViewContainerView.frame),
                                        CGRectGetHeight(_view.scrollViewContainerView.frame));
    [_view updateScrollViewContainerViewWithNewDeviceOrientation:[[UIDevice currentDevice] orientation]];
    
    [self calculateCandlesWithNewCostsWithLastFrame:lastScrollFrame withAnimation:NO];
}


#pragma mark timestamp 

-(NSString *)timestampInTextFormat:(NSDate *)date {
    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
    [dateformat setDateFormat:@"MM-dd HH:mm"];
    return [dateformat stringFromDate:date];
}

#pragma mark scrollview delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self calculateCandlesWithNewCostsWithLastFrame:_view.scrollView.bounds withAnimation:NO];
}


-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
