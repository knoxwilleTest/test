//
//  WTBitUsdViewController.h
//  WorkTest
//
//  Created by Anton Krivchicov on 22.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WTBitUsdInjection;

@interface WTBitUsdViewController : UIViewController

-(instancetype)initWithInjection:(id<WTBitUsdInjection>)injection;

@end
