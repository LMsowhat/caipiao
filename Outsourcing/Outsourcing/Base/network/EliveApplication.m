//
//  EliveApplication.m
//  Eliveapp
//
//  Created by 李文华 on 2017/4/20.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "EliveApplication.h"
#import "EliveApplication+requestMethod.h"


@implementation EliveApplication
static EliveApplication *elive;


+(EliveApplication *)shareStance{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        elive = [[EliveApplication alloc] init];
        
    });

    return elive;
}

-(void)onHttpCode:(int)httpCode WithParameters:(NSDictionary *)parms{

    switch (httpCode) {
        case kAPPCheckVersion:
        
        {
            [self requestAPPCheckVersion:parms];
        }
            
            break;

        case kUserLogoutNetWork:
            
            
            break;

        case kUserLoginNetWork:
            
        {
            [self requestLoginAction:parms];
        }
            
            break;

        case kUserRegisterNetWork:
            
        {
            [self requestRegisterAction:parms];
        }
            
            break;
            
        case kUserUpdatePassWorkNetWork:
            
        {
            [self requestUpdatePassWork:parms];
        }
            
            break;
            
        case kUserGetInfoNetWork:
            
        {
            [self requestGetUserInfo:parms];
        }
            
            break;

        case kUserSendCodeNetWork:
            
        {
            [self requestSendCodeAction:parms];
        }
            
            break;
            
        case kUserAddressNetWork:
            
        {
            [self requestGetUserAddress:parms];
        }
            
            break;

        case kUserAddNewAddressNetWork:
            
        {
            [self requestAddNewAddress:parms];
        }
            
            break;
            
        case kUserSetDefaultAddressNetWork:
            
        {
            [self requestSetDefultAddress:parms];
        }
            
            break;
            
        case kUserDeleteTheAddressNetWork:
            
        {
            [self requestDeleteTheAddress:parms];
        }
            
            break;
            
        case kUserModificationTheAddressNetWork:
            
        {
            [self requestSetupAddress:parms];
        }
            
            break;
            
        case kUserGetAddressAreaNetWork:
            
        {
            [self requestGetAddressArea:parms];
        }
            
            break;

        case kUserGetTicketListNetWork:
            
        {
            [self requestUserGetTicketList:parms];
        }
            
            break;
            
        case kHomePageCirclesNetWork:
            
        {
            [self requestHomeCarousels:parms];
        }
            break;

        case kHomePageProductionListNetWork:
        {
        
            [self requestHomeProducitonList:parms];
        }
            break;
        case kProductionDetailNetWork:
        {
            
            [self requestProducitonDetail:parms];
        }
            break;
        case kSubmitOrderNetWork:
        {
            
            [self requestSubmitOrder:parms];
        }
            break;
        case kOrderDetailNetWork:
        {
            
            [self requestGetOrderDetail:parms];
        }
            break;
            
        case kOrderClearingNetWork:
        {
            
            [self requestGoOrderClearingDetail:parms];
        }
            break;
        case kOrderDetailTwoNetWork:
        {
            
            [self requestGetPayOrderDetail:parms];
        }
            break;
            
        case kUserOrderListNetWork:
        {
            
            [self requestGetUserOrderList:parms];
        }
            break;

        case kUserGetCouponsNetWork:
        {
            
            [self requestGetUserCoupons:parms];
        }
            break;
            
        case kProductionTicketListNetWork:
        {
            
            [self requestGetTicketList:parms];
        }
            break;
            
        case kProductionTicketDetailNetWork:
        {
            
            [self requestGetTicketDetail:parms];
        }
            break;
            
        case kProductionTicketPayNetWork:
        {
            
            [self requestPayForTicket:parms];
        }
            break;
            
        case kAddShopCartNetWork:
        {
            
            [self requestAddShopCartAction:parms];
        }
            break;
            
        case kSettingGetMoreNetWork:
        {
            
            [self requestSettingGetMoreAction:parms];
        }
            break;
            
        case kUserFeedbackNetWork:
        {
            
            [self requestAddUserFeedbackAction:parms];
        }
            break;

        case kAliPayNetWork:
        {
            
            [self requestGetPayOrderString:parms];
        }
            break;
            
        case kUserGetChartListNetWork:
        {
            
            [self requestGetShpoppingList:parms];
        }
            break;
            
        case kUserDeleteFromChartNetWork:
        {
            
            [self requestShpoppingDelete:parms];
        }
            break;
            
        case kTicketallPayNetWork:
        {
            
            [self requestSetPayNstate:parms];
        }
            break;
            
        case kUserGetMessageNetWork:
        {
            
            [self requestUserGetMessage:parms];
        }
            break;
            
        case kUserGetBucketNetWork:
        {
            
            [self requestUserGetBucket:parms];
        }
            break;
            
        case kUserRefundBucketNetWork:
        {
            
            [self requestUserRefundBucket:parms];
        }
            break;
            
        case kDeleteOrderNetWork:
        {
            
            [self requestUserDeleteOrder:parms];
        }
            break;
            
        case kJustSendNetWork:
        {
            
            [self requestEmploeeJustSendOrder:parms];
        }
            break;

        default:
            break;
    }



}


@end
