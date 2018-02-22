//
//  OrderCreateController.h
//  Outsourcing
//
//  Created by 李文华 on 2017/6/26.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "BaseViewController.h"

@interface OrderCreateController : BaseViewController

@property (nonatomic,strong) NSString *        orderId;


- (void)orderGetDetail:(id)responseObj;

- (void)resultOfClearing:(id)responseObj;


@end
