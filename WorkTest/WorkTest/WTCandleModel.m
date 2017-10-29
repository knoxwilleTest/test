//
//  WTCandleModel.m
//  WorkTest
//
//  Created by Anton Krivchicov on 25.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import "WTCandleModel.h"

@implementation WTCandleModel

-(instancetype)initWithStartValue:(double)startValue
                      finishValue:(double)finishValue
                         maxValue:(double)maxValue
                         minValue:(double)minValue
                             date:(NSDate *)date {
    if (self = [super init]) {
        _startValue = startValue;
        _finishValue = finishValue;
        _maxValue = maxValue;
        _minValue = minValue;
        _date = date;
    }
    return self;
}

@end
