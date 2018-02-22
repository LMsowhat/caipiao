//
//  OrdersViewController.h
//  Outsourcing
//
//  Created by 李文华 on 2017/6/14.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "BaseViewController.h"

@interface OrdersViewController : BaseViewController

- (void)getUserOrderList:(id)responseObj;

- (void)deleteOrderResult:(id)responseObject;

@end
