//
//  WTNetworkService.h
//  WorkTest
//
//  Created by Anton Krivchicov on 21.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTNetworkServiceProtocol.h"

/*
    class for working server
 */

@protocol WTTradeDataSourceProtocol;
@protocol WTReachabilityProtocol;
@protocol WTNetworkServiceInjection<NSObject>

- (id<WTTradeDataSourceProtocol>)tradeDataSource;
- (id<WTReachabilityProtocol>)reachibility;

@end

@interface WTNetworkService : NSObject<WTNetworkServiceProtocol>

- (instancetype)init __attribute__((unavailable("dont use init, use initWithInjection")));

- (instancetype)initWithInjection:(id<WTNetworkServiceInjection>)injection url:(NSString *)url;

@end
