//
//  WTDottedBackgroundView.m
//  WorkTest
//
//  Created by Anton Krivchicov on 28.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import "WTDottedBackgroundView.h"
#import "WTDottedLineView.h"

static const CGFloat kLineDistance = 30.0f; // distance beetwen lines
static const CGFloat kLineWidth = 1.0f;

@interface WTDottedBackgroundView() {
    NSMutableArray<UIView *> *_lineViews;
    NSMutableArray<NSLayoutConstraint *> *_lineConstraints;
}

@end


@implementation WTDottedBackgroundView


-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _lineViews = [NSMutableArray new];
        _lineConstraints = [NSMutableArray new];
    }
    return self;
}


-(void)updateUIWithTargetView:(UIView *)targetView {
    [_lineConstraints enumerateObjectsUsingBlock:^(NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.active = NO;
    }];
    [_lineViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [_lineConstraints removeAllObjects];
    [_lineViews removeAllObjects];
    
    NSInteger countHorizontalLines = ceil(CGRectGetHeight(targetView.frame) / kLineDistance);
    NSInteger countVerticalLines = ceil(CGRectGetWidth(targetView.frame) / kLineDistance);
    
    WTDottedLineView *prevHorizontalLine = nil;
    for (int i = 0; i < countHorizontalLines; i++) {
        WTDottedLineView *horizontalLine = [[WTDottedLineView alloc] initWithColor:[UIColor grayColor]];
        horizontalLine.translatesAutoresizingMaskIntoConstraints = NO;
        [self insertSubview:horizontalLine atIndex:0];
        [_lineViews addObject:horizontalLine];
        
        if (prevHorizontalLine) {
            [_lineConstraints addObject:[NSLayoutConstraint constraintWithItem:horizontalLine attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:prevHorizontalLine attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:kLineDistance]];
        }
        else {
            [_lineConstraints addObject:[NSLayoutConstraint constraintWithItem:horizontalLine attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0f constant:kLineDistance]];
        }
        [_lineConstraints addObject:[NSLayoutConstraint constraintWithItem:horizontalLine attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:targetView attribute:NSLayoutAttributeRight multiplier:1.0f constant:0]];
        [_lineConstraints addObject:[NSLayoutConstraint constraintWithItem:horizontalLine attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:targetView attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0]];
        [_lineConstraints addObject:[NSLayoutConstraint constraintWithItem:horizontalLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:kLineWidth]];
        
        prevHorizontalLine = horizontalLine;
    }
    WTDottedLineView *prevVerticalLine = nil;
    for (int i = 0; i < countVerticalLines; i++) {
        WTDottedLineView *verticalLine = [[WTDottedLineView alloc] initWithColor:[UIColor grayColor]];
        verticalLine.translatesAutoresizingMaskIntoConstraints = NO;
        [self insertSubview:verticalLine atIndex:0];
        [_lineViews addObject:verticalLine];
        
        if (prevVerticalLine) {
            [_lineConstraints addObject:[NSLayoutConstraint constraintWithItem:verticalLine attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:prevVerticalLine attribute:NSLayoutAttributeLeft multiplier:1.0f constant:-kLineDistance]];
        }
        else {
            [_lineConstraints addObject:[NSLayoutConstraint constraintWithItem:verticalLine attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0f constant:-kLineDistance]];
        }
        [_lineConstraints addObject:[NSLayoutConstraint constraintWithItem:verticalLine attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:targetView attribute:NSLayoutAttributeTop multiplier:1.0f constant:0]];
        [_lineConstraints addObject:[NSLayoutConstraint constraintWithItem:verticalLine attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:targetView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0]];
        [_lineConstraints addObject:[NSLayoutConstraint constraintWithItem:verticalLine attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:kLineWidth]];
        
        prevVerticalLine = verticalLine;
    }

    [_lineConstraints enumerateObjectsUsingBlock:^(NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.active = YES;
    }];
}


-(void)attachToView:(UIView *)targetView {
    [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:targetView attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f].active = YES;
    [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:targetView attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0.0f].active = YES;
    [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:targetView attribute:NSLayoutAttributeRight multiplier:1.0f constant:0.0f].active = YES;
    [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:targetView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f].active = YES;
}

@end
