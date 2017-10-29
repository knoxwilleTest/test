//
//  WTNoInternetConnectionBanner.m
//  WorkTest
//
//  Created by Anton Krivchicov on 29.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import "WTNoInternetConnectionBanner.h"

CGFloat defaultNoConnectionBannerHeight = 24;

@implementation WTNoInternetConnectionBanner

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        [self setupView];
    }
    return self;
}


-(void)setupView {
    UILabel *textlabel = [UILabel new];
    textlabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:textlabel];
    
    textlabel.textColor = [UIColor whiteColor];
    textlabel.font = [UIFont systemFontOfSize:12];
    textlabel.text = NSLocalizedString(@"Please check your internet connection", @"Please check your internet connection");
    [NSLayoutConstraint constraintWithItem:textlabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0].active = YES;
    [NSLayoutConstraint constraintWithItem:textlabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0].active = YES;
}

@end
