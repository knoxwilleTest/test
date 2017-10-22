//
//  WTTradeDataSourceProtocol.h
//  WorkTest
//
//  Created by Anton Krivchicov on 22.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WTTradeItem;

@protocol WTTradeDataSourceDelegate

-(void)newCandleIsCome:(WTTradeItem *)item;

@end


@protocol WTTradeDataSourceProtocol

-(void)newTradeItemIsCome:(WTTradeItem *)item;
-(void)setDataSourceDelegate:(id<WTTradeDataSourceDelegate>)delegate;

@end
