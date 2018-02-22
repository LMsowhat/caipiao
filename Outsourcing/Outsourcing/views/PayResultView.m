//
//  PayResultView.m
//  Eliveapp
//
//  Created by 李文华 on 2017/5/11.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "PayResultView.h"
#import "Masonry.h"


@implementation PayResultView

-(instancetype)initSuccess:(BOOL)success WithModel:(OrderModel *)model{

    self = [super init];
    
    if (self) {
        
        self.backgroundColor = kWhiteColor;
        for (id obj in self.subviews) {
            
            [obj removeFromSuperview];
        }
        
        if (success) {
            
            UILabel *unitLabel = [UILabel new];
            unitLabel.text = @"￥";
            unitLabel.font = kFont(7);
            unitLabel.textColor = UIColorFromRGBA(0x878c89, 1.0);
            unitLabel.textAlignment = NSTextAlignmentRight;
            
            UILabel *priceLabel = [UILabel new];
            priceLabel.font = kFont(12);
            priceLabel.text = [NSString stringWithFormat:@"%.2f",[model.nFactPrice floatValue]];
            priceLabel.textColor = UIColorFromRGBA(0xFA6650, 1.0);
            priceLabel.textAlignment = NSTextAlignmentLeft;
            
            UILabel *congratulations = [UILabel new];
            congratulations.font = kFont(12);
            congratulations.text = @"恭喜您支付成功";
            congratulations.textColor = UIColorFromRGBA(0x303c36, 1.0);
            congratulations.textAlignment = NSTextAlignmentCenter;
            
            UIView *lineView = [UIView new];
            lineView.backgroundColor = UIColorFromRGBA(0xf1f1f1, 1.0);
            
            UILabel *orderNumberT = [UILabel new];
            orderNumberT.font = kFont(7.5);
            orderNumberT.text = @"订单编号";
            orderNumberT.textColor = UIColorFromRGBA(0x303c36, 1.0);
            orderNumberT.textAlignment = NSTextAlignmentRight;
            
            UILabel *orderNumber = [UILabel new];
            orderNumber.font = kFont(7);
            orderNumber.text = model.strOrdernum;
            orderNumber.textColor = UIColorFromRGBA(0x878c89, 1.0);
            orderNumber.textAlignment = NSTextAlignmentLeft;
            
            UILabel *orderTimeT = [UILabel new];
            orderTimeT.font = kFont(7.5);
            orderTimeT.text = @"支付时间";
            orderTimeT.textColor = UIColorFromRGBA(0x303c36, 1.0);
            orderTimeT.textAlignment = NSTextAlignmentRight;
            
            UILabel *orderTime = [UILabel new];
            orderTime.font = kFont(7);
            orderTime.text = model.dtCreatetime;
            orderTime.textColor = UIColorFromRGBA(0x878c89, 1.0);
            orderTime.textAlignment = NSTextAlignmentLeft;
            
            self.seeOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.seeOrderBtn.layer.borderWidth = 1;
            self.seeOrderBtn.layer.borderColor = UIColorFromRGBA(0xFA6650, 1.0).CGColor;
            self.seeOrderBtn.layer.cornerRadius = 8;
            [self.seeOrderBtn setTitle:@"查看订单" forState:UIControlStateNormal];
            [self.seeOrderBtn setTitleColor:UIColorFromRGBA(0xFA6650, 1.0) forState:UIControlStateNormal];
            self.seeOrderBtn.titleLabel.font = kFont(7);
            self.seeOrderBtn.backgroundColor = kWhiteColor;
            
            
            self.goBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.goBackBtn.layer.borderWidth = 1;
            self.goBackBtn.layer.borderColor = UIColorFromRGBA(0xFA6650, 1.0).CGColor;
            self.goBackBtn.layer.cornerRadius = 8;
            [self.goBackBtn setTitle:@"返回首页" forState:UIControlStateNormal];
            [self.goBackBtn setTitleColor:UIColorFromRGBA(0xFA6650, 1.0) forState:UIControlStateNormal];
            self.goBackBtn.titleLabel.font = kFont(7);
            self.goBackBtn.backgroundColor = kWhiteColor;
            
            [self addSubview:unitLabel];
            [self addSubview:priceLabel];
            [self addSubview:congratulations];
            [self addSubview:lineView];
            [self addSubview:orderNumberT];
            [self addSubview:orderNumber];
            [self addSubview:orderTimeT];
            [self addSubview:orderTime];
//            [self addSubview:self.seeOrderBtn];
            [self addSubview:self.goBackBtn];
            
            [priceLabel makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerX.equalTo(self).offset(15);
                make.top.equalTo(self).offset(50);
                
            }];
            
            [unitLabel makeConstraints:^(MASConstraintMaker *make) {
                
                make.right.equalTo(priceLabel.mas_left).offset(-5);
                make.bottom.equalTo(priceLabel.mas_bottom);
                
            }];
            
            [congratulations makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerX.equalTo(self);
                make.top.equalTo(priceLabel.mas_bottom).offset(15);
                
            }];
            
            [lineView makeConstraints:^(MASConstraintMaker *make) {
                
                make.height.equalTo(@1);
                make.left.right.equalTo(self).offset(15);
                make.top.equalTo(congratulations.mas_bottom).offset(30);
                
            }];
            
            [orderNumberT makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.equalTo(lineView.mas_bottom).offset(20);
                make.left.equalTo(self).offset(15);
                
            }];
            
            [orderNumber makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.equalTo(orderNumberT);
                make.left.equalTo(orderNumberT.mas_right).offset(10);
                
            }];
            
            [orderTimeT makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.equalTo(orderNumberT.mas_bottom).offset(20);
                make.left.equalTo(self).offset(15);
                
            }];
            
            [orderTime makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.equalTo(orderTimeT);
                make.left.equalTo(orderTimeT.mas_right).offset(10);
                
            }];
            
//            [self.seeOrderBtn makeConstraints:^(MASConstraintMaker *make) {
//                
//                make.size.equalTo(CGSizeMake(100, 30));
//                make.centerX.equalTo(self).offset(-kWidth/4);
//                make.top.equalTo(orderTimeT.mas_bottom).offset(60);
//                
//            }];
            
            [self.goBackBtn makeConstraints:^(MASConstraintMaker *make) {
                
                make.size.equalTo(CGSizeMake(100, 30));
                make.centerX.equalTo(self);
                make.top.equalTo(orderTimeT.mas_bottom).offset(60);
                
            }];
            
        }else{
            
            for (id obj in self.subviews) {
                
                [obj removeFromSuperview];
            }
            UILabel *congratulations = [UILabel new];
            congratulations.font = kFont(12);
            congratulations.text = @"很抱歉，支付失败";
            congratulations.textColor = UIColorFromRGBA(0x303c36, 1.0);
            congratulations.textAlignment = NSTextAlignmentCenter;
            
            self.payAgainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.payAgainBtn.layer.borderWidth = 1;
            self.payAgainBtn.layer.borderColor = UIColorFromRGBA(0xFA6650, 1.0).CGColor;
            self.payAgainBtn.layer.cornerRadius = 8;
            [self.payAgainBtn setTitle:@"重新支付" forState:UIControlStateNormal];
            [self.payAgainBtn setTitleColor:UIColorFromRGBA(0xFA6650, 1.0) forState:UIControlStateNormal];
            self.payAgainBtn.titleLabel.font = kFont(7);
            self.payAgainBtn.backgroundColor = kWhiteColor;
            
            [self addSubview:congratulations];
            [self addSubview:self.payAgainBtn];
            
            [congratulations makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerX.equalTo(self);
                make.top.equalTo(self).offset(50);
                
            }];
            
            [self.payAgainBtn makeConstraints:^(MASConstraintMaker *make) {
                
                make.size.equalTo(CGSizeMake(100, 30));
                make.centerX.equalTo(self);
                make.top.equalTo(congratulations.mas_bottom).offset(60);
                
            }];
            
        }
     
    }
    
    return self;

}


@end
