//
//  OrderDetailViewController.h
//  Outsourcing
//
//  Created by 李文华 on 2017/9/16.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "BaseViewController.h"

@interface OrderDetailViewController : BaseViewController


@property (nonatomic,strong) NSString *        orderId;

- (void)orderGetDetail:(id)responseObj;

- (void)setPayNstateResult:(id)responseObject;


@end
