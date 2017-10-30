//
//  WTReachabilityProtocol.h
//  WorkTest
//
//  Created by Anton Krivchicov on 29.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WTReachabilityProtocol

- (BOOL)isInternetConnected;

- (void)startNotifier;

@end
