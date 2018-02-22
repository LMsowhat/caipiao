//
//  ProductionModel.h
//  Outsourcing
//
//  Created by 李文华 on 2017/6/14.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductionModel : NSObject


@property (nonatomic,strong) NSString *        lId;//商品ID
@property (nonatomic,strong) NSString *        nGoodstype;
@property (nonatomic,strong) NSString *        nMothnumber;//每月销量
@property (nonatomic,strong) NSString *        nOnline;
@property (nonatomic,strong) NSString *        nPrice;//商品价格，以分为单位，显示时除以100，以元为单位
@property (nonatomic,strong) NSString *        nStock;//库存
@property (nonatomic,strong) NSString *        strGoodsimgurl;
@property (nonatomic,strong) NSString *        strGoodsname;//商品名称
@property (nonatomic,strong) NSString *        strIntroduce;
@property (nonatomic,strong) NSString *        strRemarks;//首页显示简介，优惠信息等
@property (nonatomic,strong) NSString *        strStandard;//规格

//订单里商品的模型补充
@property (nonatomic,strong) NSString *        nCount;//商品数量
@property (nonatomic,strong) NSString *        lGoodsid;//商品ID


@end
