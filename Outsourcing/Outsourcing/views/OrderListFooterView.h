//
//  OrderListFooterView.h
//  Outsourcing
//
//  Created by 李文华 on 2017/9/12.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

@interface OrderListFooterView : UIView

@property (weak, nonatomic) IBOutlet UILabel *bPrice;

@property (weak, nonatomic) IBOutlet UILabel *oTotalPrice;

@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@property (weak, nonatomic) IBOutlet UIButton *payButton;

@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@property (weak, nonatomic) IBOutlet UIButton *followOrder;




- (void)fitDataWithModel:(OrderModel *)model;

@end
