//
//  WTNetworkService.h
//  WorkTest
//
//  Created by Anton Krivchicov on 21.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTNetworkServiceProtocol.h"

@protocol WTTradeDataSourceProtocol;

@protocol WTNetworkServiceInjection<NSObject>

- (id<WTTradeDataSourceProtocol>)tradeDataSource;

@end

@interface WTNetworkService : NSObject<WTNetworkServiceProtocol>

- (instancetype)init __attribute__((unavailable("dont use init, use initWithInjection")));

- (instancetype)initWithInjection:(id<WTNetworkServiceInjection>)injection;

@end
