//
//  WTBitUsdViewController.m
//  WorkTest
//
//  Created by Anton Krivchicov on 22.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import "WTBitUsdViewController.h"
#import "WTTraideViewModel.h"
#import "WTTradeDataSource.h"
#import "UIColor+WTColors.h"
#import "Reachability.h"
#import "WTBitUsdInjection.h"
#import "WTReachability.h"
#import "WTNoInternetConnectionBanner.h"

static const CGFloat animationNoConnectionBannerDuration = 0.4;

@interface WTBitUsdViewController () {
    WTTraideViewModel *_tradingViewModel;
    id<WTBitUsdInjection> _injection;
    WTNoInternetConnectionBanner *_noConnectionBanner;
    NSLayoutConstraint *_topBannerConstraint;
}

@end

@implementation WTBitUsdViewController

-(instancetype)initWithInjection:(id<WTBitUsdInjection>)injection {
    if (self = [super init]) {
        _injection = injection;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor costsViewBackGroundColor];
    //setup UI
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor costsViewBackGroundColor]];
    self.navigationItem.title = NSLocalizedString(@"BTC/USD", @"BTC/USD");
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    //start reachibily
    
    //only for no connection banner
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNetworkChange) name:kReachabilityChangedNotification object:nil];
    
    //creating model for trading view with candles
    _tradingViewModel = [[WTTraideViewModel alloc] initWithDataSource:_injection.tradeDataSource targetView:self.view];
    [_tradingViewModel setupUI];
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self handleNetworkChange];
}


-(void)handleNetworkChange {
    if (![_injection.reachibility isInternetConnected]) {
        [self showNoConnectionBanner];
    }
    else {
        [self hideNoConnectionBanner];
    }
}


-(void)showNoConnectionBanner {
    _noConnectionBanner = [WTNoInternetConnectionBanner new];
    _noConnectionBanner.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_noConnectionBanner];
    _topBannerConstraint =  [NSLayoutConstraint constraintWithItem:_noConnectionBanner attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:-defaultNoConnectionBannerHeight];
    _topBannerConstraint.active = YES;
    [NSLayoutConstraint constraintWithItem:_noConnectionBanner attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0.0f].active = YES;
    [NSLayoutConstraint constraintWithItem:_noConnectionBanner attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0f constant:0.0f].active = YES;
    [NSLayoutConstraint constraintWithItem:_noConnectionBanner attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0f constant:defaultNoConnectionBannerHeight].active = YES;
    
    [self.view layoutIfNeeded];
    
    _topBannerConstraint.constant = 0;
    [UIView animateWithDuration:animationNoConnectionBannerDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}


-(void)hideNoConnectionBanner {
    _topBannerConstraint.constant = -defaultNoConnectionBannerHeight;
    [UIView animateWithDuration:animationNoConnectionBannerDuration animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [_noConnectionBanner removeFromSuperview];
        _noConnectionBanner = nil;
    }];
    
}


-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    //start getting data only after layout
    _injection.tradeDataSource.delegate = _tradingViewModel;
}


-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //stop getting data
    _injection.tradeDataSource.delegate = nil;
}

@end
