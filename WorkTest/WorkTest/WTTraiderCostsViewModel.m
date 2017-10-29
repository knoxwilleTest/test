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
#import "UIColor+WTColors.h"
#import "WTCandleModel.h"

static const CGFloat kCostsViewWidth = 60.0f;

@interface WTTraiderCostsViewModel() {
    WTTraiderCostsView *_view;
    NSLayoutConstraint *_widthConstraint;
    NSInteger _costsLabelsCount;
}

@end


@implementation WTTraiderCostsViewModel

-(instancetype)init {
    if (self = [super init]) {
        _view = [[WTTraiderCostsView alloc] initWithFrame:CGRectZero];
        
        _view.backgroundColor = [UIColor costsViewBackGroundColor];
        _minCost = CGFLOAT_MAX;
    }
    return self;
}


-(UIView *)view {
    return (UIView *)_view;
}


-(void)attachToView:(UIView *)view topOffset:(CGFloat)topOffset bottomOffset:(CGFloat)bottomOffset {
    _view.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:_view];
    
    [NSLayoutConstraint constraintWithItem:_view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1.0f constant:topOffset].active = YES;
    [NSLayoutConstraint constraintWithItem:_view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-bottomOffset].active = YES;
    [NSLayoutConstraint constraintWithItem:_view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeRight multiplier:1.0f constant:0].active = YES;
    
    _widthConstraint = [NSLayoutConstraint constraintWithItem:_view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeRight multiplier:1.0f constant:0];
    _widthConstraint.active = YES;
    
    _widthConstraint.constant = -kCostsViewWidth;
    [self updateUI];
}


-(void)updateUI {
    [_view layoutCosts];
    [self calculateCosts];
}


-(void)newCandleDisplayed:(WTCandleModel *)candle {
    if (candle.maxValue > _maxCost) {
        self.maxCost = candle.maxValue;
    }
    if (candle.minValue < _minCost) {
        self.minCost = candle.minValue;
    }
    [self calculateCosts];
    
}


-(void)updateWithVisibleCandles:(NSArray<WTCandleModel *> *)visibleCandles withCompletion:(WTTraiderCostsModelUpdaterHandler)completion {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSArray *descriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"maxValue" ascending:NO]];
        NSArray *sortedArray = [visibleCandles sortedArrayUsingDescriptors:descriptors];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"maxValue >= %g", 0];
        NSArray<WTCandleModel *> *filteredArray = [sortedArray filteredArrayUsingPredicate:predicate];
        if (filteredArray.count) {
            self.maxCost = [filteredArray firstObject].maxValue;
            NSLog(@"setting new max value %g", self.maxCost);
        }
        
        descriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"minValue" ascending:NO]];
        sortedArray = [visibleCandles sortedArrayUsingDescriptors:descriptors];
        predicate = [NSPredicate predicateWithFormat:@"minValue <= %g", CGFLOAT_MAX];
        filteredArray = [sortedArray filteredArrayUsingPredicate:predicate];
        if (filteredArray.count) {
            self.minCost = [filteredArray lastObject].minValue;
            NSLog(@"setting new min value %g", self.minCost);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion();
            }
            [self calculateCosts];
        });
    });
}


-(void)calculateCosts {
    if (!_maxCost) {
        return;
    }
    [_view layoutCosts];
    __block CGFloat costOfffset = (self.maxCost - self.minCost) / _view.costLabels.count;
    [_view.costLabels enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.text = [NSString stringWithFormat:@"%0.3f", _maxCost - idx * costOfffset];
    }];
}


-(void)candleWasDissapered:(WTCandleModel *)tradeItem {
    if ([tradeItem minValue] < _minCost) {
        _minCost = [tradeItem minValue];
    }
}


-(void)dealloc {
    
}

@end
