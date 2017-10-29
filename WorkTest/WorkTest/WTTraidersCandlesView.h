//
//  WTTraidersCandlesView.h
//  WorkTest
//
//  Created by Anton Krivchicov on 22.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 this class only for showing candle view
 */

@interface WTTraidersCandlesView : UIView

@property (nonatomic, strong) NSLayoutConstraint *centerViewTopConstraint;
@property (nonatomic, strong) NSLayoutConstraint *centerViewBottomConstraint;

@property (nonatomic, strong) NSLayoutConstraint *bottomViewHeightConstraint;

@property (nonatomic, strong) NSLayoutConstraint *topOffsetConstraint;
@property (nonatomic, strong) NSLayoutConstraint *bottomOffsetConstraint;

@property (nonatomic, strong) UIColor *topViewBackgroundColor;
@property (nonatomic, strong) UIColor *centerViewBackgroundColor;
@property (nonatomic, strong) UIColor *bottomViewBackgroundColor;

-(void)hightlightView;
-(void)setupLayout;

@end
