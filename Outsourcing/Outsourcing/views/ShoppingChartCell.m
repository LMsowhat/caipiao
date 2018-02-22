//
//  ShoppingChartCell.m
//  Outsourcing
//
//  Created by 李文华 on 2017/9/22.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "ShoppingChartCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation ShoppingChartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (void)fitDataWithModel:(ShoppingChartModel *)model{

    [self.pIcon sd_setImageWithURL:kGetImageUrl(URLHOST, @"0", model.lGoodsId) placeholderImage:[UIImage imageNamed:@"icon_outsouring_default.jpg"]];
    
    self.pName.text = model.strGoodsname;

    self.pSales.text = model.strStandard;
    
    self.pNum.text = model.nGoodsCount;
    
    self.pPrice.text = [NSString stringWithFormat:@"￥%.2f",[model.nPrice floatValue]/100];
    
}

@end
