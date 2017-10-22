//
//  WTTraiderCostsViewModel.m
//  WorkTest
//
//  Created by Anton Krivchicov on 22.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import "WTTraiderCostsViewModel.h"
#import "WTTradeItem.h"
#import "WTTraiderCostsView.h"

static const NSInteger kCountOfCostLabelInPortrait = 8;
static const NSInteger kCountOfCostLabelInLandscape = 5;
static const CGFloat kCostsViewPart = 0.15f;

@interface WTTraiderCostsViewModel() {
    double _maxCost;
    double _minCost;
    WTTraiderCostsView *_view;
}

@end


@implementation WTTraiderCostsViewModel

-(instancetype)init {
    if (self = [super init]) {
        _view = [[WTTraiderCostsView alloc] initWithFrame:CGRectZero];
    }
    return self;
}


-(void)attachToView:(UIView *)view {
    _view.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:_view];
}


-(void)viewDidLayout:(UIView *)view {
    [NSLayoutConstraint constraintWithItem:_view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1.0f constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:_view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:_view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeRight multiplier:1.0f constant:0].active = YES;
    CGFloat costsViewWidth = ceil(CGRectGetWidth(view.frame) * kCostsViewPart);
    
    [NSLayoutConstraint constraintWithItem:_view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:costsViewWidth].active = YES;
}


-(void)newCandleDisplayed:(WTTradeItem *)tradeItem {
    if ([tradeItem maxValue] > _maxCost) {
        _maxCost = [tradeItem maxValue];
    }
}


-(void)candleWasDissapered:(WTTradeItem *)tradeItem {
    if ([tradeItem minValue] < _minCost) {
        _minCost = [tradeItem minValue];
    }
}

@end
