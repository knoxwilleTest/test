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

static  NSString *kServerAdress = @"quotes.exness.com";
static  UInt32 kPort = 18400;

@interface WTNetworkService()<NSStreamDelegate> {
    CFReadStreamRef _readStream;
    CFWriteStreamRef _writeStream;
    
    NSInputStream *_inputStream;
    NSOutputStream *_outputStream;
    
    id<WTNetworkServiceInjection> _injection;
}

@end

@implementation WTNetworkService


-(instancetype)initWithInjection:(id<WTNetworkServiceInjection>)injection {
    if (self = [super init]) {
        _injection = injection;
    }
    return self;
}


-(void)connect {
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)CFBridgingRetain(kServerAdress),
                                       kPort, &readStream, &writeStream);
    _inputStream = (__bridge NSInputStream *)readStream;
    _outputStream = (__bridge NSOutputStream *)writeStream;
    [_inputStream setDelegate:self]; [_outputStream setDelegate:self];
    [_inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [_outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [_inputStream open]; [_outputStream open];
    [self sendMessage];
}


- (void)sendMessage {
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    request.HTTPMethod = @"POST";
    NSString *res = @"SUBSCRIBE: BTCUSD";
    NSData *dt = [[NSData alloc] initWithData:[res dataUsingEncoding:NSASCIIStringEncoding]];
    request.HTTPBody = dt;
    
    uint32_t length = (uint32_t)htonl([dt length]);
    // Don't forget to check the return value of 'write'
    [_outputStream write:(uint8_t *)&length maxLength:4];
    [_outputStream write:[dt bytes] maxLength:length];
}

#pragma mark NSStreamDelegate

- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)event {
    switch(event) {
        case NSStreamEventHasSpaceAvailable: {
            if(stream == _outputStream) {
                NSLog(@"outputStream is ready.");
            }
            break;
        }
        case NSStreamEventHasBytesAvailable: {
            if(stream == _inputStream) {
                NSLog(@"inputStream is ready.");
                uint8_t buf[1024];
                long len = 0;
                len = [_inputStream read:buf maxLength:1024];
                BOOL bytesAvailable = [_inputStream hasBytesAvailable];
                if(len > 0) {
                    NSMutableData* data=[[NSMutableData alloc] initWithLength:0];
                    [data appendBytes: (const void *)buf length:len];
                    NSString *s = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                    [self readIn:s];
                }
                WTTradeItem *tradeItem = [WTTradeItem new];
                tradeItem.tradeAsk = @"4958.714";
                tradeItem.tradeBid = @"4957.351";
                [_injection.tradeDataSource newTradeItemIsCome:tradeItem];
            
            } 
            break;
        }
        case NSStreamEventErrorOccurred: {
            NSError* error = [stream streamError];
            NSString* errorMessage = [NSString stringWithFormat:@"%@ (Code = %ld",
                                      [error localizedDescription],
                                      [error code]];
        }
            break;
        default: {
            NSLog(@"Stream is sending an Event: %i", event);
            
            break;
        }
    }
    
    NSLog(@"Stream triggered.");
}


- (void)readIn:(NSString *)s {
    NSLog(@"Reading in the following:");
    NSLog(@"%@", s);
}

@end
