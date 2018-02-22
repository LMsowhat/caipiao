//
//  CouponsViewController.h
//  Outsourcing
//
//  Created by 李文华 on 2017/8/10.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "BaseViewController.h"

@interface CouponsViewController : BaseViewController

@property (nonatomic,assign) BOOL          isSelectedCoupons;
@property (nonatomic,copy)NSString *       nFullPrice;
@property (nonatomic,copy) void(^passCoupons)(NSDictionary *couponDict);

- (void)getMyCouponsData:(id)responseObj;

@end
