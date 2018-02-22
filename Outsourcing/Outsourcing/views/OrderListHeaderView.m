//
//  OrderListHeaderView.m
//  Outsourcing
//
//  Created by 李文华 on 2017/9/12.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "OrderListHeaderView.h"

@implementation OrderListHeaderView

- (void)fitDataWithModel:(OrderModel *)model{

    self.oCreateTime.text = [NSString stringWithFormat:@"下单时间：%@",[CommonTools getTimeFromString:model.dtCreatetime]];

    self.oNumber.text = [NSString stringWithFormat:@"订单号：%@",model.strOrdernum];

    if (model.nState == 3) {

        self.oStatus.text = @"已支付";
    }else if (model.nState == 4){
        
        self.oStatus.text = @"超时关闭";
    }else{
    
        self.oStatus.text = @"未支付";
    }

    if ([UserTools userEmployeesId]) {
        
        self.oStatus.hidden = YES;
    }
}



@end
