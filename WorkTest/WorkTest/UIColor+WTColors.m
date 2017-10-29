//
//  UIColor+WTColors.m
//  WorkTest
//
//  Created by Anton Krivchicov on 22.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import "UIColor+WTColors.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation UIColor(WTColors)

#pragma mark right costs view

+(UIColor *)costsViewBackGroundColor {
    return UIColorFromRGB(0x2b2937);
}


+(UIColor *)tradeViewBackGroundColor {
    return [UIColor blackColor];
}

+(UIColor *)costsViewColor {
    return [UIColor whiteColor];
}


+(UIColor *)candleIdleBackgroundColor {
    return UIColorFromRGB(0x00bcb6);
}


+(UIColor *)candleHightLiteBackGroundColor {
    return UIColorFromRGB(0x2b2937);
}


+(UIColor *)tradeBackColor {
    return [UIColor redColor];
}

@end
