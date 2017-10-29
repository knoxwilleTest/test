//
//  WTTraidersCandlesView.m
//  WorkTest
//
//  Created by Anton Krivchicov on 22.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import "WTTraidersCandlesView.h"
#import "UIColor+WTColors.h"

static const CGFloat kTopBottomViewsWidth = 2.0f;

@interface WTTraidersCandlesView() {
    UIView *_topView;
    UIView *_centerView;
    UIView *_higltliteCenterView;

    UIView *_bottomView;
}

@end


@implementation WTTraidersCandlesView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _topView = [UIView new];
        _centerView = [UIView new];
        _bottomView = [UIView new];
        _higltliteCenterView = [UIView new];
    }
    return self;
}


-(void)setupLayout {
    _topView.translatesAutoresizingMaskIntoConstraints = NO;
    _topView.backgroundColor = [UIColor candleIdleBackgroundColor];
    [self addSubview:_topView];
    
    _centerView.translatesAutoresizingMaskIntoConstraints = NO;
    _centerView.backgroundColor = [UIColor candleIdleBackgroundColor];
    [self addSubview:_centerView];
    
    _higltliteCenterView.translatesAutoresizingMaskIntoConstraints = NO;
    _higltliteCenterView.backgroundColor = [UIColor tradeViewBackGroundColor];
    _higltliteCenterView.hidden = YES;
    [_centerView addSubview:_higltliteCenterView];
    
    _bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    _bottomView.backgroundColor = [UIColor candleIdleBackgroundColor];
    [self addSubview:_bottomView];
    
    [NSLayoutConstraint constraintWithItem:_topView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_centerView attribute:NSLayoutAttributeTop multiplier:1.0f constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:_topView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0f constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:_topView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:_topView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:kTopBottomViewsWidth].active = YES;
    
    [NSLayoutConstraint constraintWithItem:_centerView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:_centerView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0f constant:0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:_higltliteCenterView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_centerView attribute:NSLayoutAttributeTop multiplier:1.0f constant:kTopBottomViewsWidth].active = YES;
    [NSLayoutConstraint constraintWithItem:_higltliteCenterView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_centerView attribute:NSLayoutAttributeLeft multiplier:1.0f constant:kTopBottomViewsWidth].active = YES;
    [NSLayoutConstraint constraintWithItem:_higltliteCenterView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_centerView attribute:NSLayoutAttributeRight multiplier:1.0f constant:-kTopBottomViewsWidth].active = YES;
    [NSLayoutConstraint constraintWithItem:_higltliteCenterView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_centerView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-kTopBottomViewsWidth].active = YES;
    
    [NSLayoutConstraint constraintWithItem:_bottomView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_centerView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:_bottomView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:kTopBottomViewsWidth].active = YES;
    [NSLayoutConstraint constraintWithItem:_bottomView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:_bottomView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0].active = YES;
    
    
    _centerViewTopConstraint = [NSLayoutConstraint constraintWithItem:_centerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0f constant:0];
    _centerViewBottomConstraint = [NSLayoutConstraint constraintWithItem:_centerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0];
//    _bottomViewHeightConstraint = [NSLayoutConstraint constraintWithItem:_bottomView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:0];
    
    _centerViewBottomConstraint.active = YES;
    _centerViewTopConstraint.active = YES;
    
    _topOffsetConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeTop multiplier:1.0f constant:0];
    _bottomOffsetConstraint =  [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0];
    _topOffsetConstraint.active = YES;
    _bottomOffsetConstraint.active = YES;
}


-(void)hightlightView {
    _higltliteCenterView.hidden = NO;
}


-(void)dealloc {
    
}

@end
