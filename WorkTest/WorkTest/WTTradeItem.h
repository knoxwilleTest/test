//
//  WTTradeItem.h
//  WorkTest
//
//  Created by Anton Krivchicov on 22.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTTradeItem : NSObject

@property (nonatomic, strong) NSString *tradeBid;
@property (nonatomic, strong) NSString *tradeAsk;

-(double)maxValue;
-(double)minValue;

@end
