//
//  MyTicketTableViewCell.m
//  Outsourcing
//
//  Created by 李文华 on 2017/8/17.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "MyTicketTableViewCell.h"
#import "Masonry.h"

@implementation MyTicketTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {
        
        self.tTitle = [UILabel new];
        self.tTitle.font = kFont(7);
        self.tTitle.textColor = UIColorFromRGBA(0x333338, 1.0);
        
        self.tDate = [UILabel new];
        self.tDate.font = kFont(6);
        self.tDate.textColor = UIColorFromRGBA(0x8F9095, 1.0);

        self.tNumber = [UILabel new];
        self.tNumber.font = kFont(9);
        self.tNumber.textColor = UIColorFromRGBA(0x333338, 1.0);

        [self addSubview:self.tTitle];
        [self addSubview:self.tDate];
        [self addSubview:self.tNumber];
        
        [self.tTitle makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.left.equalTo(self).offset(10 *kScale);
            
        }];
        
        [self.tDate makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(10 *kScale);
            
            make.bottom.equalTo(self).offset(-10 *kScale);
        }];
        
        [self.tNumber makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.tTitle);
            
            make.right.equalTo(self).offset(-10 *kScale);
        }];
        
    }

    return self;
}

- (void)fitDataWithModel:(TicketModel *)model{

    self.tTitle.text = model.strTicketName;
    self.tDate.text = model.strExpire;
    self.tNumber.text = [NSString stringWithFormat:@"%@张",model.nRemainingCount];

}



@end
