//
//  ProductionDetailViewController.m
//  Outsourcing
//
//  Created by 李文华 on 2017/6/15.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "ProductionDetailViewController.h"
#import "Masonry.h"
#import "UIButton+myButton.h"
#import "EliveApplication.h"
#import "MJExtension.h"
#import "MBProgressHUDManager.h"
#import <SDWebImage/UIImageView+WebCache.h>

#import "ShoppingCart.h"
#import "OrderCreateController.h"
#import "ProductionModel.h"



@interface ProductionDetailViewController ()<UIScrollViewDelegate>

@property (nonatomic ,strong)UIScrollView *mainScroll;

@property (nonatomic ,strong)UIImageView *pIcon;
@property (nonatomic ,strong)UILabel *pTitle;
@property (nonatomic ,strong)UILabel *pSales;
@property (nonatomic ,strong)UILabel *pPrice;
@property (nonatomic ,strong)UILabel *num;
@property (nonatomic ,strong)UILabel *specifications;

@property (nonatomic ,strong)ShoppingCart *shoppingCart;

@property (nonatomic ,assign)NSInteger pNumber;

@property (nonatomic ,strong)UIButton *submitBtn;



@property (nonatomic ,strong)UIImageView *imageV;


@property (nonatomic ,strong)ProductionModel *pModel;

@end

@implementation ProductionDetailViewController

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];

    self.navigationController.navigationBarHidden = NO;
    
    self.navigationItem.title = @"商品详情";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 22, 17);
    [btn setImage:[UIImage imageNamed:@"naviBack"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(foreAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [self.navigationItem setLeftBarButtonItem:leftItem];
 
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.mainScroll];
    
    [self configDefaultView];

    [self sendHttpRequest];
    
    //记录商品数量
    self.pNumber = 1;
    //
    [self.view addSubview:self.submitBtn];
    [self.submitBtn makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.equalTo(CGSizeMake(kWidth, kTabBarHeight));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view);
        
    }];
    
    // Do any additional setup after loading the view.
}


#pragma mark ---Setter & Getter
-(UIScrollView *)mainScroll{

    if (!_mainScroll) {
        
        _mainScroll = [UIScrollView new];
        
        _mainScroll.frame = CGRectMake(0, kTopBarHeight, kWidth, kHeight - kTopBarHeight - kTabBarHeight);
        _mainScroll.contentSize = CGSizeMake(kWidth, kHeight - kTopBarHeight - kTabBarHeight);
        _mainScroll.delegate = self;
        
        
    }

    return _mainScroll;
}
- (void)conconfigDefaultView{
    
    self.pIcon = [UIImageView new];
    
    self.pTitle = [UILabel new];
    self.pTitle.font = kFont(7);
    self.pTitle.textColor = UIColorFromRGBA(0x333338, 1.0);
    
    self.specifications = [UILabel new];
    self.specifications.font = kFont(6);
    self.specifications.textColor = UIColorFromRGBA(0x8F9095, 1.0);
    
    self.pSales = [UILabel new];
    self.pSales.font = kFont(5.5);
    self.pSales.textColor = UIColorFromRGBA(0x8F9095, 1.0);
    self.pSales.textAlignment = NSTextAlignmentRight;
    
    self.pPrice = [UILabel new];
    self.pPrice.font = kFont(9);
    self.pPrice.textColor = UIColorFromRGBA(0xFA6650, 1.0);
    
    UIImageView *calculate = [UIImageView new];
    calculate.image = [UIImage imageNamed:@"calculate"];
    
    UIButton *subtractionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [subtractionBtn setTitle:@"" forState:UIControlStateNormal];
    [subtractionBtn setBackgroundColor:kClearColor];
    [subtractionBtn addTarget:self action:@selector(subtractionClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@"" forState:UIControlStateNormal];
    [addBtn setBackgroundColor:kClearColor];
    [addBtn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.num = [UILabel new];
    self.num.font = kFont(7);
    self.num.textColor = kBlackColor;
    self.num.textAlignment = NSTextAlignmentCenter;
    
    UIView *segment = [UIView new];
    segment.backgroundColor = UIColorFromRGBA(0xF7F7F7, 1.0);
    
    UILabel *pDescripution = [UILabel new];
    pDescripution.font = kFont(7);
    pDescripution.textColor = UIColorFromRGBA(0x8F9095, 1.0);
    pDescripution.text = @"商品介绍";
    
    [self.mainScroll addSubview:self.pIcon];
    [self.mainScroll addSubview:self.pTitle];
    [self.mainScroll addSubview:self.specifications];
    [self.mainScroll addSubview:self.pSales];
    [self.mainScroll addSubview:self.pPrice];
    [self.mainScroll addSubview:calculate];
    [self.mainScroll addSubview:subtractionBtn];
    [self.mainScroll addSubview:addBtn];
    [self.mainScroll addSubview:self.num];
    [self.mainScroll addSubview:segment];
    [self.mainScroll addSubview:pDescripution];
    
    [self.pIcon makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.equalTo(CGSizeMake(kWidth, 190));
        make.centerX.equalTo(self.mainScroll);
        make.top.equalTo(self.mainScroll);
        
    }];
    
    [self.pTitle makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mainScroll).offset(20);
        make.top.equalTo(self.pIcon.mas_bottom).offset(20);
        
    }];
    
    [self.pSales makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.pTitle);
        make.right.equalTo(self.view.mas_right).offset(-20);
        
    }];
    
    [self.specifications makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.pTitle.mas_left);
        make.top.equalTo(self.pTitle.mas_bottom).offset(10);
        
    }];
    
    [self.pPrice makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.specifications.mas_left);
        make.top.equalTo(self.specifications.mas_bottom).offset(10);
        
    }];
    
    [self.num makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.pPrice);
        make.centerX.equalTo(calculate);
        
    }];
    
    [calculate makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.equalTo(CGSizeMake(45 *kScale, 14 *kScale));
        make.centerY.equalTo(self.pPrice);
        make.right.equalTo(self.view).offset(-10 *kScale);
        
    }];
    
    [addBtn makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.equalTo(CGSizeMake(45/2 *kScale, 14*kScale));
        make.centerY.equalTo(calculate);
        make.right.equalTo(calculate);
        
    }];
    
    [subtractionBtn makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.equalTo(CGSizeMake(45/2 *kScale, 14*kScale));
        make.centerY.equalTo(calculate);
        make.left.equalTo(calculate);
        
    }];
    
    [segment makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.equalTo(CGSizeMake(kWidth, 10));
        make.centerX.equalTo(self.view);
        make.top.equalTo(calculate.mas_bottom).offset(20);
        
    }];
    
    [pDescripution makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(segment.mas_bottom).offset(20);
        make.left.equalTo(self.mainScroll).offset(20);
        
    }];
    
    [self.view layoutIfNeeded];
}

-(UIButton *)submitBtn{

    if (!_submitBtn) {
        
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setBackgroundColor:UIColorFromRGBA(0xFA6650, 1.0)];
        [_submitBtn setTitle:@"提交订单" forState:UIControlStateNormal];
        [_submitBtn.titleLabel setTextColor:UIColorFromRGBA(0xFFFFFF, 1.0)];
        [_submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }

    return _submitBtn;
}

- (void)configDefaultView{

    self.pIcon = [UIImageView new];
    
    self.pTitle = [UILabel new];
    self.pTitle.font = kFont(7);
    self.pTitle.textColor = UIColorFromRGBA(0x333338, 1.0);
    
    self.specifications = [UILabel new];
    self.specifications.font = kFont(6);
    self.specifications.textColor = UIColorFromRGBA(0x8F9095, 1.0);
    
    self.pSales = [UILabel new];
    self.pSales.font = kFont(5.5);
    self.pSales.textColor = UIColorFromRGBA(0x8F9095, 1.0);
    self.pSales.textAlignment = NSTextAlignmentRight;
    
    self.pPrice = [UILabel new];
    self.pPrice.font = kFont(9);
    self.pPrice.textColor = UIColorFromRGBA(0xFA6650, 1.0);
    
    UIImageView *calculate = [UIImageView new];
    calculate.image = [UIImage imageNamed:@"calculate"];
    
    UIButton *subtractionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [subtractionBtn setTitle:@"" forState:UIControlStateNormal];
    [subtractionBtn setBackgroundColor:kClearColor];
    [subtractionBtn addTarget:self action:@selector(subtractionClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@"" forState:UIControlStateNormal];
    [addBtn setBackgroundColor:kClearColor];
    [addBtn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.num = [UILabel new];
    self.num.font = kFont(7);
    self.num.textColor = kBlackColor;
    self.num.textAlignment = NSTextAlignmentCenter;
    
    UIView *segment = [UIView new];
    segment.backgroundColor = UIColorFromRGBA(0xF7F7F7, 1.0);
    
    UILabel *pDescripution = [UILabel new];
    pDescripution.font = kFont(7);
    pDescripution.textColor = UIColorFromRGBA(0x8F9095, 1.0);
    pDescripution.text = @"商品介绍";
    
    [self.mainScroll addSubview:self.pIcon];
    [self.mainScroll addSubview:self.pTitle];
    [self.mainScroll addSubview:self.specifications];
    [self.mainScroll addSubview:self.pSales];
    [self.mainScroll addSubview:self.pPrice];
    [self.mainScroll addSubview:calculate];
    [self.mainScroll addSubview:subtractionBtn];
    [self.mainScroll addSubview:addBtn];
    [self.mainScroll addSubview:self.num];
    [self.mainScroll addSubview:segment];
    [self.mainScroll addSubview:pDescripution];
    
    [self.pIcon makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.equalTo(CGSizeMake(kWidth, 190));
        make.centerX.equalTo(self.mainScroll);
        make.top.equalTo(self.mainScroll);
        
    }];
    
    [self.pTitle makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mainScroll).offset(20);
        make.top.equalTo(self.pIcon.mas_bottom).offset(20);
        
    }];
    
    [self.pSales makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.pTitle);
        make.right.equalTo(self.view.mas_right).offset(-20);
        
    }];
    
    [self.specifications makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.pTitle.mas_left);
        make.top.equalTo(self.pTitle.mas_bottom).offset(10);
        
    }];
    
    [self.pPrice makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.specifications.mas_left);
        make.top.equalTo(self.specifications.mas_bottom).offset(10);
        
    }];
  
    [self.num makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.pPrice);
        make.centerX.equalTo(calculate);
        
    }];
    
    [calculate makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.equalTo(CGSizeMake(45 *kScale, 14 *kScale));
        make.centerY.equalTo(self.pPrice);
        make.right.equalTo(self.view).offset(-10 *kScale);
        
    }];
    
    [addBtn makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.equalTo(CGSizeMake(45/2 *kScale, 14*kScale));
        make.centerY.equalTo(calculate);
        make.right.equalTo(calculate);
        
    }];
    
    [subtractionBtn makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.equalTo(CGSizeMake(45/2 *kScale, 14*kScale));
        make.centerY.equalTo(calculate);
        make.left.equalTo(calculate);
        
    }];
    
    [segment makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.equalTo(CGSizeMake(kWidth, 10));
        make.centerX.equalTo(self.view);
        make.top.equalTo(calculate.mas_bottom).offset(20);
        
    }];
    
    [pDescripution makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(segment.mas_bottom).offset(20);
        make.left.equalTo(self.mainScroll).offset(20);
        
    }];

    [self.view layoutIfNeeded];
}

#pragma mark - NetWorks

- (void)sendHttpRequest{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[kCurrentController] = self;
    parameters[@"goodsLid"] = self.goodsLid;
    
    [OutsourceNetWork onHttpCode:kProductionDetailNetWork WithParameters:parameters];
}

- (void)sendSubmitOrderRequest{

    NSMutableDictionary *production = [NSMutableDictionary new];
    production[@"lGoodsid"] = self.pModel.lId;
    production[@"strGoodsname"] = self.pModel.strGoodsname;
    NSInteger totalPrice = ([self.pModel.nPrice integerValue] * self.pNumber);
    production[@"nGoodsTotalPrice"] = [NSString stringWithFormat:@"%ld",totalPrice];
    production[@"strGoodsimgurl"] = self.pModel.strGoodsimgurl;
    production[@"nPrice"] = [NSString stringWithFormat:@"%@",self.pModel.nPrice];
    production[@"nCount"] = [NSString stringWithFormat:@"%ld",self.pNumber];
    NSMutableArray *productions = [NSMutableArray arrayWithObjects:production, nil];
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[kCurrentController] = self;
    parameters[@"lBuyerid"] = [UserTools getUserId];
    parameters[@"strBuyername"] = @"姓名";
    parameters[@"nTotalprice"] = production[@"nGoodsTotalPrice"];
    parameters[@"orderGoods"] = productions;
    parameters[@"nAddOrderType"] = @"0";
    
    [OutsourceNetWork onHttpCode:kSubmitOrderNetWork WithParameters:parameters];
  
    [MBProgressHUDManager showHUDAddedTo:self.view];
}

- (void)getProductionDetail:(id)responseObj{

    self.pModel = [ProductionModel mj_objectWithKeyValues:responseObj];
    
    [self loadProductionData:responseObj];

    NSLog(@"%@",responseObj);
    
}

- (void)resultOfSubmitOrder:(id)responseObj{

    [MBProgressHUDManager hideHUDForView:self.view];

    if ([responseObj[@"resCode"] isEqualToString:@"0"]) {
        
        OrderCreateController *create = [OrderCreateController new];
        create.orderId = responseObj[@"result"];
        
        [self.navigationController pushViewController:create animated:YES];

    }else{
    
        [MBProgressHUDManager showTextHUDAddedTo:self.view WithText:responseObj[@"result"] afterDelay:1.0f];
    }
    
    NSLog(@"%@",responseObj);

}



#pragma mark - Private Method

- (void)loadProductionData:(NSDictionary *)pDict{

    
    [self.pIcon sd_setImageWithURL:kGetImageUrl(URLHOST,@"0", self.pModel.lId) placeholderImage:[UIImage imageNamed:@"icon_outsouring_default.jpg"]];
    
    self.pTitle.text = self.pModel.strGoodsname;
    
    self.specifications.text = [NSString stringWithFormat:@"规格：%@",self.pModel.strStandard];
    
    self.pSales.text = [NSString stringWithFormat:@"销量%@",self.pModel.nMothnumber];
    
    self.pPrice.text = [NSString stringWithFormat:@"￥%.2f",[self.pModel.nPrice floatValue]/100];
    
    self.num.text = [NSString stringWithFormat:@"%ld",self.pNumber];
    
    CGFloat dHeight = self.pPrice.frame.origin.y + 140;
    
    if (!self.imageV) {
        
        self.imageV = [UIImageView new];
    }
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/common/getImg/2/%@",URLHOST,self.pModel.lId]] placeholderImage:[UIImage imageNamed:@"icon_outsouring_default.jpg"]];
    
    CGFloat iHeight = self.imageV.image.size.height * (kWidth - 40)/self.imageV.image.size.width;
    
    self.imageV.frame = CGRectMake(20, dHeight, kWidth - 40, iHeight);
    
    self.mainScroll.contentSize = CGSizeMake(kWidth, dHeight + iHeight);

    [self.mainScroll addSubview:self.imageV];

}

- (void)subtractionClick{
    
    if (self.pNumber > 1) {
        
        self.pNumber -= 1;
        
        self.num.text = [NSString stringWithFormat:@"%ld",self.pNumber];
    }
    
    NSLog(@"dadfadsfa");

}

- (void)addClick{
    
    self.pNumber += 1;
    
    self.num.text = [NSString stringWithFormat:@"%ld",self.pNumber];

    NSLog(@"dadfadsfa");

}

- (void)showShoppingCart:(UIButton *)sender{

    sender.selected = !sender.selected;
    
    if (sender.selected) {
        
        self.shoppingCart.frame = self.view.bounds;
        
        [self.shoppingCart configWithType:YES];
        
    }else{
    
        self.shoppingCart.frame = CGRectMake(0, kHeight - kTabBarHeight, kWidth, kTabBarHeight);
    
        [self.shoppingCart configWithType:NO];
    }
    
    
    
}

- (void)submitBtnClick:(UIButton *)sender{

    if ([UserTools getUserId]) {
        
        [self sendSubmitOrderRequest];
    }else{
    
        [[NSNotificationCenter defaultCenter] postNotificationName:NEEDLOGIN object:nil];
    }

}

- (void)viewTap:(UIGestureRecognizer *)tap{
    
    CGPoint point = [tap locationInView:self.shoppingCart];
    
    if (point.y < kHeight/2) {
        
        self.shoppingCart.shoppingBtn.selected = NO;
        self.shoppingCart.frame = CGRectMake(0, kHeight - kTabBarHeight, kWidth, kTabBarHeight);

        [self.shoppingCart configWithType:NO];
    }
    
    
}


- (void)foreAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
