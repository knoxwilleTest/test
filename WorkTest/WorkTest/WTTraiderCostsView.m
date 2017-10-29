//
//  WTTraiderCostsView.m
//  WorkTest
//
//  Created by Anton Krivchicov on 22.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import "WTTraiderCostsView.h"
#import "UIColor+WTColors.h"

static const CGFloat kLabelDistance = 30.0f;

@interface WTTraiderCostsView() {
    NSMutableArray<NSLayoutConstraint *> *_contraints;
}

@end


@implementation WTTraiderCostsView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        _costLabels = [NSMutableArray new];
        _contraints = [NSMutableArray new];
    }
    return self;
}


-(void)layoutSubviews {
    [super layoutSubviews];
}


-(void)layoutCosts {
    NSInteger countLabels = ceil(CGRectGetHeight(self.frame) / kLabelDistance) - 1;
    
    if (countLabels != _costLabels.count) { // perfomance issue
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        [_costLabels removeAllObjects];
        for (int index = 0; index < countLabels; index++) {
            UILabel *label = [UILabel new];
            label.textColor = [self costLabelTextColor];
            label.font = [self costLabelFont];
            label.translatesAutoresizingMaskIntoConstraints = NO;
            [self addSubview:label];
            [_costLabels addObject:label];
        }
        [self layoutForCurrentOrientation];
    }
}


-(void)layoutForCurrentOrientation {
    CGFloat labelDistance = kLabelDistance;
    [_contraints removeAllObjects];
    __block UILabel *prevView;
    [_costLabels enumerateObjectsUsingBlock:^(__kindof UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLayoutConstraint *topConstraint = nil;
        if (!prevView) {
            topConstraint = [NSLayoutConstraint constraintWithItem:obj attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0f constant:labelDistance];
        }
        else {
            topConstraint = [NSLayoutConstraint constraintWithItem:obj attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:prevView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:labelDistance];
        }
        NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:obj attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0];
        [_contraints addObject:topConstraint];
        [_contraints addObject:centerXConstraint];
        prevView = obj;
    }];
    [_contraints enumerateObjectsUsingBlock:^(NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.active = YES;
    }];
}


-(UIFont *)costLabelFont {
    return [UIFont systemFontOfSize:9];
};


-(UIColor *)costLabelTextColor {
    return [UIColor costsViewColor];
}


-(void)dealloc {
    
}

@end
