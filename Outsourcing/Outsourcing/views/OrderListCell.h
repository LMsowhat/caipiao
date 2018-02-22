//
//  OrderListCell.h
//  Outsourcing
//
//  Created by 李文华 on 2017/9/12.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductionModel.h"



@interface OrderListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *pIcon;
@property (weak, nonatomic) IBOutlet UILabel *pName;

@property (weak, nonatomic) IBOutlet UILabel *pPrice;

@property (weak, nonatomic) IBOutlet UILabel *pNum;

- (void)fitConfigWithModel:(ProductionModel *)model;

@end
