//
//  SCartListTableViewCell.h
//  Outsourcing
//
//  Created by 李文华 on 2017/6/20.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCartListTableViewCell : UITableViewCell

@property (nonatomic,strong) UILabel *        pTitle;

@property (nonatomic,strong) UILabel *        pPrice;

@property (nonatomic,strong) UIButton *        subtractBtn;

@property (nonatomic,strong) UIButton *        addBtn;

@property (nonatomic,strong) UILabel *        pNum;


@end
