//
//  ShoppingChartCell.h
//  Outsourcing
//
//  Created by 李文华 on 2017/9/22.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingChartModel.h"


@interface ShoppingChartCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIButton *selectButton;

@property (weak, nonatomic) IBOutlet UIImageView *pIcon;

@property (weak, nonatomic) IBOutlet UILabel *pName;

@property (weak, nonatomic) IBOutlet UILabel *pSales;

@property (weak, nonatomic) IBOutlet UILabel *pPrice;

@property (weak, nonatomic) IBOutlet UILabel *pNum;

@property (weak, nonatomic) IBOutlet UIButton *substractButton;

@property (weak, nonatomic) IBOutlet UIButton *addButton;


@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

- (void)fitDataWithModel:(ShoppingChartModel *)model;

@end
