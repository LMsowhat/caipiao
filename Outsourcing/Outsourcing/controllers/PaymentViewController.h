//
//  PaymentViewController.h
//  Outsourcing
//
//  Created by 李文华 on 2017/8/11.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "BaseViewController.h"
#import "OrderModel.h"


@interface PaymentViewController : BaseViewController

@property (nonatomic,assign) BOOL          isTicketPay;

@property (nonatomic,assign) CGFloat          factTotalPrice;//需要支付的价格
@property (nonatomic,copy) NSString *         nOrderType;//订单类型 0 购买桶装水  1 水票购买
@property (nonatomic,copy) NSString *         orderId;// 订单id

@property (nonatomic,strong) OrderModel *     orderModel;//订单模型


- (void)getAliPayOrderString:(id)responseObject;

- (void)getWechatPayOrderString:(id)responseObject;

@end
