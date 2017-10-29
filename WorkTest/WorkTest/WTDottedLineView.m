//
//  WTDottedLineView.m
//  WorkTest
//
//  Created by Anton Krivchicov on 28.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import "WTDottedLineView.h"

static CGFloat const kDashedBorderWidth = (2.0f);
static CGFloat const kDashedPhase = (0.0f);
static CGFloat const kDashedLinesLength[] = {4.0f, 2.0f};
static size_t const kDashedCount = (2.0f);

@interface WTDottedLineView() {
    UIColor *_backgoundColor;
}

@end


@implementation WTDottedLineView


-(instancetype)initWithColor:(UIColor *)color {
    if (self = [super init]) {
        _backgoundColor = color;
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (CGRectGetWidth(self.frame) > CGRectGetHeight(self.frame))  {
        CGContextSetLineWidth(context, kDashedBorderWidth);
    }
    else {
        CGContextSetLineCap(context, kDashedBorderWidth);
    }
    CGContextSetStrokeColorWithColor(context, _backgoundColor.CGColor);
    
    CGContextSetLineDash(context, kDashedPhase, kDashedLinesLength, kDashedCount) ;
    
    CGContextAddRect(context, rect);
    CGContextStrokePath(context);
}

@end
