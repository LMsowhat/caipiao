//
//  OrderDetailListCell.h
//  Outsourcing
//
//  Created by 李文华 on 2017/6/26.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailListCell : UITableViewCell

@property (nonatomic ,strong)UILabel *left_label;

@property (nonatomic ,strong)UIImageView *right_icon;

- (void)setLeftView:(id)leftLabel RightView:(id)rightView others:(id)bgView;


@end
