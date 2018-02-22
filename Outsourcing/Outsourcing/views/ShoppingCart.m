//
//  ShoppingCart.m
//  Outsourcing
//
//  Created by 李文华 on 2017/6/20.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "ShoppingCart.h"
#import "UIButton+myButton.h"
#import "Masonry.h"

@interface ShoppingCart ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@end


@implementation ShoppingCart

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];

    if (self) {
        
        self.backgroundColor = UIColorFromRGBA(0xf1f1f1, 0.3);
        
        self.showView = [UIView new];
        self.showView.backgroundColor = UIColorFromRGBA(0xf1f1f1, 1.0);
        
        self.shoppingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.shoppingBtn setImage:[UIImage imageNamed:@"home_selected@3x"] forState:UIControlStateNormal];
        [self.shoppingBtn setBadgeValue:@"0"];
        [self.shoppingBtn setBadgeFont:kFont(5)];
        [self.shoppingBtn setBadgeBGColor:kRedColor];
        [self.shoppingBtn setBadgeTextColor:kWhiteColor];
        [self.shoppingBtn setBadgeOriginX:25];
        
        self.label1 = [UILabel new];
        self.label1.font = kFont(7);
        self.label1.textColor = kBlackColor;
        self.label1.textAlignment = NSTextAlignmentRight;
        self.label1.text = @"共";
        
        self.totalMoney = [UILabel new];
        self.totalMoney.text = @"￥0.00";
        self.totalMoney.font = kFont(7);
        self.totalMoney.textColor = kRedColor;
        self.totalMoney.textAlignment = NSTextAlignmentLeft;
        
        self.submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.submitBtn.backgroundColor = kRedColor;
        [self.submitBtn setTitle:@"提交订单" forState:UIControlStateNormal];
        [self.submitBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        
        self.cartTitle = [UILabel new];
        self.cartTitle.font = kFont(7);
        self.cartTitle.textColor = kBlackColor;
        self.cartTitle.textAlignment = NSTextAlignmentLeft;
        self.cartTitle.text = @"购物车";
        
        self.cleanCart = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.cleanCart setTitle:@"清空购物车" forState:UIControlStateNormal];
        [self.cleanCart setTitleColor:kBlackColor forState:UIControlStateNormal];
        self.cleanCart.backgroundColor = UIColorFromRGBA(0xf1f1f1, 1.0);
        [self.cleanCart.titleLabel setFont:kFont(7)];
        
        self.productionList = [UITableView new];
        self.productionList.delegate = self;
        self.productionList.dataSource = self;
        
        
        //default
        [self addSubview:self.showView];
        [self.showView addSubview:self.shoppingBtn];
        [self.showView addSubview:self.label1];
        [self.showView addSubview:self.totalMoney];
        [self.showView addSubview:self.submitBtn];
        
        //show-list
        [self.showView addSubview:self.productionList];
        [self.showView addSubview:self.cartTitle];
        [self.showView addSubview:self.cleanCart];
        
    }
    
    return self;

}



+(ShoppingCart *)initWithData:(NSArray *)data{

    ShoppingCart *cart = [ShoppingCart new];
    
    cart.dataSource = [NSMutableArray arrayWithArray:data];

    [cart configWithType:NO];
    
    return cart;
}

- (void)configWithType:(BOOL)isShow{

    if (isShow) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.productionList.hidden = NO;
            self.cartTitle.hidden = NO;
            self.cleanCart.hidden = NO;
            
            
            [self.showView remakeConstraints:^(MASConstraintMaker *make) {
                
                make.edges.equalTo(self).insets(UIEdgeInsetsMake(self.frame.size.height/2, 0, 0, 0));
                
            }];
            
            
            [self.shoppingBtn remakeConstraints:^(MASConstraintMaker *make) {
                
                make.size.equalTo(CGSizeMake(kTabBarHeight-10, kTabBarHeight-10));
                make.left.equalTo(self.showView).offset(20);
                make.top.equalTo(self.showView).offset((10 -kTabBarHeight)/2);
                
            }];
            
            [self.cartTitle remakeConstraints:^(MASConstraintMaker *make) {
                
                make.top.equalTo(self.shoppingBtn.mas_bottom).offset(20);
                make.left.equalTo(self.showView).offset(20);
                
            }];
            
            [self.cleanCart remakeConstraints:^(MASConstraintMaker *make) {
                
                make.size.equalTo(CGSizeMake(80, 20));
                make.centerY.equalTo(self.cartTitle);
                make.right.equalTo(self.showView).offset(-30);
                
            }];
            
            [self.label1 remakeConstraints:^(MASConstraintMaker *make) {
                
                make.bottom.equalTo(self.showView).offset(-20);
                make.left.equalTo(self.showView).offset(20);
                
            }];
            
            [self.totalMoney remakeConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.equalTo(self.label1);
                make.left.equalTo(self.label1.mas_right);
                
            }];
            
            [self.submitBtn remakeConstraints:^(MASConstraintMaker *make) {
                
                make.size.equalTo(CGSizeMake(100, 30));
                make.centerY.equalTo(self.label1);
                make.right.equalTo(self.showView).offset(-20);
                
            }];
            
            
            [self.productionList remakeConstraints:^(MASConstraintMaker *make) {
                
                make.width.equalTo(kWidth);
                make.top.equalTo(self.cartTitle.mas_bottom).offset(20);
                make.bottom.equalTo(self.label1.mas_top).offset(-20);
                make.centerX.equalTo(self.showView);
                
            }];
            
        }];
        
        [self layoutIfNeeded];

    }else{
    
        [UIView animateWithDuration:0.5 animations:^{
            
            
            self.productionList.hidden = YES;
            self.cartTitle.hidden = YES;
            self.cleanCart.hidden = YES;
            
            [self.showView remakeConstraints:^(MASConstraintMaker *make) {
                
                make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
                
            }];
            
            [self.shoppingBtn remakeConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.equalTo(self.showView);
                make.size.equalTo(CGSizeMake(kTabBarHeight-10, kTabBarHeight-10));
                make.left.equalTo(self.showView).offset(20);
                
            }];
            
            [self.label1 remakeConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.equalTo(self.showView);
                make.left.equalTo(self.shoppingBtn.mas_right);
                
            }];
            
            [self.totalMoney remakeConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.equalTo(self.showView);
                make.left.equalTo(self.label1.mas_right);
                
            }];
            
            [self.submitBtn remakeConstraints:^(MASConstraintMaker *make) {
                
                make.size.equalTo(CGSizeMake(100, 30));
                make.centerY.equalTo(self.showView);
                make.right.equalTo(self.showView).offset(-20);
                
            }];
            
            
        }];
        
        [self layoutIfNeeded];
    }


}


#pragma mark TableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 13;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"UITableViewCell";
    self.cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (self.cell == nil)
    {
        self.cell = [[SCartListTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID] ;
        
    }
    self.cell.pTitle.text = @"桶装水20L";
    self.cell.pPrice.text = @"￥20.00";
    self.cell.pNum.text = @"1";
    
    return self.cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 30;
}



@end
