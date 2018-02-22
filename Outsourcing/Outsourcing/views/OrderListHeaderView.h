//
//  OrderListHeaderView.h
//  Outsourcing
//
//  Created by 李文华 on 2017/9/12.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

@interface OrderListHeaderView : UIView

@property (weak, nonatomic) IBOutlet UILabel *oCreateTime;

@property (weak, nonatomic) IBOutlet UILabel *oNumber;

@property (weak, nonatomic) IBOutlet UILabel *oStatus;

- (void)fitDataWithModel:(OrderModel *)model;

@end
