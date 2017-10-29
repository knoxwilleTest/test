//
//  WTTraidersCandlesViewModel.h
//  WorkTest
//
//  Created by Anton Krivchicov on 22.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
    this class are calculating view properties for candle
    depends from costs model that caching max and min current costs
    calculate view properties for candle
 */

@class WTCandleModel;
@class WTTraiderCostsViewModel;
@class WTTraidersCandlesView;
@class WTTraidersCandlesViewModel;

extern CGFloat kCandleWidth;
extern CGFloat kDistanceBeetwenCandles;

@interface WTTraidersCandlesViewModel : NSObject

@property (nonatomic, strong) NSLayoutConstraint *heightConstraint;
@property (nonatomic, strong) WTCandleModel *candleItem;

-(instancetype)initWithTradeItem:(WTCandleModel *)candle maxViewWidth:(CGFloat)width;
-(void)updateViewWithTradeItem:(WTCandleModel *)item;

-(void)attachViewToTargetView:(UIView *)targetView prevCandle:(WTTraidersCandlesViewModel *)prevCandle calculatingWithCostsModel:(WTTraiderCostsViewModel *)costsModel;

-(void)calculateViewSizeWithCostsModel:(WTTraiderCostsViewModel *)costsModel targetView:(UIView *)targetView withAnimation:(BOOL)withAnimation;

-(WTTraidersCandlesView *)view;

-(void)updateRightConstraintWithConstraint:(NSLayoutConstraint *)constraint;

@end
