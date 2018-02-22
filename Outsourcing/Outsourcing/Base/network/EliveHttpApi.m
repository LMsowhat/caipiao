//
//  EliveHttpApi.m
//  Eliveapp
//
//  Created by 李文华 on 2017/4/20.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "EliveHttpApi.h"
#import "AFNetWorkManagerConfig.h"
#import "AFNetworking.h"
#import "MBProgressHUDManager.h"

@implementation EliveHttpApi

-(id)init{

    self = [super init];

    return self;
}

- (void)dealWithError:(NSError *)error Task:(NSURLSessionDataTask *)task {

    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
    
    

}

/**
 发送验证码

 @param params 参数
 @param result 回调函数
 */
- (void)requestSendCodeGetDataWithParameters:(NSDictionary *)params result:(void (^)(id responseObject))result{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[@"strMobile"] = params[@"strMobile"];
    parameters[@"type"] = params[@"type"];
    
    [AFNetWorkManagerConfig POST:@"common/sendSms" baseURL:URLHOST params:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        result(responseObject);
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];


}

/**
 注册

 @param params 参数
 @param result 回调函数
 */
- (void)requestRegistersGetDataWithParameters:(NSDictionary *)params result:(void (^)(id responseObject))result{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[@"strMobile"] = params[@"strMobile"];
    parameters[@"strPassword"] = params[@"strPassword"];
    parameters[@"strUserSmsCode"] = params[@"strUserSmsCode"];
    
    [AFNetWorkManagerConfig POST:@"buyer/register" baseURL:URLHOST params:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        result(responseObject);
        
        NSLog(@"%@",responseObject[@"result"]);
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
}


/**
 登录

 @param params 参数
 @param result 回调函数
 */
- (void)requestLoginGetDataWithParameters:(NSDictionary *)params result:(void (^)(id responseObject))result{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[@"strMobile"] = params[@"strMobile"];
    parameters[@"strPassword"] = params[@"strPassword"];
    parameters[@"nDeviceType"] = @"0";
    
    [AFNetWorkManagerConfig POST:@"buyer/login" baseURL:URLHOST params:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        result(responseObject);
        
        NSLog(@"%@",responseObject);
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
}

/**
 修改密码

 @param params 参数
 @param result 回调函数
 */
- (void)requestUserUpdatePassWork:(NSDictionary *)params result:(void (^)(id responseObject))result{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[@"strMobile"] = params[@"strMobile"];
    parameters[@"strPassword"] = params[@"strPassword"];
    parameters[@"lUserId"] = [UserTools getUserId];
    parameters[@"strUserSmsCode"] = params[@"strUserSmsCode"];
    parameters[@"strPasswordOld"] = params[@"strPasswordOld"];
    
    [AFNetWorkManagerConfig POST:@"buyer/modifyPassword" baseURL:URLHOST params:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        result(responseObject);
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];

}


/**
 获取用户信息

 @param params 参数
 @param result 回调函数
 */
- (void)requestGetUserInfo:(NSDictionary *)params result:(void (^)(id responseObject))result{

    [AFNetWorkManagerConfig GET:[NSString stringWithFormat:@"buyer/detail/%@",params[@"userId"]] baseURL:URLHOST params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        result(responseObject);
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];

}


/**
 获取用户地址列表

 @param params 参数
 @param result 回调函数
 */
- (void)requestGetUserAddressListWithParameters:(NSDictionary *)params result:(void (^)(id responseObject))result{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[@"lUserId"] = params[@"lUserId"];
    parameters[@"nMaxNum"] = params[@"nMaxNum"];
    parameters[@"nPage"] = params[@"nPage"];
    
    [AFNetWorkManagerConfig POST:@"address/list" baseURL:URLHOST params:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        result(responseObject);
        
        NSLog(@"%@",responseObject);
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];

}

/**
 新增地址

 @param params 参数
 @param result 回调函数
 */
- (void)requestAddUserAddressWithParameters:(NSDictionary *)params result:(void (^)(id responseObject))result{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    parameters[@"lUserid"] = params[@"lUserid"];
    parameters[@"strReceiptusername"] = params[@"strReceiptusername"];
    parameters[@"strReceiptmobile"] = params[@"strReceiptmobile"];
    parameters[@"strLocation"] = params[@"strLocation"];
    parameters[@"strDetailaddress"] = params[@"strDetailaddress"];
    
    [AFNetWorkManagerConfig POST:@"address/add" baseURL:URLHOST params:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        result(responseObject);
        
        NSLog(@"%@",responseObject);
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
}

/**
 删除地址

 @param params 参数
 @param result 回调函数
 */
- (void)requestDeleteAddressWithParameters:(NSDictionary *)params result:(void (^)(id responseObject))result{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[@"lId"] = params[@"lId"];
    
    [AFNetWorkManagerConfig POST:@"address/delete" baseURL:URLHOST params:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        result(responseObject);
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];

}


/**
 设置默认地址

 @param params 参数
 @param result 回调函数
 */
- (void)requestSetDefultAddressWithParameters:(NSDictionary *)params result:(void (^)(id responseObject))result{
 
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[@"lId"] = params[@"lId"];
    
    [AFNetWorkManagerConfig POST:@"address/setDefault" baseURL:URLHOST params:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        result(responseObject);
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);

    }];

}

/**
 修改地址
 
 @param params 参数
 @param result 回调函数
 */
- (void)requestSetupAddressWithParameters:(NSDictionary *)params result:(void (^)(id responseObject))result{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[@"lId"] = params[@"lId"];
    parameters[@"strReceiptusername"] = params[@"strReceiptusername"];
    parameters[@"strReceiptmobile"] = params[@"strReceiptmobile"];
    parameters[@"strLocation"] = params[@"strLocation"];
    parameters[@"strDetailaddress"] = params[@"strDetailaddress"];

    [AFNetWorkManagerConfig POST:@"address/update" baseURL:URLHOST params:parameters success:^(NSURLSessionDataTask *task, id responseObject) {

        result(responseObject);

        NSLog(@"%@",responseObject);

    } fail:^(NSURLSessionDataTask *task, NSError *error) {

        NSLog(@"%@",error);

    }];
}


/**
 获取地址区域
 
 @param params 参数
 @param result 回调函数
 */
- (void)requestGetAddressAreaWithParameters:(NSDictionary *)params result:(void (^)(id responseObject))result{
    
    [AFNetWorkManagerConfig GET:@"shop/allLocation" baseURL:URLHOST params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        result(responseObject);
        
        NSLog(@"%@",responseObject);
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
}

/**
 轮播图

 @param params 参数
 @param result 回调函数
 */
- (void)requestHomeCarouselGetDataWithParameters:(NSDictionary *)params result:(void (^)(id responseObject))result{

    [AFNetWorkManagerConfig GET:@"activity/list" baseURL:URLHOST params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        result(responseObject);
        
        NSLog(@"%@",responseObject);
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];

}


/**
 首页商品列表

 @param params 参数
 @param result 结果回调
 */
- (void)requestHomeProducitonListRequest:(NSDictionary *)params result:(void (^)(id responseObject))result{
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[@"nPage"] = params[@"nPage"];
    parameters[@"nMaxNum"] = params[@"nMaxNum"];
    
    [AFNetWorkManagerConfig POST:@"goods/list" baseURL:URLHOST params:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        result(responseObject);
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
}

/**
 商品详情

 @param params 参数
 @param result 结果回调
 */
- (void)requestProducitonDetailRequest:(NSDictionary *)params result:(void (^)(id responseObject))result{

    NSString *urlString = [NSString stringWithFormat:@"%@/goods/detail/%@",URLHOST,params[@"goodsLid"]];
    
    [AFNetWorkManagerConfig GET:urlString params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (responseObject[@"resCode"]) {
            
            result(responseObject[@"result"]);
        }else{
            
            NSLog(@"%@",responseObject);
        }
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
    }];
    
}


/**
 提交订单

 @param params 参数
 @param result 结果回调函数
 */
- (void)requestSubmitOrdersRequest:(NSDictionary *)params result:(void (^)(id responseObject))result{
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[@"lBuyerid"] = params[@"lBuyerid"];
    parameters[@"strBuyername"] = params[@"strBuyername"];
    parameters[@"nTotalprice"] = params[@"nTotalprice"];
    parameters[@"strInvoiceheader"] = params[@"strInvoiceheader"];
    parameters[@"strRemarks"] = params[@"strRemarks"];
    parameters[@"nAddOrderType"] = params[@"nAddOrderType"];
    parameters[@"orderGoods"] = params[@"orderGoods"];

    [AFNetWorkManagerConfig POST:@"order/add" baseURL:URLHOST params:parameters success:^(NSURLSessionDataTask *task, id responseObject) {

        result(responseObject);

//        if ([responseObject[@"resCode"] isEqualToString:@"0"]) {
//            
//            result(responseObject);
//        }else{
//            
//            NSLog(@"%@",responseObject);
//        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);

    }];
    

}

/**
 获取去结算订单详情
 
 @param params 参数
 @param result 回调函数
 */
- (void)requestOrderDetailRequest:(NSDictionary *)params result:(void (^)(id responseObject))result{
    
    NSString *url = [NSString stringWithFormat:@"order/payDetail/%@",params[@"lOrderId"]];
//    NSString *url = [NSString stringWithFormat:@"order/detail/%@",params[@"lOrderId"]];
    [AFNetWorkManagerConfig GET:url baseURL:URLHOST params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        result(responseObject);

//        if ([responseObject[@"resCode"] isEqualToString:@"0"]) {
//            
//            result(responseObject);
//        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
    }];
    
    
}

/**
 获取去付款订单详情
 
 @param params 参数
 @param result 回调函数
 */
- (void)requestOrderPayDetailRequest:(NSDictionary *)params result:(void (^)(id responseObject))result{
    
//    NSString *url = [NSString stringWithFormat:@"order/payDetail/%@",params[@"lOrderId"]];
    NSString *url = [NSString stringWithFormat:@"order/detail/%@",params[@"lOrderId"]];
    [AFNetWorkManagerConfig GET:url baseURL:URLHOST params:nil success:^(NSURLSessionDataTask *task, id responseObject) {

        result(responseObject);
//
//        if ([responseObject[@"resCode"] isEqualToString:@"0"]) {
//            
//            result(responseObject);
//        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
    }];
    
    
}

/**
 去结算

 @param params 参数
 @param result 回调函数
 */
- (void)requestOrderClearingRequest:(NSDictionary *)params result:(void (^)(id responseObject))result{

//    NSString *url = [NSString stringWithFormat:@"order/settlement",params[@"lOrderId"]];
//    NSString *url = [NSString stringWithFormat:@"order/payDetail/%@",params[@"lOrderId"]];
    
    NSMutableDictionary *parametes = [NSMutableDictionary new];
    parametes[@"lId"] = params[@"lId"];//订单id
    parametes[@"lBuyerid"] = params[@"lBuyerid"];//用户id
    parametes[@"lAddressid"] = params[@"lAddressid"];//地址id
    parametes[@"strReceiptusername"] = params[@"strReceiptusername"];//收货人姓名
    parametes[@"strReceiptmobile"] = params[@"strReceiptmobile"];//电话
    parametes[@"strLocation"] = params[@"strLocation"];//所在区域
    parametes[@"strDetailaddress"] = params[@"strDetailaddress"];//详细地址
    parametes[@"strInvoiceheader "] = params[@"strInvoiceheader"];//发票抬头
    parametes[@"strRemarks"] = params[@"strRemarks"];//备注
    parametes[@"nFactPrice"] = params[@"nFactPrice"];//实际支付价格
    parametes[@"nTotalprice"] = params[@"nTotalprice"];//订单总价
    parametes[@"lMyCouponId"] = params[@"lMyCouponId"];//优惠券id
    parametes[@"nCouponPrice"] = params[@"nCouponPrice"];//优惠券金额
    parametes[@"nBucketnum"] = params[@"nBucketnum"];//押桶个数

    parametes[@"orderGoods"] = params[@"orderGoods"];//商品信息
    
    
    [AFNetWorkManagerConfig POST:@"order/settlement" baseURL:URLHOST params:parametes success:^(NSURLSessionDataTask *task, id responseObject) {

        result(responseObject);
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
    }];


}

/**
 获取我的订单列表

 @param params 参数
 @param result 回调函数
 */
- (void)requestUserOrderListRequest:(NSDictionary *)params result:(void (^)(id responseObject))result{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[@"nPage"] = params[@"nPage"];
    parameters[@"nMaxNum"] = params[@"nMaxNum"];
    parameters[@"lBuyerid"] = params[@"lBuyerid"];
    parameters[@"nState"] = params[@"nState"];
    parameters[@"lDeliveryid"] = params[@"lDeliveryid"];
    parameters[@"nSendState"] = params[@"nSendState"];
    
    [AFNetWorkManagerConfig POST:@"order/list" baseURL:URLHOST params:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        result(responseObject);

    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
}


/**
 获取用户优惠券信息

 @param params 参数
 @param result 回调函数
 */
- (void)requestGetUserCoupons:(NSDictionary *)params result:(void (^)(id responseObject))result{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[@"nPage"] = params[@"nPage"];
    parameters[@"nMaxNum"] = params[@"nMaxNum"];
    parameters[@"lUserId"] = params[@"lUserId"];
    parameters[@"nFullPrice"] = params[@"nFullPrice"];
 
    [AFNetWorkManagerConfig POST:@"coupon/list" baseURL:URLHOST params:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        result(responseObject);

    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
}

/**
 获取所有水票

 @param params 参数
 @param result 回调函数
 */
- (void)requestGetTicketList:(NSDictionary *)params result:(void (^)(id responseObject))result{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[@"nPage"] = params[@"nPage"];
    parameters[@"nMaxNum"] = params[@"nMaxNum"];
    
    [AFNetWorkManagerConfig POST:@"ticket/list" baseURL:URLHOST params:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        result(responseObject);

    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
}

/**
 获取水票详情

 @param params 参数
 @param result 回调函数
 */
- (void)requestGetTicketDetail:(NSDictionary *)params result:(void (^)(id responseObject))result{

    [AFNetWorkManagerConfig GET:[NSString stringWithFormat:@"ticket/detail/%@",params[@"lTicketId"]] baseURL:URLHOST params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        result(responseObject);

    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);

    }];
}

/**
 购买水票

 @param params 参数
 @param result 回调函数
 */
- (void)requestPayForTicket:(NSDictionary *)params result:(void (^)(id responseObject))result{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[@"lTicketConId"] = params[@"lTicketConId"];
    parameters[@"lUserid"] = params[@"lUserid"];
    parameters[@"nFactPrice"] = params[@"nFactPrice"];
    parameters[@"nCount"] = params[@"nCount"];
    
    [AFNetWorkManagerConfig POST:@"ticket/buy" baseURL:URLHOST params:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        result(responseObject);
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
}


/**
 获取用户水票列表

 @param params 参数
 @param result 回调函数
 */
- (void)requestUserGetTicketList:(NSDictionary *)params result:(void (^)(id responseObject))result{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[@"nPage"] = params[@"nPage"];
    parameters[@"nMaxNum"] = params[@"nMaxNum"];
    parameters[@"lUserId"] = params[@"lUserId"];
    
    [AFNetWorkManagerConfig POST:@"ticket/myList" baseURL:URLHOST params:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        result(responseObject);

    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];

}

/**
 添加购物车

 @param params 参数
 @param result 回调函数
 */
- (void)requestUserAddShopCart:(NSDictionary *)params result:(void (^)(id responseObject))result{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[@"strUserName"] = params[@"strUserName"];
    parameters[@"lUserId"] = params[@"lUserId"];
    parameters[@"nPrice"] = params[@"nPrice"];
    parameters[@"lGoodsId"] = params[@"lGoodsId"];
    parameters[@"strGoodsname"] = params[@"strGoodsname"];
    parameters[@"strGoodsimgurl"] = params[@"strGoodsimgurl"];
    parameters[@"strStandard"] = params[@"strStandard"];

    [AFNetWorkManagerConfig POST:@"shopping/add" baseURL:URLHOST params:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        result(responseObject);
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
}


- (void)requestAddUserFeedback:(NSDictionary *)params result:(void (^)(id responseObject))result{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[@"strContent"] = params[@"strContent"];
    parameters[@"lUserId"] = params[@"lUserId"];
    
    [AFNetWorkManagerConfig POST:@"feedback/add" baseURL:URLHOST params:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        result(responseObject);
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
}

/**
 更多

 @param params 参数
 @param result 回调函数
 */
- (void)requestSettingGetMore:(NSDictionary *)params result:(void (^)(id responseObject))result{

    [AFNetWorkManagerConfig GET:[NSString stringWithFormat:@"sysvalue/con/%@",params[@"nType"]] baseURL:URLHOST params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        result(responseObject);
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
}

/**
 获取第三方支付Orderstring

 @param params 参数
 @param result 回调函数
 */
- (void)requestGetPayOrderString:(NSDictionary *)params result:(void (^)(id responseObject))result{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[@"lId"] = params[@"lId"];
    parameters[@"nOrderType"] = params[@"nOrderType"];
    parameters[@"nPayType"] = params[@"nPayType"];
    
    [AFNetWorkManagerConfig POST:@"pay/alipay.do" baseURL:URLHOST params:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        result(responseObject);
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
}

/**
 获取购物车列表

 @param params 参数
 @param result 回调函数
 */
- (void)requestShoppingChartList:(NSDictionary *)params result:(void (^)(id responseObject))result{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[@"lUserId"] = params[@"lUserId"];
    
    [AFNetWorkManagerConfig POST:@"shopping/myList" baseURL:URLHOST params:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        result(responseObject);
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
}

/**
 删除购物车商品

 @param params 参数
 @param result 回调函数
 */
- (void)requestShoppingDeleteProduction:(NSDictionary *)params result:(void (^)(id responseObject))result{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[@"lId"] = params[@"lId"];
    
    [AFNetWorkManagerConfig POST:@"shopping/delete" baseURL:URLHOST params:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        result(responseObject);
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
}

/**
 全部水票支付

 @param params 参数
 @param result 回调函数
 */
- (void)requestSetPayNstate:(NSDictionary *)params result:(void (^)(id responseObject))result{
   
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[@"lOrderId"] = params[@"lOrderId"];
    parameters[@"nState"] = params[@"nState"];
    
    [AFNetWorkManagerConfig POST:@"order/setPayNstate" baseURL:URLHOST params:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        result(responseObject);
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
    }];
}

/**
 获取用户通知信息

 @param params 参数
 @param result 回调函数
 */
- (void)requestUserGetMessage:(NSDictionary *)params result:(void (^)(id responseObject))result{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[@"nPage"] = params[@"nPage"];
    parameters[@"nMaxNum"] = params[@"nMaxNum"];
    parameters[@"lUserId"] = params[@"lUserId"];
    
    [AFNetWorkManagerConfig POST:@"notice/myList" baseURL:URLHOST params:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        result(responseObject);
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
}


/**
 获取我的桶个数

 @param params 参数
 @param result 回调函数
 */
- (void)requestUserGetBucketNum:(NSDictionary *)params result:(void (^)(id responseObject))result{

    [AFNetWorkManagerConfig GET:[NSString stringWithFormat:@"buyer/myBucket/%@",params[@"userId"]] baseURL:URLHOST params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        result(responseObject);
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
}


/**
 退桶

 @param params 参数
 @param result 回调函数
 */
- (void)requestUserGetRefundBucket:(NSDictionary *)params result:(void (^)(id responseObject))result{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[@"lUserId"] = params[@"lUserId"];
    parameters[@"strUserName"] = params[@"strUserName"];
    parameters[@"nBucketNum"] = params[@"nBucketNum"];
    
    [AFNetWorkManagerConfig POST:@"buyer/retreatBucket" baseURL:URLHOST params:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        result(responseObject);
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
}

/**
 删除订单

 @param params 参数
 @param result 回调函数
 */
- (void)requestUserDeleteOrder:(NSDictionary *)params result:(void (^)(id responseObject))result{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[@"lOrderId"] = params[@"lOrderId"];
    
    [AFNetWorkManagerConfig POST:@"order/delete" baseURL:URLHOST params:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        result(responseObject);
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
}

/**
 员工立即配送

 @param params 参数
 @param result 回调函数
 */
- (void)requestEmploeeJustSendOrder:(NSDictionary *)params result:(void (^)(id responseObject))result{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[@"lOrderId"] = params[@"lOrderId"];
    parameters[@"lDeliveryid"] = params[@"lDeliveryid"];
    parameters[@"strDeliveryname"] = params[@"strDeliveryname"];
    
    [AFNetWorkManagerConfig POST:@"order/confirm" baseURL:URLHOST params:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        result(responseObject);
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
}



@end
