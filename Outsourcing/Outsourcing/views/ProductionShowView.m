//
//  ProductionShowView.m
//  Outsourcing
//
//  Created by 李文华 on 2017/6/28.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "ProductionShowView.h"
#import "Masonry.h"

#import <SDWebImage/UIImageView+WebCache.h>

@implementation ProductionShowView

-(instancetype)initWithFrame:(CGRect)frame AndModel:(SubmitOrderProModel *)model{

    self = [super initWithFrame:frame];
    
    if (self) {
    
        self.pIcon = [UIImageView new];
        [self.pIcon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/common/getImg/0/%@",URLHOST,model.lGoodsid]] placeholderImage:[UIImage imageNamed:@"icon_outsouring_default.jpg"]];
        //[UIImage imageNamed:[NSString stringWithFormat:@"%@/common/getImg/0/%@",URLHOST,model.lGoodsid]];
        
        self.pPrice = [UILabel new];
        self.pPrice.font = kFont(7);
        self.pPrice.textColor = UIColorFromRGBA(0x333338, 1.0);
        self.pPrice.text = [NSString stringWithFormat:@"￥%.2f",[model.nPrice floatValue]/100];
       
        self.pName = [UILabel new];
        self.pName.font = kFont(7);
        self.pName.textColor = UIColorFromRGBA(0x333338, 1.0);
        self.pName.text = model.strGoodsname;
        
        self.barrelPrice = [UILabel new];
        self.barrelPrice.font = kFont(6);
        self.barrelPrice.textColor = UIColorFromRGBA(0x8F9095, 1.0);
        self.barrelPrice.textAlignment = NSTextAlignmentRight;
//        self.barrelPrice.text = @"桶押金0.00";
        
        self.pNum = [UILabel new];
        self.pNum.font = kFont(5.5);
        self.pNum.textColor = UIColorFromRGBA(0x8F9095, 1.0);
        self.pNum.textAlignment = NSTextAlignmentRight;
        self.pNum.text = [NSString stringWithFormat:@"x %@",model.nCount];
        
        [self addSubview:self.pIcon];
        [self addSubview:self.pName];
        [self addSubview:self.pNum];
        [self addSubview:self.barrelPrice];
        [self addSubview:self.pPrice];
        
        
        [self.pIcon makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.equalTo(CGSizeMake(15 *kScale, 15 *kScale));
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(10 *kScale);
        }];
        
        [self.pName makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.pIcon);
            make.left.equalTo(self.pIcon.mas_right).offset(10);
            
        }];
        
        [self.pPrice makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.pName);
            make.right.equalTo(self).offset(-20);
            
        }];
        
        [self.barrelPrice makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.pName.mas_bottom).offset(3*kScale);
            make.left.equalTo(self.pName);
            
        }];
        
        [self.pNum makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.pPrice);
            make.right.equalTo(self.pPrice.mas_left).offset(-10*kScale);
            
        }];
        
    }
    return self;
}

@end
