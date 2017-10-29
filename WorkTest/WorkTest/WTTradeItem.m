//
//  WTTradeItem.m
//  WorkTest
//
//  Created by Anton Krivchicov on 22.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import "WTTradeItem.h"

static const NSString *kTicksKey = @"ticks";
static const NSString *kTicksAKey = @"a";
static const NSString *kTicksBKey = @"b";
static const NSString *kTicksSubscribedListKey = @"subscribed_list";

@implementation WTTradeItem

-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        NSArray *ticks = dictionary[kTicksKey];
        if (!ticks.count) {
            NSDictionary *tempDictionary = dictionary[kTicksSubscribedListKey];
            ticks = tempDictionary[kTicksKey];
        }
        if (ticks.count) {
            NSDictionary *tickDict = [ticks firstObject];
            self.tradeBid = [tickDict[kTicksBKey] doubleValue];
            self.tradeAsk = [tickDict[kTicksAKey] doubleValue];
        }
    }
    return self;
}

@end
