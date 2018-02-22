//
//  AddressTableViewCell.m
//  Outsourcing
//
//  Created by 李文华 on 2017/8/16.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "AddressTableViewCell.h"
#import "Masonry.h"


@implementation AddressTableViewCell

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
        
        self.receiveName = [UILabel new];
        self.receiveName.font = kFont(7);
        self.receiveName.textColor = UIColorFromRGBA(0x333338, 1.0);
        
        self.receivePhone = [UILabel new];
        self.receivePhone.font = kFont(7);
        self.receivePhone.textColor = UIColorFromRGBA(0x333338, 1.0);
        self.receivePhone.textAlignment = NSTextAlignmentRight;
        
        self.Address = [UILabel new];
        self.Address.font = kFont(6);
        self.Address.textColor = UIColorFromRGBA(0x333338, 1.0);
        
        self.btnText = [UILabel new];
        self.btnText.font = kFont(5.5);
        self.btnText.textColor = UIColorFromRGBA(0x8F9095, 1.0);
        self.btnText.text = @"设为默认地址";
        
        self.lineView = [UIView new];
        self.lineView.backgroundColor = UIColorFromRGBA(0xDDDDDD, 1.0);
        
        self.seleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.seleteBtn.selected = NO;
        [self.seleteBtn setImage:[UIImage imageNamed:@"unSelected"] forState:UIControlStateNormal];
        [self.seleteBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
        
        self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.editBtn.backgroundColor = UIColorFromRGBA(0xFFFFFF, 1.0);
        self.editBtn.layer.borderWidth = 1;
        self.editBtn.layer.borderColor = UIColorFromRGBA(0x88898E, 1.0).CGColor;
        self.editBtn.layer.cornerRadius = 2*kScale;
        [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [self.editBtn.titleLabel setFont:kFont(7)];
        [self.editBtn setTitleColor:UIColorFromRGBA(0x88898E, 1.0) forState:UIControlStateNormal];
        
        self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.deleteBtn.backgroundColor = UIColorFromRGBA(0xFFFFFF, 1.0);
        self.deleteBtn.layer.borderWidth = 1;
        self.deleteBtn.layer.borderColor = UIColorFromRGBA(0x88898E, 1.0).CGColor;
        self.deleteBtn.layer.cornerRadius = 2*kScale;
        [self.deleteBtn.titleLabel setFont:kFont(7)];
        [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [self.deleteBtn setTitleColor:UIColorFromRGBA(0x88898E, 1.0) forState:UIControlStateNormal];
        
        [self addSubview:self.receiveName];
        [self addSubview:self.receivePhone];
        [self addSubview:self.Address];
        [self addSubview:self.btnText];
        [self addSubview:self.lineView];
        [self addSubview:self.seleteBtn];
        [self addSubview:self.editBtn];
        [self addSubview:self.deleteBtn];
        
        [self.receiveName makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.left.equalTo(self).offset(10*kScale);
            
        }];
        
        [self.receivePhone makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self);
            
            make.centerY.equalTo(self.receiveName);

            make.right.equalTo(self).offset(-10*kScale);
        }];
        
        [self.Address makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.receiveName.mas_bottom).offset(3 *kScale);
            
            make.left.equalTo(self.receiveName.mas_left);
            
            make.right.equalTo(self).offset(-10*kScale);
        }];
        
        [self.lineView makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.equalTo(CGSizeMake(kWidth - 20 *kScale, 1));
            
            make.top.equalTo(self.Address.mas_bottom).offset(10 *kScale);
            
            make.centerX.equalTo(self);
        }];
        
        [self.seleteBtn makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.equalTo(CGSizeMake(10 *kScale, 10 *kScale));
            
            make.left.equalTo(self).offset(10*kScale);
            
            make.bottom.equalTo(self).offset(-12.5 *kScale);
        }];

        [self.deleteBtn makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.equalTo(CGSizeMake(40 *kScale, 15*kScale));
            
            make.centerY.equalTo(self.seleteBtn);
            
            make.right.equalTo(self).offset(-10 *kScale);
        }];
        
        [self.editBtn makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.equalTo(CGSizeMake(40 *kScale, 15*kScale));
            
            make.centerY.equalTo(self.seleteBtn);
            
            make.right.equalTo(self.deleteBtn.mas_left).offset(-10 *kScale);
        }];
        
        [self.btnText makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.seleteBtn);

            make.left.equalTo(self.seleteBtn.mas_right).offset(2*kScale);
        }];
        
    }

    return self;
}

- (void)fitDataWithModel:(AddressModel *)model{

    self.receiveName.text = model.strReceiptusername;
    self.receivePhone.text = model.strReceiptmobile;
    self.Address.text = [NSString stringWithFormat:@"%@%@",model.strLocation,model.strDetailaddress];

}


@end
