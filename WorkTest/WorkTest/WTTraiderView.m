//
//  WTTraiderView.m
//  WorkTest
//
//  Created by Anton Krivchicov on 22.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import "WTTraiderView.h"
#import "UIColor+WTColors.h"
#import "WTDottedBackgroundView.h"

CGFloat kTopBottomViewHeigth = 20.0f;
static const CGFloat kContainerTopBottomOffest = 6.0f;

@interface WTTraiderView() {
    UIView *_topView;
    UIView *_bottomView;
    WTDottedBackgroundView *_dottedView;
}



@end


@implementation WTTraiderView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor costsViewBackGroundColor];
        [self addDottedBackGround];
        
        self.scrollView = [UIScrollView new];
        self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        self.scrollView.backgroundColor = [UIColor clearColor];
        [_dottedView addSubview:self.scrollView];
        
        self.scrollViewContainerView = [UIView new];
        self.scrollViewContainerView.backgroundColor = [UIColor clearColor];
        [self.scrollView addSubview:self.scrollViewContainerView];
        
        [self setupLayout];
    }
    return self;
}


-(void)updateDottedNet {
    [_dottedView updateUIWithTargetView:_dottedView];
}


-(void)addTopView {
    _topView = [UIView new];
    _topView.translatesAutoresizingMaskIntoConstraints = NO;
    _topView.backgroundColor = [UIColor costsViewBackGroundColor];
    [self addSubview:_topView];
}


-(void)addBottomView {
    _bottomView = [UIView new];
    _bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    _bottomView.backgroundColor = [UIColor costsViewBackGroundColor];
    [self addSubview:_bottomView];
}


-(void)addDottedBackGround {
    _dottedView = [WTDottedBackgroundView new];
    _dottedView.translatesAutoresizingMaskIntoConstraints = NO;
    _dottedView.backgroundColor = [UIColor blackColor];
    [self addSubview:_dottedView];
}


-(void)setupLayout {
    [self addTopView];
    [self addBottomView];
    
    [NSLayoutConstraint constraintWithItem:_topView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f].active = YES;
    [NSLayoutConstraint constraintWithItem:_topView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0.0f].active = YES;
    [NSLayoutConstraint constraintWithItem:_topView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0f constant:0.0f].active = YES;
    [NSLayoutConstraint constraintWithItem:_topView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0f constant:kTopBottomViewHeigth].active = YES;

    [NSLayoutConstraint constraintWithItem:_bottomView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f].active = YES;
    [NSLayoutConstraint constraintWithItem:_bottomView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0.0f].active = YES;
    [NSLayoutConstraint constraintWithItem:_bottomView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0f constant:0.0f].active = YES;
    [NSLayoutConstraint constraintWithItem:_bottomView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0f constant:kTopBottomViewHeigth].active = YES;
    
    //layout net
    [NSLayoutConstraint constraintWithItem:_dottedView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_topView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f].active = YES;
    [NSLayoutConstraint constraintWithItem:_dottedView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0.0f].active = YES;
    [NSLayoutConstraint constraintWithItem:_dottedView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0f constant:0.0f].active = YES;
    [NSLayoutConstraint constraintWithItem:_dottedView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_bottomView attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f].active = YES;
    
    //layout scroll view
    [NSLayoutConstraint constraintWithItem:self.scrollView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_dottedView attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f].active = YES;
    [NSLayoutConstraint constraintWithItem:self.scrollView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_dottedView attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0.0f].active = YES;
    [NSLayoutConstraint constraintWithItem:self.scrollView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_dottedView attribute:NSLayoutAttributeRight multiplier:1.0f constant:0.0f].active = YES;
    [NSLayoutConstraint constraintWithItem:self.scrollView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_dottedView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f].active = YES;
}


-(void)layoutSubviews {
    [super layoutSubviews];
    [self updateDottedNet];
}


-(void)attachToView:(UIView *)targetView rightView:(UIView *)rightView {
    //attach self to superview - right 
    [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:targetView attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f].active = YES;
    [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:targetView attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0.0f].active = YES;
    [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:rightView attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0.0f].active = YES;
    [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:targetView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f].active = YES;
    
}


-(void)updateScrollViewContentSizeWithcCandleWidth:(CGFloat)candleWidth {
    self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width + candleWidth, CGRectGetHeight(self.scrollView.frame));
    self.scrollViewContainerView.frame = CGRectMake(0,
                                                    CGRectGetMinY(self.scrollView.frame)  + kContainerTopBottomOffest / 2,
                                                    self.scrollView.contentSize.width,
                                                    self.scrollView.contentSize.height - kContainerTopBottomOffest);
    
    self.scrollView.contentOffset = CGPointMake(self.scrollView.contentSize.width - CGRectGetWidth(self.scrollView.frame) , 0);
}


-(void)updateScrollViewContainerViewWithNewDeviceOrientation:(UIDeviceOrientation)orientation {
    BOOL isPortrait = UIDeviceOrientationIsPortrait(orientation);
    if (isPortrait) {
        self.scrollViewContainerView.frame = CGRectMake(0,
                                                        CGRectGetMinY(self.scrollView.frame) + kContainerTopBottomOffest / 2,
                                                        self.scrollView.contentSize.width,
                                                        MAX(self.scrollView.frame.size.width, self.scrollView.frame.size.height) - kContainerTopBottomOffest);
    }
    else {
        self.scrollViewContainerView.frame = CGRectMake(0,
                                                        CGRectGetMinY(self.scrollView.frame)  + kContainerTopBottomOffest / 2,
                                                        self.scrollView.contentSize.width,
                                                        MIN(self.scrollView.frame.size.width, self.scrollView.frame.size.height) - kContainerTopBottomOffest);
    }
    self.scrollView.contentOffset = CGPointMake(self.scrollView.contentSize.width - CGRectGetWidth(self.scrollView.frame) , 0);
    
}


-(void)addTimeLabelUnderCandle:(UIView *)candleView dateText:(NSString *)text {
    UILabel *timelabel = [UILabel new];
    timelabel.translatesAutoresizingMaskIntoConstraints = NO;
    timelabel.textColor = [UIColor whiteColor];
    timelabel.text = text;
    timelabel.font = [UIFont systemFontOfSize:6];
    [self addSubview:timelabel];
    
    [NSLayoutConstraint constraintWithItem:timelabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:candleView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f].active = YES;
    [NSLayoutConstraint constraintWithItem:timelabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-5.0f].active = YES;
    
    
}
-(void)dealloc {
    
}

@end
