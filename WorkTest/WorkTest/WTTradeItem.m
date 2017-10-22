//
//  WTTradeItem.m
//  WorkTest
//
//  Created by Anton Krivchicov on 22.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import "WTTradeItem.h"

@implementation WTTradeItem

-(double)maxValue {
    return [self.tradeBid doubleValue];
}


-(double)minValue {
    return [self.tradeAsk doubleValue];
}


@end
