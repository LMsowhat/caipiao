//
//  AddressViewController.h
//  Outsourcing
//
//  Created by 李文华 on 2017/8/16.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "BaseViewController.h"

@interface AddressViewController : BaseViewController

@property (nonatomic,assign) BOOL          isSelectedAddress;

@property (nonatomic,copy) void(^passAddress)(NSDictionary *);


- (void)getMyAddressList:(id)responseObj;

- (void)resultOfSetDefault:(id)responseObj;

- (void)resultOfDeleteAddress:(id)responseObj;



@end
