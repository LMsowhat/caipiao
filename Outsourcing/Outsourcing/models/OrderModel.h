//
//  OrderModel.h
//  Outsourcing
//
//  Created by 李文华 on 2017/7/8.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductionModel.h"


@interface OrderModel : NSObject

/*
 
 */
@property (nonatomic,assign) NSInteger         conState;//控制器角色 1，订单列表  2，配送单列表
@property (nonatomic,strong) NSString *        dtCreatetime;//订单创建时间
@property (nonatomic,strong) NSString *        lBuyerid;
@property (nonatomic,strong) NSString *        lId;
@property (nonatomic,strong) NSString *        lMyCouponId;
@property (nonatomic,strong) NSString *        nBucketmoney;
@property (nonatomic,strong) NSString *        nBucketnum;
@property (nonatomic,strong) NSString *        nCouponPrice;
@property (nonatomic,strong) NSString *        nFactPrice;
@property (nonatomic,assign) NSInteger         nSendState;
@property (nonatomic,assign) NSInteger         nState;
@property (nonatomic,strong) NSString *        nTotalWatertickets;
@property (nonatomic,strong) NSString *        nTotalWaterticketsPrice;
@property (nonatomic,strong) NSString *        nTotalprice;
@property (nonatomic,strong) NSString *        strBuyername;
@property (nonatomic,strong) NSString *        strInvoiceheader;
@property (nonatomic,strong) NSString *        strOrdernum;
@property (nonatomic,strong) NSString *        strReceiptusername;
@property (nonatomic,strong) NSString *        strRemarks;


@property (nonatomic,strong) ProductionModel *        orderGoods;


@end
