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

@implementation WTInjectionContainer

- (id<WTNetworkServiceProtocol>)networkService {
    static id<WTNetworkServiceProtocol> networkService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkService = [[WTNetworkService alloc] initWithInjection:self];
        
    });
    return networkService;
}


- (id<WTTradeDataSourceProtocol>)tradeDataSource {
    static id<WTTradeDataSourceProtocol> traideDataSource = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        traideDataSource = [[WTTradeDataSource alloc] init];
        
    });
    return traideDataSource;
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
