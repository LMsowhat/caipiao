//
//  OrderListTableViewCell.h
//  Outsourcing
//
//  Created by 李文华 on 2017/6/28.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"


@interface OrderListTableViewCell : UITableViewCell

@property (nonatomic,strong) UIView *        bgView;

@property (nonatomic,strong) UILabel *        createTime;//下单时间
@property (nonatomic,strong) UIView *        line1;//上面横线
@property (nonatomic,strong) UILabel *        orderNum;//订单号
@property (nonatomic,strong) UILabel *        oStatus;//订单状态
@property (nonatomic,strong) UIImageView *        oIcon;//产品图片
@property (nonatomic,strong) UILabel *        oName;//产品名称
@property (nonatomic,strong) UILabel *        oNum;//订单产品数量
@property (nonatomic,strong) UILabel *        oPrice;//订单原来价格
@property (nonatomic,strong) UILabel *        bucketMoney;//桶押金
@property (nonatomic,strong) UIView *        line2;//下面横线
@property (nonatomic,strong) UILabel *        realMoney;//实际价格

@property (nonatomic,strong) UIButton *        deleteOrderBtn;//删除订单
@property (nonatomic,strong) UIButton *        toPayBtn;//立即支付

- (void)fitDataWithModel:(OrderModel *)model;


@end
