//
//  OrderListTableViewCell.m
//  Outsourcing
//
//  Created by 李文华 on 2017/6/28.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "OrderListTableViewCell.h"
#import "Masonry.h"


@implementation OrderListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = UIColorFromRGBA(0xF7F7F7, 1.0);
//        self.backgroundColor = kRedColor;

        self.bgView = [UIView new];
        self.bgView.backgroundColor = UIColorFromRGBA(0xFFFFFF, 1.0);
//        self.bgView.backgroundColor = kRedColor;
        
        self.createTime = [UILabel new];
        self.createTime.font = kFont(5.5);
        self.createTime.textColor = UIColorFromRGBA(0x8F9095, 1.0);
        self.createTime.textAlignment = NSTextAlignmentCenter;
  
        self.line1 = [UIView new];
        self.line1.backgroundColor = UIColorFromRGBA(0xDDDDDD, 1.0);
        
        self.orderNum = [UILabel new];
        self.orderNum.font = kFont(5.5);
        self.orderNum.textColor = UIColorFromRGBA(0x333338, 1.0);
        self.orderNum.textAlignment = NSTextAlignmentLeft;
        
        self.oStatus = [UILabel new];
        self.oStatus.font = kFont(5.5);
        self.oStatus.textColor = UIColorFromRGBA(0xFA6650, 1.0);
        self.oStatus.textAlignment = NSTextAlignmentCenter;
        
        self.oIcon = [UIImageView new];
        
        self.oName = [UILabel new];
        self.oName.font = kFont(7);
        self.oName.textColor = UIColorFromRGBA(0x333338, 1.0);
        self.oName.textAlignment = NSTextAlignmentLeft;
        
        self.oNum = [UILabel new];
        self.oNum.font = kFont(7);
        self.oNum.textColor = UIColorFromRGBA(0x8F9095, 1.0);
        self.oNum.textAlignment = NSTextAlignmentRight;
        
        self.oPrice = [UILabel new];
        self.oPrice.font = kFont(7);
        self.oPrice.textColor = UIColorFromRGBA(0x333338, 1.0);
        self.oPrice.textAlignment = NSTextAlignmentRight;
        
        self.bucketMoney = [UILabel new];
        self.bucketMoney.font = kFont(6);
        self.bucketMoney.textColor = UIColorFromRGBA(0x8F9095, 1.0);
        self.bucketMoney.textAlignment = NSTextAlignmentLeft;
        
        self.line2 = [UIView new];
        self.line2.backgroundColor = UIColorFromRGBA(0xDDDDDD, 1.0);

        self.realMoney = [UILabel new];
        self.realMoney.font = kFont(7);
        self.realMoney.textColor = UIColorFromRGBA(0x333338, 1.0);
        self.realMoney.textAlignment = NSTextAlignmentLeft;
        
        self.deleteOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.deleteOrderBtn.titleLabel setFont:kFont(7)];
        [self.deleteOrderBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        [self.deleteOrderBtn setTitleColor:UIColorFromRGBA(0x8F9095, 1.0) forState:UIControlStateNormal];
        self.deleteOrderBtn.layer.borderWidth = 1;
        self.deleteOrderBtn.layer.borderColor = UIColorFromRGBA(0x8F9095, 1.0).CGColor;
        self.deleteOrderBtn.layer.cornerRadius = 3;
        self.deleteOrderBtn.hidden = YES;
        
        self.toPayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.toPayBtn.titleLabel setFont:kFont(7)];
        [self.toPayBtn setTitle:@"立即支付" forState:UIControlStateNormal];
        [self.toPayBtn setTitleColor:UIColorFromRGBA(0xFA6650, 1.0) forState:UIControlStateNormal];
        self.toPayBtn.layer.borderWidth = 1;
        self.toPayBtn.layer.borderColor = UIColorFromRGBA(0xFA6650, 1.0).CGColor;
        self.toPayBtn.layer.cornerRadius = 3;
        self.toPayBtn.hidden = YES;
        
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.createTime];
        [self.bgView addSubview:self.line1];
        [self.bgView addSubview:self.orderNum];
        [self.bgView addSubview:self.oStatus];
        [self.bgView addSubview:self.oIcon];
        [self.bgView addSubview:self.oName];
        [self.bgView addSubview:self.oNum];
        [self.bgView addSubview:self.oPrice];
        [self.bgView addSubview:self.bucketMoney];
        [self.bgView addSubview:self.line2];
        [self.bgView addSubview:self.realMoney];
        [self.bgView addSubview:self.deleteOrderBtn];
        [self.bgView addSubview:self.toPayBtn];
        
        [self.bgView makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.equalTo(kWidth);
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset(10);
            make.bottom.equalTo(self).offset(-10);
            
        }];
        
        [self.createTime makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self.bgView).offset(-kWidth/4);
            make.top.equalTo(self.bgView).offset(10);
            
        }];

        [self.line1 makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.equalTo(CGSizeMake(kWidth - 40, 1));
            make.centerX.equalTo(self.bgView);
            make.top.equalTo(self.createTime.mas_bottom).offset(10);
        }];
        
        [self.orderNum makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.line1.mas_bottom).offset(10);
            make.left.equalTo(self.bgView).offset(20);
            
        }];
        
        [self.oStatus makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.line1.mas_bottom).offset(10);
            make.right.equalTo(self.bgView).offset(-20);
            
        }];
        
        [self.oIcon makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.equalTo(CGSizeMake(90, 90));
            make.top.equalTo(self.orderNum.mas_bottom).offset(20);
            make.left.equalTo(self.bgView).offset(20);
            
        }];
        
        [self.oName makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.oIcon.mas_top);
            make.left.equalTo(self.oIcon.mas_right).offset(10);
            
        }];
        
        [self.oPrice makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.oName);
            make.right.equalTo(-20);
            
        }];
        
        [self.bucketMoney makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.oName.mas_bottom).offset(10);
            make.left.equalTo(self.oIcon.mas_right).offset(10);
            
        }];
        
        [self.oNum makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.bucketMoney);
            make.right.equalTo(self.bgView).offset(-20);
            
        }];
        
        [self.line2 makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.equalTo(CGSizeMake(kWidth - 40, 1));
            make.centerX.equalTo(self.bgView);
            make.top.equalTo(self.oIcon.mas_bottom).offset(20);
            
        }];
        
        [self.realMoney makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.line2.mas_bottom).offset(25);
            make.left.equalTo(self.bgView).offset(20);
            
        }];
        
        
        [self.toPayBtn makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.equalTo(CGSizeMake(80, 28));
            make.centerY.equalTo(self.realMoney);
            make.right.equalTo(self.bgView).offset(-20);
        }];
    
        [self.deleteOrderBtn makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.equalTo(CGSizeMake(80, 28));
            make.centerY.equalTo(self.realMoney);
            make.right.equalTo(self.toPayBtn.mas_left).offset(-20);
            
        }];
        
        
    }

    return self;
}


- (void)fitDataWithModel:(OrderModel *)model{
    //
    self.oIcon.image = [UIImage imageNamed:@"icon_outsouring_default.jpg"];
    //
    NSString *timeString = [NSString stringWithFormat:@"下单时间：%@",[CommonTools getTimeFromString:model.dtCreatetime]];
    self.createTime.text = timeString;
    //
    self.orderNum.text = [NSString stringWithFormat:@"订单号：%@",model.strOrdernum];
    //
    self.oStatus.text = @"未支付";
    //
    self.oName.text = model.orderGoods.strGoodsname;
    //
    self.oPrice.text = [NSString stringWithFormat:@"￥%@",model.orderGoods.nPrice];
    //
    self.bucketMoney.text = [NSString stringWithFormat:@"桶押金¥%@",model.nBucketmoney];
    //
    self.oNum.text = [NSString stringWithFormat:@"x %@",model.orderGoods.nCount];
    //
    self.realMoney.text = [NSString stringWithFormat:@"实付款：¥ %@",model.nTotalprice];
    //
    self.deleteOrderBtn.hidden = NO;
    //
    self.toPayBtn.hidden = NO;
}



@end
