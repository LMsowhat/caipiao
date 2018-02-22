//
//  BuyTicketViewController.h
//  Outsourcing
//
//  Created by 李文华 on 2017/8/11.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "BaseViewController.h"

@interface BuyTicketViewController : BaseViewController

@property (nonatomic,strong) NSString *        ticketId;

- (void)getTicketDetail:(id)responseObj;

- (void)payForTicketResult:(id)responseObject;

@end
