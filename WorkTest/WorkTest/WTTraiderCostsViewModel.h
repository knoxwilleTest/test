//
//  WTTraiderCostsViewModel.h
//  WorkTest
//
//  Created by Anton Krivchicov on 22.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WTTradeItem;
@class UIView;

@interface WTTraiderCostsViewModel : NSObject

-(void)newCandleDisplayed:(WTTradeItem *)tradeItem;
-(void)candleWasDissapered:(WTTradeItem *)tradeItem;

-(void)viewDidLayout:(UIView *)view;

@end
