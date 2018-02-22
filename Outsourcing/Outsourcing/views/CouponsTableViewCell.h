//
//  CouponsTableViewCell.h
//  Outsourcing
//
//  Created by 李文华 on 2017/8/10.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponsModel.h"

@interface CouponsTableViewCell : UITableViewCell

@property (nonatomic,strong) UILabel *        couponTitle;
@property (nonatomic,strong) UILabel *        couponTime;
@property (nonatomic,strong) UILabel *        couponValue;

- (void)fitDataWithModel:(CouponsModel *)model;

@end
