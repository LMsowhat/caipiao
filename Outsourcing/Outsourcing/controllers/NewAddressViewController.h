//
//  NewAddressViewController.h
//  Outsourcing
//
//  Created by 李文华 on 2017/8/21.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "BaseViewController.h"

@interface NewAddressViewController : BaseViewController

@property (nonatomic,strong) NSDictionary *        addressDict;

- (void)getAddressArea:(id)responseObj;

- (void)addNewAddressResult:(id)responseObj;

- (void)setupAddressResult:(id)responseObj;

@end
