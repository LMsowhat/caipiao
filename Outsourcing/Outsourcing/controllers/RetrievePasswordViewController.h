//
//  RetrievePasswordViewController.h
//  Outsourcing
//
//  Created by 李文华 on 2017/8/7.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "BaseViewController.h"

@interface RetrievePasswordViewController : BaseViewController

- (void)registerSendCodeGetData:(NSDictionary *)data;

- (void)resultOfGetBackPasswork:(id)responseObject;

@end
