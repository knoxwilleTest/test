//
//  WTInjectionContainer.h
//  WorkTest
//
//  Created by Anton Krivchicov on 21.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTNetworkService.h"
#import "WTTradeDataSource.h"
#import "WTBitUsdInjection.h"

@protocol WTNetworkServiceProtocol;
@protocol WTTradeDataSourceProtocol;
@protocol WTReachabilityProtocol;

@interface WTInjectionContainer : NSObject<WTNetworkServiceInjection,
                                           WTTradeDataSourceInjection,
                                           WTBitUsdInjection>

//service for communication with server
- (id<WTNetworkServiceProtocol>)networkService;
//data source for traing view model
- (id<WTTradeDataSourceProtocol>)tradeDataSource;
//for checking internet connection
- (id<WTReachabilityProtocol>)reachibility;

@end

WTInjectionContainer *injectorContainer();
