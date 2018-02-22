//
//  WaterTicketViewController.h
//  Outsourcing
//
//  Created by 李文华 on 2017/6/14.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "BaseViewController.h"

@interface WaterTicketViewController : BaseViewController

- (void)sendRequestHttp;


- (void)getTicketList:(id)responseObj;
//

- (void)getUserTicketList:(id)responseObj;

@end
