//
//  TicketListTableViewCell.m
//  Outsourcing
//
//  Created by 李文华 on 2017/7/10.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "TicketListTableViewCell.h"
#import "Masonry.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation TicketListTableViewCell

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
        
        self.bgView = [UIView new];
        self.bgView.backgroundColor = UIColorFromRGBA(0xFFFFFF, 1.0);
        //
        self.pIcon = [UIImageView new];
        
        self.pName = [UILabel new];
        self.pName.font = kFont(7);
        self.pName.textColor = UIColorFromRGBA(0x333338, 1.0);
        self.pName.textAlignment = NSTextAlignmentLeft;
        
        self.pSales = [UILabel new];
        self.pSales.font = kFont(5.5);
        self.pSales.textColor = UIColorFromRGBA(0x8F9095, 1.0);
        self.pSales.textAlignment = NSTextAlignmentRight;
        
        self.pActivity = [UILabel new];
        self.pActivity.font = kFont(6);
        self.pActivity.textColor = UIColorFromRGBA(0xFA6650, 1.0);
        self.pActivity.textAlignment = NSTextAlignmentLeft;
        
        self.pCurrent_Price = [UILabel new];
        self.pCurrent_Price.font = kFont(7);
        self.pCurrent_Price.textColor = UIColorFromRGBA(0xFA6650, 1.0);
        self.pCurrent_Price.textAlignment = NSTextAlignmentLeft;
        
        self.pBefore_Prices = [UILabel new];
        self.pBefore_Prices.font = kFont(5);
        self.pBefore_Prices.textColor = UIColorFromRGBA(0x333338, 1.0);
        self.pBefore_Prices.textAlignment = NSTextAlignmentLeft;
        
        self.payTime = [UILabel new];
        self.payTime.font = kFont(5.5);
        self.payTime.textColor = UIColorFromRGBA(0x8F9095, 1.0);
        self.payTime.textAlignment = NSTextAlignmentLeft;
        
        self.tNumber = [UILabel new];
        self.tNumber.font = kFont(7);
        self.tNumber.textColor = UIColorFromRGBA(0x333338, 1.0);
        self.tNumber.textAlignment = NSTextAlignmentLeft;
        
        self.buyBtn = [UIButton new];
        [self.buyBtn setTitle:@"购买" forState:UIControlStateNormal];
        [self.buyBtn.titleLabel setFont:kFont(7)];
        [self.buyBtn setTitleColor:UIColorFromRGBA(0xFA6650, 1.0) forState:UIControlStateNormal];
        self.buyBtn.layer.borderWidth = 1;
        self.buyBtn.layer.borderColor = UIColorFromRGBA(0xFA6650, 1.0).CGColor;
        self.buyBtn.layer.cornerRadius = 3;
        
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.pIcon];
        [self.bgView addSubview:self.pName];
        [self.bgView addSubview:self.pSales];
        [self.bgView addSubview:self.pActivity];
        [self.bgView addSubview:self.pCurrent_Price];
        [self.bgView addSubview:self.pBefore_Prices];
        [self.bgView addSubview:self.payTime];
        [self.bgView addSubview:self.tNumber];
        [self.bgView addSubview:self.buyBtn];
        
        [self.bgView makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.equalTo(kWidth);
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset(10);
            make.bottom.equalTo(self).offset(-10);
            
        }];
        
        [self.pIcon makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.equalTo(CGSizeMake(90, 90));
            make.centerY.equalTo(self.bgView);
            make.left.equalTo(self.bgView).offset(10);
            
        }];
        
        [self.pName makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.pIcon.mas_top);
            make.left.equalTo(self.pIcon.mas_right).offset(10);
            
        }];
        
        [self.pSales makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.pName);
            make.right.equalTo(self.bgView).offset(-20);
            
        }];
        
        [self.pActivity makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.pName.mas_bottom).offset(5);
            make.left.equalTo(self.pIcon.mas_right).offset(10);
            
        }];
        
        [self.pCurrent_Price makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(self.pIcon.mas_bottom);
            make.left.equalTo(self.pIcon.mas_right).offset(10);
            
        }];
        
        [self.pBefore_Prices makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.pCurrent_Price);
            make.left.equalTo(self.pCurrent_Price.mas_right).offset(10);
            
        }];
        
        [self.payTime makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.pName.mas_bottom).offset(5);
            make.left.equalTo(self.pIcon.mas_right).offset(10);
            
        }];
        
        
        [self.tNumber makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(self.pIcon.mas_bottom);
            make.left.equalTo(self.pIcon.mas_right).offset(10);
            
        }];
        
        
        [self.buyBtn makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.equalTo(CGSizeMake(30 *kScale, 15*kScale));
            make.bottom.equalTo(self.pIcon.mas_bottom);
            make.right.equalTo(self.bgView).offset(-20);
            
        }];
        
        
        
        
        
    }

    return self;
}

- (void)buyTicketFitData:(TicketModel *)model{

    [self.pIcon sd_setImageWithURL:kGetImageUrl(URLHOST, @"0", model.lGoodsid) placeholderImage:[UIImage imageNamed:@"icon_outsouring_default.jpg"]];
    self.pName.text = model.strGoodsName;
    self.pSales.text = [NSString stringWithFormat:@"月销%@",model.nMonthCount];
    self.pActivity.text = model.strRemarks;
    self.pCurrent_Price.text = [NSString stringWithFormat:@"￥%.2f",[model.nPrice floatValue]/100];

    NSString *disPrice = [NSString stringWithFormat:@"原价：¥%.2f",[model.nOldPrice floatValue]/100];
    NSMutableAttributedString *attPrice = [[NSMutableAttributedString alloc] initWithString:disPrice];
    [attPrice addAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle),NSBaselineOffsetAttributeName:@(0)} range:NSMakeRange(0, disPrice.length)];
    self.pBefore_Prices.attributedText = attPrice;
    
    self.payTime.hidden = YES;
    self.tNumber.hidden = YES;
    
}

- (void)myTicketFitData:(TicketModel *)model{
    
    [self.pIcon sd_setImageWithURL:kGetImageUrl(URLHOST, @"0", model.lGoodsid) placeholderImage:[UIImage imageNamed:@"icon_outsouring_default.jpg"]];
    self.pName.text = model.strTicketName;
    self.payTime.text = model.strExpire;
    self.tNumber.text = [NSString stringWithFormat:@"%@张",model.nRemainingCount];
    
    self.pSales.hidden = YES;
    self.pActivity.hidden = YES;
    self.pCurrent_Price.hidden = YES;
    self.pBefore_Prices.hidden = YES;
    self.buyBtn.hidden = YES;
}


@end
