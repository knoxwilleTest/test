//
//  WTNetworkService.m
//  WorkTest
//
//  Created by Anton Krivchicov on 21.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import "WTNetworkService.h"
#import "WTTradeItem.h"
#import "WTTradeDataSource.h"
#import <Endian.h>
#import "PSWebSocket.h"
#import "Reachability.h"
#import "WTReachability.h"

@interface WTNetworkService()<PSWebSocketDelegate> {
    id<WTNetworkServiceInjection> _injection;
    __weak id<WTNetworkServiceDelegate> _delegate;
}

@property (nonatomic, strong) PSWebSocket *socket;

@end

@implementation WTNetworkService

- (instancetype)initWithInjection:(id<WTNetworkServiceInjection>)injection url:(NSString *)url {
    if (self = [super init]) {
        _injection = injection;
        [[_injection reachibility] startNotifier];
    }
    return self;
}


-(void)setDelegate:(id<WTNetworkServiceDelegate>)delegate {
    if (delegate == _delegate) {
        return;
    }
    _delegate = delegate;
    if (delegate) {
        [self connect];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNetworkChange:) name:kReachabilityChangedNotification object:nil];
    }
    else {
        [self reset];
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}



-(void)handleNetworkChange:(NSNotification *)notice {
    if ([_injection.reachibility isInternetConnected]) {
        [self connect];
    }
    else {
        [self reset];
    }
}


-(void)reset {
    [self.socket close];
    self.socket = nil;
}


-(void)connect {
    if (_delegate) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"wss://quotes.exness.com:18400/"]];
        
        // create the socket and assign delegate
        self.socket = [PSWebSocket clientSocketWithRequest:request];
        self.socket.delegate = self;
        
        // open socket
        [self.socket open];
    }
}

-(id<WTNetworkServiceDelegate>)delegate {
    return _delegate;
}


-(void)subscribe {
    [self.socket send:@"SUBSCRIBE: BTCUSD"];
}


- (void)webSocketDidOpen:(PSWebSocket *)webSocket {
    NSLog(@"The websocket handshake completed and is now open!");
    [_delegate WTSocketOpen];
}


- (void)webSocket:(PSWebSocket *)webSocket didReceiveMessage:(id)message {
    [_delegate WTSocketDidReceiveMessage:[message dataUsingEncoding:NSUTF8StringEncoding]];
}


- (void)webSocket:(PSWebSocket *)webSocket didFailWithError:(NSError *)error {
    [_delegate WTSocketDidFail];
    NSLog(@"The websocket handshake/connection failed with an error: %@", error);
}


- (void)webSocket:(PSWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    [_delegate WTSocketDidClosed];
    NSLog(@"The websocket closed with code: %@, reason: %@, wasClean: %@", @(code), reason, (wasClean) ? @"YES" : @"NO");
    
}

@end
