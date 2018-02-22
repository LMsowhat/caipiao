//
//  MessageCell.m
//  Outsourcing
//
//  Created by 李文华 on 2017/9/23.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fitDataWithDict:(NSDictionary *)model{

    if ([[model allKeys] containsObject:@"strNoticeTypeName"]) {
        
        self.mTitle.text = model[@"strNoticeTypeName"];
    }
    if ([[model allKeys] containsObject:@"dtCreateTime"]) {
        
        self.mTime.text = [CommonTools getTimeFromString:model[@"dtCreateTime"]];
    }
    if ([[model allKeys] containsObject:@"strNoticeCon"]) {
        
        self.mDetail.text = model[@"strNoticeCon"];
    }

}

@end
