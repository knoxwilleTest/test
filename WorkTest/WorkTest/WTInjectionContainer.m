//
//  WTInjectionContainer.m
//  WorkTest
//
//  Created by Anton Krivchicov on 21.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import "WTInjectionContainer.h"
#import "WTNetworkService.h"
#import "WTTradeDataSource.h"
#import "WTReachability.h"

@implementation WTInjectionContainer

- (id<WTNetworkServiceProtocol>)networkService {
    static id<WTNetworkServiceProtocol> networkService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkService = [[WTNetworkService alloc] initWithInjection:self url:@"wss://quotes.exness.com:18400/"];
        
    });
    return networkService;
}


- (id<WTTradeDataSourceProtocol>)tradeDataSource {
    static id<WTTradeDataSourceProtocol> traideDataSource = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        traideDataSource = [[WTTradeDataSource alloc] initWithInjection:self];
        
    });
    return traideDataSource;
}


- (id<WTReachabilityProtocol>)reachibility {
    static id<WTReachabilityProtocol> reachibility = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        reachibility = [[WTReachability alloc] init];
        
    });
    return reachibility;
}


@end

WTInjectionContainer *injectorContainer() {
    static WTInjectionContainer * injectorContainer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        injectorContainer = [[WTInjectionContainer alloc] init];
        
    });
    return injectorContainer;
}
