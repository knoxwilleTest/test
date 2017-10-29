//
//  WTTradeDataSource.h
//  WorkTest
//
//  Created by Anton Krivchicov on 22.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTTradeDataSourceProtocol.h"

/*
    data source for trade model
    after setting delegate getting data from server is started
    data goes in delegate (for current project its WTTradeViewModel
 */

@protocol WTNetworkServiceProtocol;

@protocol WTTradeDataSourceInjection<NSObject>

- (id<WTNetworkServiceProtocol>)networkService;

@end

@interface WTTradeDataSource : NSObject<WTTradeDataSourceProtocol>

-(instancetype)initWithInjection:(id<WTTradeDataSourceInjection>)injection;

- (instancetype)init __attribute__((unavailable("dont use init, use initWithInjection")));

@end
