//
//  WTTraiderView.h
//  WorkTest
//
//  Created by Anton Krivchicov on 22.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
    class for showin candles 
    consist from scrollview, top and bottom views
 */

extern CGFloat kTopBottomViewHeigth;

@interface WTTraiderView : UIView

@property(nonatomic, strong) UIView *scrollViewContainerView;
@property(nonatomic, strong) UIScrollView *scrollView;

-(void)attachToView:(UIView *)targetView rightView:(UIView *)rightView;

-(void)updateScrollViewContentSizeWithcCandleWidth:(CGFloat)candleWidth;

-(void)updateScrollViewContainerViewWithNewDeviceOrientation:(UIDeviceOrientation)orientation;

-(void)updateDottedNet;

-(void)addTimeLabelUnderCandle:(UIView *)candleView dateText:(NSString *)text;

@end
