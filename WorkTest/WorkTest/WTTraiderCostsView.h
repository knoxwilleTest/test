//
//  WTTraiderCostsView.h
//  WorkTest
//
//  Created by Anton Krivchicov on 22.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
    class for showing right panel with current max and min costs
 */

@interface WTTraiderCostsView : UIView

-(void)layoutCosts;

@property (nonatomic, strong) NSMutableArray<UILabel *> *costLabels;

@end
