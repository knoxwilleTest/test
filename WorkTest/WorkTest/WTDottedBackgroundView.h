//
//  WTDottedBackgroundView.h
//  WorkTest
//
//  Created by Anton Krivchicov on 28.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
    only view with net under candles
 */

@interface WTDottedBackgroundView : UIView

-(void)attachToView:(UIView *)targetView;
-(void)updateUIWithTargetView:(UIView *)targetView;

@end
