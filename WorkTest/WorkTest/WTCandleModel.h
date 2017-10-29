//
//  WTCandleModel.h
//  WorkTest
//
//  Created by Anton Krivchicov on 25.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
    candle model
    for view candle needs next params: 
    startValue - top border of canldles body
    finishValue - bottom border of candles body
    maxValue - top border of top shadow
    minValue - bottom border of bottom shadow
 */

@interface WTCandleModel : NSObject

-(instancetype)initWithStartValue:(double)startValue
                      finishValue:(double)finishValue
                         maxValue:(double)maxValue
                         minValue:(double)minValue
                             date:(NSDate *)date;

@property (nonatomic, assign) double startValue;
@property (nonatomic, assign) double finishValue;
@property (nonatomic, assign) double maxValue;
@property (nonatomic, assign) double minValue;

@property (nonatomic, strong) NSDate *date;

@end
