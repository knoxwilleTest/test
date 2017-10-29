//
//  WTTraidersCandlesViewModel.m
//  WorkTest
//
//  Created by Anton Krivchicov on 22.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import "WTTraidersCandlesViewModel.h"
#import "WTTraidersCandlesView.h"
#import "WTCandleModel.h"
#import "WTTraiderCostsViewModel.h"

CGFloat kCandleWidth = 10.0f;
CGFloat kDistanceBeetwenCandles = 3.0f;

@interface WTTraidersCandlesViewModel() {
    WTTraidersCandlesView *_view;
    NSLayoutConstraint *_candleRightConstraint;
}

@end

@implementation WTTraidersCandlesViewModel

-(instancetype)initWithTradeItem:(WTCandleModel *)candle maxViewWidth:(CGFloat)width {
    if (self = [super init]) {
        self.candleItem = candle;
        _view = [[WTTraidersCandlesView alloc] init];
    }
    return self;
}

//attach new candle to view
-(void)attachViewToTargetView:(UIView *)targetView prevCandle:(WTTraidersCandlesViewModel *)prevCandle calculatingWithCostsModel:(WTTraiderCostsViewModel *)costsModel {
    
    _view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self calculateViewSizeWithCostsModel:costsModel targetView:targetView withAnimation:NO];

    [targetView addSubview:_view];
    
    [_view setupLayout];
    
    [NSLayoutConstraint constraintWithItem:_view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:kCandleWidth].active = YES;
    
    
    _candleRightConstraint = [NSLayoutConstraint constraintWithItem:_view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:targetView attribute:NSLayoutAttributeRight multiplier:1.0f constant:-kDistanceBeetwenCandles];
    _candleRightConstraint.active = YES;
    
    if (prevCandle) {
        NSLayoutConstraint *newRightConstraint = [NSLayoutConstraint constraintWithItem:[prevCandle view] attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_view attribute:NSLayoutAttributeLeft multiplier:1.0f constant:-kDistanceBeetwenCandles];
        [prevCandle updateRightConstraintWithConstraint:newRightConstraint];
    }
}


//calculating new size of candles, depends from new max/min cost
-(void)calculateViewSizeWithCostsModel:(WTTraiderCostsViewModel *)costsModel targetView:(UIView *)targetView withAnimation:(BOOL)withAnimation {
    CGFloat targetViewheight = CGRectGetHeight(targetView.frame);
    CGFloat costDistance = costsModel.maxCost - costsModel.minCost;
    
    if (!costDistance) { //first  candle with one tick
        _view.centerViewTopConstraint.constant = 0;
        _view.centerViewBottomConstraint.constant = 0;
        return;
    }
    
    CGFloat distanceToTopInCost = costsModel.maxCost - self.candleItem.maxValue;
    CGFloat distanceToBottomInCost = costsModel.minCost - self.candleItem.minValue;
    
    CGFloat distanceCenterViewToTopInCost = self.candleItem.maxValue - MAX(self.candleItem.startValue, self.candleItem.finishValue);
    CGFloat distanceCenterViewToBottomInCost = self.candleItem.minValue - MIN(self.candleItem.startValue, self.candleItem.finishValue);

    CGFloat distanceToTop = ceil(targetViewheight * distanceToTopInCost / costDistance);
    CGFloat distanceToBottom = ceil(targetViewheight * distanceToBottomInCost / costDistance);
    
    CGFloat distanceCenterViewTop = ceil(targetViewheight * distanceCenterViewToTopInCost / costDistance);
    CGFloat distanceCenterViewBottom = ceil(targetViewheight * distanceCenterViewToBottomInCost / costDistance);

    if (distanceToTop < 0) {
        distanceToTop = distanceToTop * (-1);
    }
    if (distanceCenterViewTop < 0) {
        distanceCenterViewTop = distanceCenterViewTop * (-1);
    }
    if (distanceCenterViewBottom < 0) {
        distanceCenterViewBottom = distanceCenterViewBottom * (-1);
    }
    if (distanceToBottom < 0) {
        distanceToBottom = distanceToBottom * (-1);
    }
    
    _view.centerViewTopConstraint.constant = distanceCenterViewTop;
    _view.centerViewBottomConstraint.constant = -distanceCenterViewBottom;
    _view.bottomOffsetConstraint.constant = -distanceToBottom;
    _view.topOffsetConstraint.constant = distanceToTop;
    if (withAnimation) {
        [UIView animateWithDuration:0.3 animations:^{
            [_view layoutIfNeeded];
        }];
    }
    
    if (self.candleItem.startValue < self.candleItem.finishValue) { // if consts was rose
        [_view hightlightView];
    }
}


-(WTTraidersCandlesView *)view {
    return _view;
}


-(void)updateViewWithTradeItem:(WTCandleModel *)item {
    self.candleItem.maxValue = MAX(self.candleItem.maxValue, item.maxValue);
    self.candleItem.minValue = MIN(self.candleItem.minValue, item.minValue);
    self.candleItem.finishValue = item.finishValue;
}


-(void)updateRightConstraintWithConstraint:(NSLayoutConstraint *)constraint {
    _candleRightConstraint.active = NO;
    [self.view removeConstraint:_candleRightConstraint];
    constraint.active = YES;
}


-(NSString *)timestampInTextFormat:(NSDate *)date {
    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
    [dateformat setDateFormat:@"MM-dd HH:mm"];
    return [dateformat stringFromDate:date];
}


-(void)dealloc {
    
}

@end
