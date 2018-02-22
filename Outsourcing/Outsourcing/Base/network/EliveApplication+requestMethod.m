//
//  EliveApplication+requestMethod.m
//  Eliveapp
//
//  Created by 李文华 on 2017/4/20.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "EliveApplication+requestMethod.h"
#import "EliveHttpApi.h"

#import "HomeViewController.h"
#import "ProductionDetailViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "OrderCreateController.h"
#import "AddressViewController.h"
#import "NewAddressViewController.h"
#import "MyTicketViewController.h"
#import "CouponsViewController.h"
#import "BuyTicketViewController.h"
#import "WaterTicketViewController.h"
#import "OrdersViewController.h"
#import "OrderDetailViewController.h"
#import "FeedbackViewController.h"
#import "ServerViewController.h"
#import "AboutUsViewController.h"
#import "RetrieveViewController.h"
#import "PaymentViewController.h"
#import "ShoppingCartController.h"
#import "MyMessageViewController.h"
#import "EmployeeViewController.h"
#import "MyViewController.h"
#import "MyBarrelViewController.h"
#import "RetrieveViewController.h"
#import "RetrievePasswordViewController.h"
#import "EmployeeDetailController.h"

@implementation EliveApplication (requestMethod)

- (void)requestSendCodeAction:(NSDictionary*)parm{

    EliveHttpApi *api = [EliveHttpApi new];
    
    UIViewController *controller = [parm objectForKey:kCurrentController];
    
    [api requestSendCodeGetDataWithParameters:parm result:^(id responseObject) {
        
        if ([controller isKindOfClass:[RegisterViewController class]]) {
            
            RegisterViewController *registers = [parm objectForKey:kCurrentController];
            
            if (responseObject) {
                
                [registers registerSendCodeGetData:responseObject];
            }
        }
        if ([controller isKindOfClass:[RetrievePasswordViewController class]]) {
            
            RetrievePasswordViewController *registers = [parm objectForKey:kCurrentController];
            
            if (responseObject) {
                
                [registers registerSendCodeGetData:responseObject];
            }
        }
    }];
}

- (void)requestRegisterAction:(NSDictionary*)parm{
    
    EliveHttpApi *api = [EliveHttpApi new];
    
    UIViewController *controller = [parm objectForKey:kCurrentController];
    
    [api requestRegistersGetDataWithParameters:parm result:^(id responseObject) {
        
        if ([controller isKindOfClass:[RegisterViewController class]]) {
            
            RegisterViewController *registers = [parm objectForKey:kCurrentController];
            
            if (responseObject) {
                
                [registers registerGetData:responseObject];
            }
        }
        
    }];
    
}

- (void)requestLoginAction:(NSDictionary*)parm{
    
    EliveHttpApi *api = [EliveHttpApi new];
    
    UIViewController *controller = [parm objectForKey:kCurrentController];
    
    [api requestLoginGetDataWithParameters:parm result:^(id responseObject) {
        
        if ([controller isKindOfClass:[LoginViewController class]]) {
            
            LoginViewController *login = [parm objectForKey:kCurrentController];
            
            if (responseObject) {
                
                [login loginGetData:responseObject];
            }
        }
        
    }];
}

- (void)requestUpdatePassWork:(NSDictionary*)parm{

    EliveHttpApi *api = [EliveHttpApi new];
    
    UIViewController *controller = [parm objectForKey:kCurrentController];
    
    [api requestUserUpdatePassWork:parm result:^(id responseObject) {
        
        if ([controller isKindOfClass:[RetrieveViewController class]]) {
            
            RetrieveViewController *retrieve = [parm objectForKey:kCurrentController];
            
            if (responseObject) {
                
                [retrieve resultOfUpdatePasswork:responseObject];
            }
        }
        if ([controller isKindOfClass:[RetrievePasswordViewController class]]) {
            
            RetrievePasswordViewController *retrieve = [parm objectForKey:kCurrentController];
            
            if (responseObject) {
                
                [retrieve resultOfGetBackPasswork:responseObject];
            }
        }
        
    }];

}


- (void)requestGetUserInfo:(NSDictionary*)parm{

    EliveHttpApi *api = [EliveHttpApi new];
    
    UIViewController *controller = [parm objectForKey:kCurrentController];
    
    [api requestGetUserInfo:parm result:^(id responseObject) {
        
        if ([controller isKindOfClass:[MyViewController class]]) {
            
            MyViewController *myView = [parm objectForKey:kCurrentController];
            
            if (responseObject) {
                
                [myView getMyInfo:responseObject];
            }
        }
        
    }];
}


- (void)requestGetUserAddress:(NSDictionary*)parm{

    EliveHttpApi *api = [EliveHttpApi new];
    
    UIViewController *controller = [parm objectForKey:kCurrentController];
    
    [api requestGetUserAddressListWithParameters:parm result:^(id responseObject) {
        
        if ([controller isKindOfClass:[AddressViewController class]]) {
            
            AddressViewController *address = [parm objectForKey:kCurrentController];
            
            if (responseObject) {
                
                [address getMyAddressList:responseObject];
            }
        }
        
    }];

}

- (void)requestAddNewAddress:(NSDictionary*)parm{

    EliveHttpApi *api = [EliveHttpApi new];
    
    UIViewController *controller = [parm objectForKey:kCurrentController];
    
    [api requestAddUserAddressWithParameters:parm result:^(id responseObject) {
        
        if ([controller isKindOfClass:[NewAddressViewController class]]) {
            
            NewAddressViewController *newAddress = [parm objectForKey:kCurrentController];
            
            if (responseObject) {
                
                [newAddress addNewAddressResult:responseObject];
            }
        }
        
    }];

}

- (void)requestSetDefultAddress:(NSDictionary*)parm{

    EliveHttpApi *api = [EliveHttpApi new];
    
    UIViewController *controller = [parm objectForKey:kCurrentController];
    
    [api requestSetDefultAddressWithParameters:parm result:^(id responseObject) {
        
        if ([controller isKindOfClass:[AddressViewController class]]) {
            
            AddressViewController *address = [parm objectForKey:kCurrentController];
            
            if (responseObject) {
                
                [address resultOfSetDefault:responseObject];
            }
        }
        
    }];
}

- (void)requestDeleteTheAddress:(NSDictionary*)parm{

    EliveHttpApi *api = [EliveHttpApi new];
    
    UIViewController *controller = [parm objectForKey:kCurrentController];
    
    [api requestDeleteAddressWithParameters:parm result:^(id responseObject) {
        
        if ([controller isKindOfClass:[AddressViewController class]]) {
            
            AddressViewController *address = [parm objectForKey:kCurrentController];
            
            if (responseObject) {
                
                [address resultOfDeleteAddress:responseObject];
            }
        }
        
    }];
}

- (void)requestSetupAddress:(NSDictionary*)parm{

    EliveHttpApi *api = [EliveHttpApi new];
    
    UIViewController *controller = [parm objectForKey:kCurrentController];
    
    [api requestSetupAddressWithParameters:parm result:^(id responseObject) {
        
        if ([controller isKindOfClass:[NewAddressViewController class]]) {
            
            NewAddressViewController *newAddress = [parm objectForKey:kCurrentController];
            
            if (responseObject) {
                
                [newAddress setupAddressResult:responseObject];
            }
        }
        
    }];
}


- (void)requestGetAddressArea:(NSDictionary*)parm{

    EliveHttpApi *api = [EliveHttpApi new];
    
    UIViewController *controller = [parm objectForKey:kCurrentController];
    
    [api requestGetAddressAreaWithParameters:parm result:^(id responseObject) {
        
        if ([controller isKindOfClass:[NewAddressViewController class]]) {
            
            NewAddressViewController *newAddress = [parm objectForKey:kCurrentController];
            
            if (responseObject) {
                
                [newAddress getAddressArea:responseObject];
            }
        }
        
    }];

}

- (void)requestHomeCarousels:(NSDictionary*)parm{

    EliveHttpApi *api = [EliveHttpApi new];
    
    UIViewController *controller = [parm objectForKey:kCurrentController];
    
    [api requestHomeCarouselGetDataWithParameters:nil result:^(id responseObject) {
        
        if ([controller isKindOfClass:[HomeViewController class]]) {
            
            HomeViewController *home = [parm objectForKey:kCurrentController];
            
            if (responseObject) {
                
                [home circlesGetData:responseObject];
            }
        }
        
    }];
}


- (void)requestHomeProducitonList:(NSDictionary*)parm{

    EliveHttpApi *api = [EliveHttpApi new];
    
    UIViewController *controller = [parm objectForKey:kCurrentController];
    
    [api requestHomeProducitonListRequest:parm result:^(id responseObject) {
        
        if ([controller isKindOfClass:[HomeViewController class]]) {
            
            HomeViewController *home = [parm objectForKey:kCurrentController];
            
            if (responseObject) {
                
                [home productionListGetData:responseObject];
            }
        }
        
    }];
    
}

- (void)requestProducitonDetail:(NSDictionary*)parm{

    EliveHttpApi *api = [EliveHttpApi new];
    
    UIViewController *controller = [parm objectForKey:kCurrentController];
    
    [api requestProducitonDetailRequest:parm result:^(id responseObject) {
        
        if ([controller isKindOfClass:[ProductionDetailViewController class]]) {
            
            ProductionDetailViewController *production = [parm objectForKey:kCurrentController];
            
            if (responseObject) {
                
                [production getProductionDetail:responseObject];
            }
        }
        
    }];
}

- (void)requestSubmitOrder:(NSDictionary*)parm{

    EliveHttpApi *api = [EliveHttpApi new];
    
    UIViewController *controller = [parm objectForKey:kCurrentController];
    
    [api requestSubmitOrdersRequest:parm result:^(id responseObject) {
        
        if ([controller isKindOfClass:[ProductionDetailViewController class]]) {
            
            ProductionDetailViewController *production = [parm objectForKey:kCurrentController];
            
            if (responseObject) {
                
                [production resultOfSubmitOrder:responseObject];
            }
        }
        if ([controller isKindOfClass:[ShoppingCartController class]]) {
            
            ShoppingCartController *shopping = [parm objectForKey:kCurrentController];
            
            if (responseObject) {
                
                [shopping resultOfSubmitOrder:responseObject];
            }
        }
    }];

}

- (void)requestGetOrderDetail:(NSDictionary*)parm{

    EliveHttpApi *api = [EliveHttpApi new];
    
    UIViewController *controller = [parm objectForKey:kCurrentController];
    
    [api requestOrderDetailRequest:parm result:^(id responseObject) {
        
        if ([controller isKindOfClass:[OrderCreateController class]]) {
            
            OrderCreateController *order = [parm objectForKey:kCurrentController];
            
            if (responseObject) {
                
                [order orderGetDetail:responseObject];
            }
        }
        
    }];

}

- (void)requestGoOrderClearingDetail:(NSDictionary*)parm{

    EliveHttpApi *api = [EliveHttpApi new];
    
    UIViewController *controller = [parm objectForKey:kCurrentController];
    
    [api requestOrderClearingRequest:parm result:^(id responseObject) {
        
        if ([controller isKindOfClass:[OrderCreateController class]]) {
            
            OrderCreateController *order = [parm objectForKey:kCurrentController];
            
            if (responseObject) {
                
                [order resultOfClearing:responseObject];
            }
        }
        
    }];

}

- (void)requestGetPayOrderDetail:(NSDictionary*)parm{

    EliveHttpApi *api = [EliveHttpApi new];
    
    UIViewController *controller = [parm objectForKey:kCurrentController];
    
    [api requestOrderPayDetailRequest:parm result:^(id responseObject) {
        
        if ([controller isKindOfClass:[OrderDetailViewController class]]) {
            
            OrderDetailViewController *payOrderDetail = [parm objectForKey:kCurrentController];
            
            if (responseObject) {
                
                [payOrderDetail orderGetDetail:responseObject];
            }
        }
        
        if ([controller isKindOfClass:[EmployeeDetailController class]]) {
            
            EmployeeDetailController *emDetail = [parm objectForKey:kCurrentController];
            
            if (responseObject) {
                
                [emDetail deliveryGetDetail:responseObject];
            }
        }
    }];


}

- (void)requestGetUserOrderList:(NSDictionary*)parm{

    EliveHttpApi *api = [EliveHttpApi new];
    
    UIViewController *controller = [parm objectForKey:kCurrentController];

    [api requestUserOrderListRequest:parm result:^(id responseObject) {
        
        if ([controller isKindOfClass:[OrdersViewController class]]) {
            
            OrdersViewController *orderList = [parm objectForKey:kCurrentController];
            
            [orderList getUserOrderList:responseObject];
            
        }
        if ([controller isKindOfClass:[EmployeeViewController class]]) {
            
            EmployeeViewController *orderList = [parm objectForKey:kCurrentController];
            
            [orderList getUserOrderList:responseObject];
            
        }
    }];

}

- (void)requestGetUserCoupons:(NSDictionary*)parm{

    EliveHttpApi *api = [EliveHttpApi new];
    
    UIViewController *controller = [parm objectForKey:kCurrentController];
    
    [api requestGetUserCoupons:parm result:^(id responseObject) {
        
        if ([controller isKindOfClass:[CouponsViewController class]]) {
            
            CouponsViewController *coupon = [parm objectForKey:kCurrentController];
            
            if (responseObject) {
                
                [coupon getMyCouponsData:responseObject];
            }
        }
        
    }];

}

- (void)requestGetTicketList:(NSDictionary*)parm{

    EliveHttpApi *api = [EliveHttpApi new];
    
    UIViewController *controller = [parm objectForKey:kCurrentController];
    
    [api requestGetTicketList:parm result:^(id responseObject) {
        
        if ([controller isKindOfClass:[WaterTicketViewController class]]) {
            
            WaterTicketViewController *ticket = [parm objectForKey:kCurrentController];
            
            if (responseObject) {
                
                [ticket getTicketList:responseObject];
            }
        }
        
    }];

}

- (void)requestGetTicketDetail:(NSDictionary*)parm{
    
    EliveHttpApi *api = [EliveHttpApi new];
    
    UIViewController *controller = [parm objectForKey:kCurrentController];
    
    [api requestGetTicketDetail:parm result:^(id responseObject) {
        
        if ([controller isKindOfClass:[BuyTicketViewController class]]) {
            
            BuyTicketViewController *buyTicket = [parm objectForKey:kCurrentController];
            
            if (responseObject) {
                
                [buyTicket getTicketDetail:responseObject];
            }
        }
        
    }];

}

- (void)requestPayForTicket:(NSDictionary*)parm{

    EliveHttpApi *api = [EliveHttpApi new];
    
    UIViewController *controller = [parm objectForKey:kCurrentController];
    
    [api requestPayForTicket:parm result:^(id responseObject) {
        
        if ([controller isKindOfClass:[BuyTicketViewController class]]) {
            
            BuyTicketViewController *buyTicket = [parm objectForKey:kCurrentController];
            
            if (responseObject) {
                
                [buyTicket payForTicketResult:responseObject];
            }
        }
        
    }];

}


- (void)requestUserGetTicketList:(NSDictionary*)parm{
    
    EliveHttpApi *api = [EliveHttpApi new];
    
    UIViewController *controller = [parm objectForKey:kCurrentController];
    
    [api requestUserGetTicketList:parm result:^(id responseObject) {
        
        if ([controller isKindOfClass:[WaterTicketViewController class]]) {
            
            WaterTicketViewController *ticket = [parm objectForKey:kCurrentController];
            
            if (responseObject) {
                
                [ticket getUserTicketList:responseObject];
            }
        }
        
        if ([controller isKindOfClass:[MyTicketViewController class]]) {
            
            MyTicketViewController *myticket = [parm objectForKey:kCurrentController];
            
            if (responseObject) {
                
                [myticket getMyTicket:responseObject];
            }
        }
    }];

}

- (void)requestAddShopCartAction:(NSDictionary*)parm{

    EliveHttpApi *api = [EliveHttpApi new];
    
    UIViewController *controller = [parm objectForKey:kCurrentController];
    
    [api requestUserAddShopCart:parm result:^(id responseObject) {
        
        if ([controller isKindOfClass:[HomeViewController class]]) {
            
            HomeViewController *home = [parm objectForKey:kCurrentController];
            
            if (responseObject) {
                
                [home userAddShopCart:responseObject];
            }
        }
        
    }];

}

- (void)requestAddUserFeedbackAction:(NSDictionary*)parm{

    EliveHttpApi *api = [EliveHttpApi new];
    
    UIViewController *controller = [parm objectForKey:kCurrentController];
    
    [api requestAddUserFeedback:parm result:^(id responseObject) {
        
        if ([controller isKindOfClass:[FeedbackViewController class]]) {
            
            FeedbackViewController *feedback = [parm objectForKey:kCurrentController];
            
            if (responseObject) {
                
                [feedback resultOfFeedback:responseObject];
            }
        }
        
    }];
}


- (void)requestSettingGetMoreAction:(NSDictionary*)parm{

    EliveHttpApi *api = [EliveHttpApi new];
    
    UIViewController *controller = [parm objectForKey:kCurrentController];
    
    [api requestSettingGetMore:parm result:^(id responseObject) {
        
        if ([controller isKindOfClass:[ServerViewController class]]) {
            
            ServerViewController *server = [parm objectForKey:kCurrentController];
            
            if (responseObject) {
                
                [server getServerContent:responseObject];
            }
        }
        
    }];
}

- (void)requestGetPayOrderString:(NSDictionary*)parm{
    
    EliveHttpApi *api = [EliveHttpApi new];
    
    UIViewController *controller = [parm objectForKey:kCurrentController];
    
    [api requestGetPayOrderString:parm result:^(id responseObject) {
        
        if ([controller isKindOfClass:[PaymentViewController class]]) {
            
            PaymentViewController *payController = [parm objectForKey:kCurrentController];
            
            if (responseObject) {
                
                if ([parm[@"nPayType"] isEqualToString:@"0"]) {
                    
                    [payController getAliPayOrderString:responseObject];
                }
                if ([parm[@"nPayType"] isEqualToString:@"1"]) {
                    
                    [payController getWechatPayOrderString:responseObject];
                }
                
            }
        }
        
    }];
}

- (void)requestGetShpoppingList:(NSDictionary*)parm{

    EliveHttpApi *api = [EliveHttpApi new];
    
    UIViewController *controller = [parm objectForKey:kCurrentController];
    
    [api requestShoppingChartList:parm result:^(id responseObject) {
        
        if ([controller isKindOfClass:[ShoppingCartController class]]) {
            
            ShoppingCartController *shoppingChart = [parm objectForKey:kCurrentController];
            
            if (responseObject) {
                
                [shoppingChart getShoppingDetail:responseObject];
                
            }
        }
    }];
}

- (void)requestShpoppingDelete:(NSDictionary*)parm{

    EliveHttpApi *api = [EliveHttpApi new];
    
    UIViewController *controller = [parm objectForKey:kCurrentController];
    
    [api requestShoppingDeleteProduction:parm result:^(id responseObject) {
        
        if ([controller isKindOfClass:[ShoppingCartController class]]) {
            
            ShoppingCartController *shoppingChart = [parm objectForKey:kCurrentController];
            
            if (responseObject) {
                
                [shoppingChart deleteProductionResult:responseObject];
                
            }
        }
    }];

}

- (void)requestSetPayNstate:(NSDictionary*)parm{

    EliveHttpApi *api = [EliveHttpApi new];
    
    UIViewController *controller = [parm objectForKey:kCurrentController];
    
    [api requestSetPayNstate:parm result:^(id responseObject) {
        
        if ([controller isKindOfClass:[OrderDetailViewController class]]) {
            
            OrderDetailViewController *orderDetail = [parm objectForKey:kCurrentController];
            
            if (responseObject) {
                
                [orderDetail setPayNstateResult:responseObject];
                
            }
        }
    }];
}

- (void)requestUserGetMessage:(NSDictionary*)parm{

    EliveHttpApi *api = [EliveHttpApi new];
    
    UIViewController *controller = [parm objectForKey:kCurrentController];
    
    [api requestUserGetMessage:parm result:^(id responseObject) {
        
        if ([controller isKindOfClass:[MyMessageViewController class]]) {
            
            MyMessageViewController *myMessage = [parm objectForKey:kCurrentController];
            
            if (responseObject) {
                
                [myMessage getMyMessageList:responseObject];
                
            }
        }
    }];

}

- (void)requestUserGetBucket:(NSDictionary*)parm{

    EliveHttpApi *api = [EliveHttpApi new];
    
    UIViewController *controller = [parm objectForKey:kCurrentController];
    
    [api requestUserGetBucketNum:parm result:^(id responseObject) {
        
        if ([controller isKindOfClass:[MyBarrelViewController class]]) {
            
            MyBarrelViewController *myBarrel = [parm objectForKey:kCurrentController];
            
            if (responseObject) {
                
                [myBarrel getMyBarrel:responseObject];
                
            }
        }
    }];
}

- (void)requestUserRefundBucket:(NSDictionary*)parm{

    EliveHttpApi *api = [EliveHttpApi new];
    
    UIViewController *controller = [parm objectForKey:kCurrentController];
    
    [api requestUserGetRefundBucket:parm result:^(id responseObject) {
        
        if ([controller isKindOfClass:[MyBarrelViewController class]]) {
            
            MyBarrelViewController *myBarrel = [parm objectForKey:kCurrentController];
            
            if (responseObject) {
                
                [myBarrel refundBucket:responseObject];
                
            }
        }
    }];
}

- (void)requestUserDeleteOrder:(NSDictionary*)parm{
    
    EliveHttpApi *api = [EliveHttpApi new];
    
    UIViewController *controller = [parm objectForKey:kCurrentController];
    
    [api requestUserDeleteOrder:parm result:^(id responseObject) {
        
        if ([controller isKindOfClass:[OrdersViewController class]]) {
            
            OrdersViewController *order = [parm objectForKey:kCurrentController];
            
            if (responseObject) {
                
                [order deleteOrderResult:responseObject];
                
            }
        }
    }];

}

- (void)requestEmploeeJustSendOrder:(NSDictionary*)parm{

    
    EliveHttpApi *api = [EliveHttpApi new];
    
    UIViewController *controller = [parm objectForKey:kCurrentController];
    
    [api requestEmploeeJustSendOrder:parm result:^(id responseObject) {
        
        if ([controller isKindOfClass:[EmployeeDetailController class]]) {
            
            EmployeeDetailController *emploee = [parm objectForKey:kCurrentController];
            
            if (responseObject) {
                
                [emploee actionToSendResult:responseObject];
                
            }
        }
    }];

}






@end
