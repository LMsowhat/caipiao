//
//  PaymentViewController.m
//  Outsourcing
//
//  Created by 李文华 on 2017/8/11.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "PaymentViewController.h"
#import "Masonry.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "EliveApplication.h"
#import "MBProgressHUDManager.h"
#import "MJExtension.h"

#import "OrdersViewController.h"
#import "MainTabBarController.h"
#import "PayResultView.h"

@interface PaymentViewController ()<WXApiDelegate>

@property (nonatomic ,strong)UILabel *moneyLabel;

@property (nonatomic ,strong)UIButton *selectedBtn;
//

@property (nonatomic ,strong)UIButton *confirmBtn;

@property (nonatomic ,strong)PayResultView *resultViewOfPayFor;


//记录订单信息

@property (nonatomic ,strong)NSMutableDictionary *orderDict;


@end

@implementation PaymentViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"支付";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 22, 17);
    [btn setImage:[UIImage imageNamed:@"naviBack"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(foreAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    //
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payCallBack:) name:aliPaySuccess object:nil];
    //
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wechatPayCallBack:) name:wechatPaySuccess object:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGBA(0xF7F7F7, 1.0);
    
    if (self.isTicketPay) {
        
        [self PayResult:YES];
    }else{
    
        [self loadConfigUI];
    }
    
    // Do any additional setup after loading the view.
}

#pragma mark Setter && Getter

- (UIButton *)confirmBtn{

    if (!_confirmBtn) {
        
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.frame = CGRectMake(0, kHeight - 24.5 *kScale, kWidth, 24.5 *kScale);
        [_confirmBtn setTitle:@"确认支付" forState:UIControlStateNormal];
        [_confirmBtn.titleLabel setFont:kFont(7)];
        [_confirmBtn.titleLabel setTextColor:UIColorFromRGBA(0xFFFFFF, 1.0)];
        _confirmBtn.backgroundColor = UIColorFromRGBA(0xFA6650, 1.0);
        [_confirmBtn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _confirmBtn;
}

#pragma mark Private Method

- (void)loadConfigUI{

    UIView *view1 = [UIView new];
    view1.backgroundColor = UIColorFromRGBA(0xFFFFFF, 1.0);
    
    UILabel *actual = [UILabel new];
    actual.font = kFont(7);
    actual.textColor = UIColorFromRGBA(0x333338, 1.0);
    actual.text = @"实付款:";
    
    self.moneyLabel = [UILabel new];
    self.moneyLabel.font = kFont(9);
    self.moneyLabel.textColor = UIColorFromRGBA(0xFA6650, 1.0);
    self.moneyLabel.text = [NSString stringWithFormat:@"%.2f",self.factTotalPrice/100];
    
    UIView *view2 = [UIView new];
    view2.backgroundColor = UIColorFromRGBA(0xFFFFFF, 1.0);

    UIImageView *aliImage = [UIImageView new];
    aliImage.image = [UIImage imageNamed:@"ali_icon"];
    
    UILabel *aliText = [UILabel new];
    aliText.font = kFont(7);
    aliText.textColor = UIColorFromRGBA(0x333338, 1.0);
    aliText.text = @"支付宝";
    
    UIButton *aliBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [aliBtn setImage:[UIImage imageNamed:@"unSelected"] forState:UIControlStateNormal];
    [aliBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
    [aliBtn addTarget:self action:@selector(aliPayClick:) forControlEvents:UIControlEventTouchUpInside];
    aliBtn.tag = 0;
    aliBtn.selected = YES;
    self.selectedBtn = aliBtn;
    
    UIView *view3 = [UIView new];
    view3.backgroundColor = UIColorFromRGBA(0xFFFFFF, 1.0);

    UIImageView *wechatImage = [UIImageView new];
    wechatImage.image = [UIImage imageNamed:@"wechat"];
    
    UILabel *wechatText = [UILabel new];
    wechatText.font = kFont(7);
    wechatText.textColor = UIColorFromRGBA(0x333338, 1.0);
    wechatText.text = @"微信支付";
    
    UIButton *wechatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [wechatBtn setImage:[UIImage imageNamed:@"unSelected"] forState:UIControlStateNormal];
    [wechatBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
    [wechatBtn addTarget:self action:@selector(wechatPayClick:) forControlEvents:UIControlEventTouchUpInside];
    wechatBtn.tag = 1;
    
    [view1 addSubview:actual];
    [view1 addSubview:self.moneyLabel];
    
    [view2 addSubview:aliImage];
    [view2 addSubview:aliText];
    [view2 addSubview:aliBtn];
    [view2 addSubview:wechatImage];
    [view2 addSubview:wechatText];
    [view2 addSubview:wechatBtn];
    [view2 addSubview:view3];
    
    [self.view addSubview:view1];
    [self.view addSubview:view2];
    [self.view addSubview:self.confirmBtn];
    
    [view1 makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.equalTo(CGSizeMake(kWidth, 31*kScale));
        
        make.top.equalTo(self.view).offset(kTopBarHeight);
        
        make.centerX.equalTo(self.view);
    }];
    
    [actual makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(view1);
        make.left.equalTo(view1).offset(10 *kScale);
    }];
    
    [self.moneyLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(actual);
        make.left.equalTo(actual.mas_right);
    }];
    
    [view2 makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.equalTo(CGSizeMake(kWidth, 66.5 *kScale));
        
        make.centerX.equalTo(self.view);

        make.top.equalTo(view1.mas_bottom).offset(5 *kScale);
    }];
    
    [aliImage makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.equalTo(CGSizeMake(12 *kScale, 12 *kScale));
        
        make.centerY.equalTo(view2).offset(-10 *kScale);
        
        make.left.equalTo(view2).offset(10 *kScale);
    }];
    
    [aliText makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(aliImage);
        
        make.left.equalTo(aliImage.mas_right).offset(5.5 *kScale);
    }];
    
    [aliBtn makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.equalTo(CGSizeMake(9 *kScale, 9 *kScale));
        
        make.centerY.equalTo(aliImage);
        
        make.right.equalTo(view2).offset(-13*kScale);
    }];
    
    [wechatImage makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.equalTo(CGSizeMake(12 *kScale, 12 *kScale));
        
        make.centerY.equalTo(view2).offset(10 *kScale);
        
        make.left.equalTo(view2).offset(10 *kScale);
    }];
    
    [wechatText makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(wechatImage);
        
        make.left.equalTo(wechatImage.mas_right).offset(5.5 *kScale);
    }];
    
    [wechatBtn makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.equalTo(CGSizeMake(9 *kScale, 9 *kScale));
        
        make.centerY.equalTo(wechatImage);
        
        make.right.equalTo(view2).offset(-13*kScale);
    }];
    
}

- (void)aliPayClick:(UIButton *)sender{

    if (self.selectedBtn.tag == sender.tag) {
        
        return;
    }
    self.selectedBtn.selected = NO;
    sender.selected = !sender.selected;
    self.selectedBtn = sender;
    
}
- (void)wechatPayClick:(UIButton *)sender{
    
    if (self.selectedBtn.tag == sender.tag) {
        
        return;
    }
    self.selectedBtn.selected = NO;
    sender.selected = !sender.selected;
    self.selectedBtn = sender;
}

- (void)PayResult:(BOOL)success{

    self.navigationItem.title = @"支付结果";

    if (success) {
        
        self.resultViewOfPayFor = [[PayResultView alloc] initSuccess:YES WithModel:self.orderModel];
        self.resultViewOfPayFor.frame = CGRectMake(0, kTopBarHeight, kWidth, kHeight - kTopBarHeight);
        [self.resultViewOfPayFor.seeOrderBtn addTarget:self action:@selector(seeOrderClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.resultViewOfPayFor.goBackBtn addTarget:self action:@selector(backHome:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:self.resultViewOfPayFor];
    }else{
    
        self.resultViewOfPayFor = [[PayResultView alloc] initSuccess:NO WithModel:nil];
        self.resultViewOfPayFor.frame = CGRectMake(0, kTopBarHeight, kWidth, kHeight - kTopBarHeight);
        [self.resultViewOfPayFor.payAgainBtn addTarget:self action:@selector(payAgainClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:self.resultViewOfPayFor];
    
    }

}


- (void)getAliPayOrderString:(id)responseObject{

    if ([responseObject[@"resCode"] isEqualToString:@"0"]) {
        
        [[AlipaySDK defaultService] payOrder:responseObject[@"result"] fromScheme:@"lwh15011075120" callback:^(NSDictionary *resultDic) {
            
            [self aliPayEdit:resultDic];
            
        }];
    }else{
        
        
        //获取订单失败
    }


}

- (void)aliPayEdit:(NSDictionary *)info{

    if ([info[@"resultStatus"] isEqualToString:@"9000"]) {
        
        NSString *string = info[@"result"];
        
        NSData *dictData = [string dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:dictData options:NSJSONReadingMutableContainers error:nil];
        
        if ([dic isKindOfClass:[NSDictionary class]] && dic[@"alipay_trade_app_pay_response"]) {
            
            self.orderDict = dic[@"alipay_trade_app_pay_response"];
            
            NSMutableDictionary *dict = [NSMutableDictionary new];
            dict[@"strOrdernum"] = self.orderDict[@"out_trade_no"];
            dict[@"dtCreatetime"] = self.orderDict[@"timestamp"];//
            dict[@"nFactPrice"] = self.orderDict[@"total_amount"];
            
            self.orderModel = [OrderModel mj_objectWithKeyValues:dict];
        }
        [self PayResult:YES];
    }else{
        
        [self PayResult:NO];
    }
}


- (void)getWechatPayOrderString:(id)responseObject{

    if ([responseObject[@"resCode"] isEqualToString:@"0"]) {
        
        NSDictionary *dict = responseObject[@"result"];

        //记录订单信息
        self.orderDict = [NSMutableDictionary new];
        self.orderDict[@"strOrdernum"] = dict[@"strOrdernum"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSString*dateTime = [formatter stringFromDate:[NSDate  date]];
        
        self.orderDict[@"dtCreatetime"] = dateTime;
        self.orderDict[@"nFactPrice"] = [NSString stringWithFormat:@"%.2f",[dict[@"nFactPrice"] floatValue]/100];
        self.orderModel = [OrderModel mj_objectWithKeyValues:self.orderDict];

        //填充微信支付参数
        PayReq *request = [PayReq new];
        request.openID = [dict objectForKey:@"lwh15011075120"];
        request.partnerId = [dict objectForKey:@"partnerid"];
        request.prepayId= [dict objectForKey:@"prepayid"];
        request.package = [dict objectForKey:@"package"];
        request.nonceStr= [dict objectForKey:@"noncestr"];
        request.timeStamp= [[dict objectForKey:@"timestamp"] intValue];
        request.sign= [dict objectForKey:@"sign"];
        [WXApi sendReq:request];
    }else{
        
        [MBProgressHUDManager showTextHUDAddedTo:self.view WithText:@"网络错误" afterDelay:1.0f];
        //获取订单失败
    }
}



- (void)payCallBack:(NSNotification *)noti{
    
    NSDictionary *resultDic = noti.userInfo;
    
    [self aliPayEdit:resultDic];
    
}


- (void)wechatPayCallBack:(NSNotification *)noti{
    
    NSDictionary *resultDic = noti.userInfo;

    if ([resultDic[@"resCode"] isEqualToString:@"0"]) {
        
        [self PayResult:YES];
        NSLog(@"展示成功页面");
    }else{
    
        if ([resultDic[@"resCode"] isEqualToString:@"-2"]) {
            
            NSLog(@"取消付款");
        }
        if ([resultDic[@"resCode"] isEqualToString:@"-1"]) {
            
            NSLog(@"可能的原因：签名错误、未注册APPID、项目设置APPID不正确、注册的APPID与设置的不匹配、其他异常等。");
        }
        [self PayResult:NO];
    }
}



- (void)confirmClick{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[kCurrentController] = self;
    parameters[@"lId"] = self.orderId;
    parameters[@"nOrderType"] = self.nOrderType;
    parameters[@"nPayType"] = [NSString stringWithFormat:@"%ld",self.selectedBtn.tag];
    
    [OutsourceNetWork onHttpCode:kAliPayNetWork WithParameters:parameters];
    NSLog(@"%ld",self.selectedBtn.tag);
}


- (void)seeOrderClick:(id)sender{
    
    OrdersViewController *orderList = [OrdersViewController new];
    
    [self.navigationController pushViewController:orderList animated:YES];
    
}

- (void)backHome:(id)sender{
    
    MainTabBarController *mainTab = (MainTabBarController *)self.tabBarController;
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    mainTab.tabBar.hidden = NO;
    mainTab.selectedIndex = 0;
    
}

- (void)payAgainClick:(id)sender{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        [self.resultViewOfPayFor removeFromSuperview];
    }];
    
    
}


- (void)foreAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
