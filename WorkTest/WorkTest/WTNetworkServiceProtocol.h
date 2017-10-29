//
//  WTNetworkServiceProtocol.h
//  WorkTest
//
//  Created by Anton Krivchicov on 21.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WTNetworkServiceDelegate
-(void)WTSocketOpen;
-(void)WTSocketDidReceiveMessage:(NSData *)data;
-(void)WTSocketDidFail;
-(void)WTSocketDidClosed;
@end

@protocol WTNetworkServiceProtocol

-(void)connect;

-(void)subscribe;

@property(nonatomic, weak) id<WTNetworkServiceDelegate> delegate;

@end
