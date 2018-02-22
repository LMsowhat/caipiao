//
//  EmployeeDetailController.h
//  Outsourcing
//
//  Created by 李文华 on 2017/9/28.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "BaseViewController.h"

@interface EmployeeDetailController : BaseViewController

@property (nonatomic,strong) NSString *        orderId;

@property (nonatomic,assign) BOOL          isFinished;

- (void)deliveryGetDetail:(id)responseObj;

- (void)actionToSendResult:(id)responseObject;


@end
