//
//  CouponsTableViewCell.m
//  Outsourcing
//
//  Created by 李文华 on 2017/8/10.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "CouponsTableViewCell.h"
#import "Masonry.h"

@implementation CouponsTableViewCell

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
        
        UIImageView *bgView = [UIImageView new];
        bgView.image = [UIImage imageNamed:@"coupons"];
        
        self.couponTitle = [UILabel new];
        self.couponTitle.font = kFont(7);
        self.couponTitle.textColor = UIColorFromRGBA(0x333338, 1.0);
        
        self.couponTime = [UILabel new];
        self.couponTime.font = kFont(5.5);
        self.couponTime.textColor = UIColorFromRGBA(0x333338, 1.0);
        
        UILabel *money = [UILabel new];
        money.text = @"￥";
        money.font = kFont(7);
        money.textColor = UIColorFromRGBA(0x333338, 1.0);
        
        self.couponValue = [UILabel new];
        self.couponValue.font = kFont(15);
        self.couponValue.textColor = UIColorFromRGBA(0x15151A, 1.0);
        
        [self addSubview:bgView];
        [self addSubview:self.couponTitle];
        [self addSubview:self.couponTime];
        [self addSubview:self.couponValue];
        [self addSubview:money];
 
        [bgView makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.equalTo(@(42 *kScale));
            make.width.equalTo(self).offset(-20);
            make.center.equalTo(self);
            
        }];
        
        [self.couponTitle makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(bgView.centerY).offset(-1*kScale);
            
            make.left.equalTo(self).offset(24*kScale);
            
        }];
        
        [self.couponTime makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(bgView.centerY).offset(1*kScale);
            
            make.left.equalTo(self.couponTitle);
            
        }];
        
        [self.couponValue makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self);
            
            make.right.equalTo(self).offset(-24*kScale);
            
        }];
        
        [money makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self);
            
            make.right.equalTo(self.couponValue.mas_left).offset(-1*kScale);
            
        }];
    }

    return self;
}

- (void)fitDataWithModel:(CouponsModel *)model{

    NSString *dateString = [CommonTools getTimeFromString:model.dExpire];
    
    self.couponTime.text = [NSString stringWithFormat:@"有效期至：%@",dateString];

    self.couponTitle.text = model.strCouponName;
    
    self.couponValue.text = [NSString stringWithFormat:@"%.2f",[model.nPrice floatValue]/100];
    
}


@end
