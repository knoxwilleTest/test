//
//  WTTraiderCostsView.h
//  WorkTest
//
//  Created by Anton Krivchicov on 22.10.17.
//  Copyright © 2017 Anton Krivchicov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTTraiderCostsView : UIView

-(void)layoutWithLabelsCount:(NSInteger)labelCount;

@property (nonatomic, strong) NSMutableArray<UILabel *> *costLabels;

@end
