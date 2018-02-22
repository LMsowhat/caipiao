//
//  EliveHttpApi.h
//  Eliveapp
//
//  Created by 李文华 on 2017/4/20.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EliveHttpApi : NSObject

-(id)init;


//- (void)requestAPPCheckVersionGetData:(NSDictionary *)params result:(void (^)(id responseObject))result;
//
//
- (void)requestSendCodeGetDataWithParameters:(NSDictionary *)params result:(void (^)(id responseObject))result;
//
- (void)requestLoginGetDataWithParameters:(NSDictionary *)params result:(void (^)(id responseObject))result;
//
- (void)requestRegistersGetDataWithParameters:(NSDictionary *)params result:(void (^)(id responseObject))result;
//
- (void)requestUserUpdatePassWork:(NSDictionary *)params result:(void (^)(id responseObject))result;
//
- (void)requestGetUserInfo:(NSDictionary *)params result:(void (^)(id responseObject))result;
//
- (void)requestGetUserAddressListWithParameters:(NSDictionary *)params result:(void (^)(id responseObject))result;
//
- (void)requestAddUserAddressWithParameters:(NSDictionary *)params result:(void (^)(id responseObject))result;
//
- (void)requestSetDefultAddressWithParameters:(NSDictionary *)params result:(void (^)(id responseObject))result;
//
- (void)requestDeleteAddressWithParameters:(NSDictionary *)params result:(void (^)(id responseObject))result;
//
- (void)requestSetupAddressWithParameters:(NSDictionary *)params result:(void (^)(id responseObject))result;
//
- (void)requestGetAddressAreaWithParameters:(NSDictionary *)params result:(void (^)(id responseObject))result;
//
- (void)requestHomeCarouselGetDataWithParameters:(NSDictionary *)params result:(void (^)(id responseObject))result;

- (void)requestHomeProducitonListRequest:(NSDictionary *)params result:(void (^)(id responseObject))result;

- (void)requestProducitonDetailRequest:(NSDictionary *)params result:(void (^)(id responseObject))result;

- (void)requestSubmitOrdersRequest:(NSDictionary *)params result:(void (^)(id responseObject))result;
//
- (void)requestOrderDetailRequest:(NSDictionary *)params result:(void (^)(id responseObject))result;

- (void)requestOrderClearingRequest:(NSDictionary *)params result:(void (^)(id responseObject))result;

- (void)requestOrderPayDetailRequest:(NSDictionary *)params result:(void (^)(id responseObject))result;

- (void)requestUserOrderListRequest:(NSDictionary *)params result:(void (^)(id responseObject))result;

- (void)requestGetUserCoupons:(NSDictionary *)params result:(void (^)(id responseObject))result;

- (void)requestGetTicketList:(NSDictionary *)params result:(void (^)(id responseObject))result;

- (void)requestGetTicketDetail:(NSDictionary *)params result:(void (^)(id responseObject))result;

- (void)requestPayForTicket:(NSDictionary *)params result:(void (^)(id responseObject))result;

- (void)requestUserGetTicketList:(NSDictionary *)params result:(void (^)(id responseObject))result;

- (void)requestUserAddShopCart:(NSDictionary *)params result:(void (^)(id responseObject))result;


- (void)requestAddUserFeedback:(NSDictionary *)params result:(void (^)(id responseObject))result;

- (void)requestSettingGetMore:(NSDictionary *)params result:(void (^)(id responseObject))result;

- (void)requestGetPayOrderString:(NSDictionary *)params result:(void (^)(id responseObject))result;

- (void)requestShoppingChartList:(NSDictionary *)params result:(void (^)(id responseObject))result;

- (void)requestShoppingDeleteProduction:(NSDictionary *)params result:(void (^)(id responseObject))result;

- (void)requestSetPayNstate:(NSDictionary *)params result:(void (^)(id responseObject))result;

- (void)requestUserGetMessage:(NSDictionary *)params result:(void (^)(id responseObject))result;

- (void)requestUserGetBucketNum:(NSDictionary *)params result:(void (^)(id responseObject))result;

- (void)requestUserGetRefundBucket:(NSDictionary *)params result:(void (^)(id responseObject))result;

- (void)requestUserDeleteOrder:(NSDictionary *)params result:(void (^)(id responseObject))result;

- (void)requestEmploeeJustSendOrder:(NSDictionary *)params result:(void (^)(id responseObject))result;


@end
