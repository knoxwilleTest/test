//
//  WTInjectionContainer.h
//  WorkTest
//
//  Created by Anton Krivchicov on 21.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTNetworkService.h"

@protocol WTNetworkServiceProtocol;
@protocol WTTradeDataSourceProtocol;

@interface WTInjectionContainer : NSObject<WTNetworkServiceInjection>

- (id<WTNetworkServiceProtocol>)networkService;
- (id<WTTradeDataSourceProtocol>)tradeDataSource;

@end

WTInjectionContainer *injectorContainer();
