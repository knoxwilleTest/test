//
//  ViewController.m
//  WorkTest
//
//  Created by Anton Krivchicov on 20.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import "ViewController.h"
#import "WTBitUsdViewController.h"
#import "WTInjectionContainer.h"
#import "WTNetworkService.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"GO" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:button];
    
    [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0].active = YES;
    [button addTarget:self action:@selector(showBitUsdController) forControlEvents:UIControlEventTouchUpInside];
}


-(void)showBitUsdController {
    WTBitUsdViewController *vc = [[WTBitUsdViewController alloc] initWithInjection:injectorContainer()];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
