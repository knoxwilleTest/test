//
//  WTTraiderCostsViewModel.h
//  WorkTest
//
//  Created by Anton Krivchicov on 22.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
    class are caching max and min costs for current session
    calculating the list of costs depending from current screen height
 */

@class WTCandleModel;

typedef void (^WTTraiderCostsModelUpdaterHandler) ();

@interface WTTraiderCostsViewModel : NSObject

-(void)newCandleDisplayed:(WTCandleModel *)candle;
-(void)candleWasDissapered:(WTCandleModel *)tradeItem;
-(void)updateWithVisibleCandles:(NSArray<WTCandleModel *> *)visibleCandles withCompletion:(WTTraiderCostsModelUpdaterHandler)completion;

-(void)updateUI;
-(void)attachToView:(UIView *)view topOffset:(CGFloat)topOffset bottomOffset:(CGFloat)bottomOffset;

-(UIView *)view;

@property (nonatomic, assign) double maxCost;
@property (nonatomic, assign) double minCost;

@end
