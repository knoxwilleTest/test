//
//  ViewController.m
//  WorkTest
//
//  Created by Anton Krivchicov on 20.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import "ViewController.h"
#import "WTTraideViewModel.h"
#import "WTInjectionContainer.h"
#import "WTTradeDataSource.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    WTTraideViewModel *traideViewModel = [[WTTraideViewModel alloc] initWithDataSource:injectorContainer().tradeDataSource targetView:self.view];
    [traideViewModel setupUI];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
