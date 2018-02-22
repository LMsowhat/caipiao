//
//  ShoppingCart.h
//  Outsourcing
//
//  Created by 李文华 on 2017/6/20.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCartListTableViewCell.h"

@interface ShoppingCart : UIView

@property (nonatomic,strong) UIView *        showView;

@property (nonatomic,strong) UIButton *        shoppingBtn;

@property (nonatomic,strong) UIButton *        cleanCart;

@property (nonatomic,strong) UIButton *        submitBtn;

@property (nonatomic,strong) UILabel *        cartTitle;

@property (nonatomic,strong) UILabel *        label1;

@property (nonatomic,strong) UILabel *        totalMoney;

@property (nonatomic,strong) UITableView *        productionList;

@property (nonatomic,strong) NSMutableArray *        dataSource;

@property (nonatomic,strong) SCartListTableViewCell *        cell;


+(ShoppingCart *)initWithData:(NSArray *)data;

- (void)configWithType:(BOOL)isShow;


@end
