//
//  SCartListTableViewCell.m
//  Outsourcing
//
//  Created by 李文华 on 2017/6/20.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "SCartListTableViewCell.h"
#import "Masonry.h"


@implementation SCartListTableViewCell

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
        
        self.pTitle = [UILabel new];
        self.pTitle.font = kFont(7);
        self.pTitle.textColor = kBlackColor;
        self.pTitle.textAlignment = NSTextAlignmentCenter;
        
        self.pPrice = [UILabel new];
        self.pPrice.font = kFont(7);
        self.pPrice.textColor = kRedColor;
        self.pPrice.textAlignment = NSTextAlignmentCenter;
        
        self.pNum = [UILabel new];
        self.pNum.font = kFont(6.5);
        self.pNum.textColor = kBlackColor;
        self.pNum.textAlignment = NSTextAlignmentCenter;
        
        self.subtractBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.subtractBtn setTitle:@"-" forState:UIControlStateNormal];
        [self.subtractBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
        
        self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.addBtn setTitle:@"+" forState:UIControlStateNormal];
        [self.addBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
        
        
        [self addSubview:self.pTitle];
        [self addSubview:self.pPrice];
        [self addSubview:self.pNum];
        [self addSubview:self.subtractBtn];
        [self addSubview:self.addBtn];
        
        [self.pTitle makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self);
            make.left.equalTo(30);
            
        }];
        
        [self.pPrice makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self);
            make.centerX.equalTo(-20);
            
        }];
        
        [self.pNum makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self);
            make.right.equalTo(-70);
            
        }];
        
        [self.addBtn makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.equalTo(CGSizeMake(20, 20));
            make.centerY.equalTo(self);
            make.right.equalTo(-20);
            
        }];
        
        [self.subtractBtn makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.equalTo(CGSizeMake(20, 20));
            make.centerY.equalTo(self);
            make.right.equalTo(self.pNum.mas_left).offset(-20);
            
        }];
        
        
        
    }


    return self;
}



@end
