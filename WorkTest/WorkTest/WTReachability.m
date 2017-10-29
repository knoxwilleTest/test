//
//  WTReachability.m
//  WorkTest
//
//  Created by Anton Krivchicov on 29.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import "WTReachability.h"
#import "Reachability.h"

@implementation WTReachability

- (BOOL)isInternetConnected {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}

@end
