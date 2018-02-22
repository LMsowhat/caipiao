//
//  AddressTableViewCell.h
//  Outsourcing
//
//  Created by 李文华 on 2017/8/16.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"

@interface AddressTableViewCell : UITableViewCell

@property (nonatomic,strong) UILabel *        receiveName;

@property (nonatomic,strong) UILabel *        receivePhone;

@property (nonatomic,strong) UILabel *        Address;

@property (nonatomic,strong) UILabel *        btnText;

@property (nonatomic,strong) UIView *        lineView;

@property (nonatomic,strong) UIButton *        editBtn;

@property (nonatomic,strong) UIButton *        deleteBtn;

@property (nonatomic,strong) UIButton *        seleteBtn;

- (void)fitDataWithModel:(AddressModel *)model;

@end
