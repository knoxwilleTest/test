//
//  WTTraideViewModel.h
//  WorkTest
//
//  Created by Anton Krivchicov on 22.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTTradeDataSourceProtocol.h"

@class UIView;

@protocol WTTradeDataSourceProtocol;

@interface WTTraideViewModel : NSObject<WTTradeDataSourceDelegate>

-(instancetype)initWithDataSource:(id<WTTradeDataSourceProtocol>)dataSource
                       targetView:(UIView *)aTargetView;

-(void)setupUI;

@end
