//
//  TicketContentsCell.m
//  Outsourcing
//
//  Created by 李文华 on 2017/8/23.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "TicketContentsCell.h"
#import "Masonry.h"

@implementation TicketContentsCell

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
        
        self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.selectBtn setImage:[UIImage imageNamed:@"unSelected"] forState:UIControlStateNormal];
        [self.selectBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
        
        self.cName = [UILabel new];
        self.cName.font = kFont(7);
        self.cName.textColor = UIColorFromRGBA(0x333338, 1.0);
        
        self.cDescription = [UILabel new];
        self.cDescription.font = kFont(7);
        self.cDescription.textColor = UIColorFromRGBA(0x333338, 1.0);
        
        self.cPrice = [UILabel new];
        self.cPrice.font = kFont(9);
        self.cPrice.textColor = UIColorFromRGBA(0x333338, 1.0);
        
        [self addSubview:self.selectBtn];
        [self addSubview:self.cName];
        [self addSubview:self.cDescription];
        [self addSubview:self.cPrice];
        
        [self.cName makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.left.equalTo(self).offset(10 *kScale);
        }];
        
        [self.cDescription makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(self).offset(-10 *kScale);
            make.left.equalTo(self).offset(10 *kScale);
        }];
        
        [self.selectBtn makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.equalTo(CGSizeMake(9*kScale, 9*kScale));
            
            make.centerY.equalTo(self);
            
            make.right.equalTo(self).offset(-10 *kScale);
        }];
        
        [self.cPrice makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self);
            
            make.right.equalTo(self.selectBtn.mas_left).offset(-5 *kScale);
        }];
    }

    return self;
}

- (void)fitDataWithModel:(ContentTicketModel *)model{

    self.cName.text = model.strRemarks;
    self.cDescription.text = @"赠品：水票";
    self.cPrice.text = [NSString stringWithFormat:@"￥%.2f",[model.nPrice floatValue]/100];

}


@end
