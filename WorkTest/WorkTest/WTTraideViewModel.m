//
//  WTTraideViewModel.m
//  WorkTest
//
//  Created by Anton Krivchicov on 22.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import "WTTraideViewModel.h"
#import "WTTradeDataSourceProtocol.h"
#import "WTTradeItem.h"
#import "WTTraiderView.h"

@interface WTTraideViewModel () {
    id<WTTradeDataSourceProtocol> _dataSource;
    WTTraiderView *_view;
    UIView *_targetView;
}

@end


@implementation WTTraideViewModel

-(instancetype)initWithDataSource:(id<WTTradeDataSourceProtocol>)dataSource
                       targetView:(UIView *)aTargetView {
    if (self = [super init]) {
        _dataSource = dataSource;
        _view = [WTTraiderView new];
        _targetView = aTargetView;
        [_dataSource setDataSourceDelegate:self];
    }
    return self;
}


-(void)setupUI {
    _view.translatesAutoresizingMaskIntoConstraints = NO;
    [_targetView addSubview:_view];
    
    [NSLayoutConstraint constraintWithItem:_targetView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_targetView attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f].active = YES;
    [NSLayoutConstraint constraintWithItem:_targetView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_targetView attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0.0f].active = YES;
    [NSLayoutConstraint constraintWithItem:_targetView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_targetView attribute:NSLayoutAttributeRight multiplier:1.0f constant:0.0f].active = YES;
    [NSLayoutConstraint constraintWithItem:_targetView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_targetView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f].active = YES;

}

#pragma DataSource delegate 

-(void)newCandleIsCome:(WTTradeItem *)item {
    
}

@end
