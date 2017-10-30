//
//  WTReachability.m
//  WorkTest
//
//  Created by Anton Krivchicov on 29.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import "WTReachability.h"
#import "Reachability.h"

@interface WTReachability () {
    Reachability *_reachability;
}

@end

@implementation WTReachability

-(instancetype)init {
    if (self = [super init]) {
        _reachability = [Reachability reachabilityForInternetConnection];
        [_reachability startNotifier];
    }
    return self;
}


- (BOOL)isInternetConnected {
    NetworkStatus networkStatus = [_reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}


- (void)startNotifier {
    [_reachability startNotifier];
}


@end
