//
//  WTTradeItem.h
//  WorkTest
//
//  Created by Anton Krivchicov on 22.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import <Foundation/Foundation.h>

/* 
    class for tick from server
    tick example:
    {"ticks":[{"s":"BTCUSD","b":"4957.351","bf":0,"a":"4958.714","af":1,"spr":"1.4"}]}
 */

@interface WTTradeItem : NSObject

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, assign) double tradeBid;
@property (nonatomic, assign) double tradeAsk;


@end
