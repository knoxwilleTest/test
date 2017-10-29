//
//  WTBitUsdInjection.h
//  WorkTest
//
//  Created by Anton Krivchicov on 29.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WTTradeDataSourceProtocol;
@protocol WTReachabilityProtocol;

//injection for trade view model

@protocol WTBitUsdInjection <NSObject>

- (id<WTTradeDataSourceProtocol>)tradeDataSource;
- (id<WTReachabilityProtocol>)reachibility;

@end
