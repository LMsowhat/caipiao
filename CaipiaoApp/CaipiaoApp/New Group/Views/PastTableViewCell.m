//
//  PastTableViewCell.m
//  CaipiaoApp
//
//  Created by liwenhua on 2018/1/30.
//  Copyright © 2018年 李文华. All rights reserved.
//

#import "PastTableViewCell.h"

@implementation PastTableViewCell

- (void)setModel:(NSDictionary *)model{
    
    _model = model;
    
    if (_model) {
        NSArray *nums = model[@"numbers"];
        self.label1.text = nums[0];
        self.label2.text = nums[1];
        self.label3.text = nums[2];
        self.label4.text = nums[3];
        self.label5.text = nums[4];
        self.label6.text = nums[5];
        self.label7.text = nums[6];

        self.dateLabel.text = [NSString stringWithFormat:@"第%@期",model[@"date"]];
    }
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
