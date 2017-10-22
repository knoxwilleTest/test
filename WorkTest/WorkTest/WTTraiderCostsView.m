//
//  WTTraiderCostsView.m
//  WorkTest
//
//  Created by Anton Krivchicov on 22.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import "WTTraiderCostsView.h"

@interface WTTraiderCostsView() {
    NSInteger _labelsCount;
}

@end


@implementation WTTraiderCostsView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        _costLabels = [NSMutableArray new];
    }
    return self;
}


-(void)layoutWithLabelsCount:(NSInteger)labelCount {
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    [_costLabels removeAllObjects];
    
    for (int index = 0; index < labelCount; index++) {
        UILabel *label = [UILabel new];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:label];
        [_costLabels addObject:label];
    }
    _labelsCount = labelCount;
}


-(void)layoutSubviews {
    //layout cost labels
    //if top label is exist bottom label relate to top label, if no its first label and he relates to top
    
    CGFloat labelDistance = ceil(CGRectGetHeight(self.frame) / _labelsCount);
    
    __block UILabel *prevView;
    [_costLabels enumerateObjectsUsingBlock:^(__kindof UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (!prevView) {
            [NSLayoutConstraint constraintWithItem:obj attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0f constant:labelDistance].active = YES;
        }
        else {
            [NSLayoutConstraint constraintWithItem:obj attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:prevView attribute:NSLayoutAttributeTop multiplier:1.0f constant:labelDistance].active = YES;
        }
        [NSLayoutConstraint constraintWithItem:obj attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0];
        prevView = obj;
    }];
}

@end
