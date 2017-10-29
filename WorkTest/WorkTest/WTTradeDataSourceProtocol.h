//
//  WTTradeDataSourceProtocol.h
//  WorkTest
//
//  Created by Anton Krivchicov on 22.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WTCandleModel;

@protocol WTTradeDataSourceDelegate

-(BOOL)newCandleIsCome:(WTCandleModel *)item; //new candle is come
-(void)updateCurrentCandleWithCandle:(WTCandleModel *)canleModel; // data for last candle updater

@end


@protocol WTTradeDataSourceProtocol

@property (nonatomic, weak) id<WTTradeDataSourceDelegate> delegate;

@end
