//
//  MyBarrelViewController.m
//  Outsourcing
//
//  Created by 李文华 on 2017/8/17.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "MyBarrelViewController.h"
#import "Masonry.h"

#import "EliveApplication.h"
#import "MBProgressHUDManager.h"


@interface MyBarrelViewController ()

@property (nonatomic ,strong)UILabel *bucketLabel;

@property (nonatomic ,strong)UILabel *bucketPriceLabel;

@property (nonatomic ,assign)NSInteger currentNumber;

@property (nonatomic ,assign)NSInteger refundNumber;


@end

@implementation MyBarrelViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.navigationItem.title = @"我的水桶";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 22, 17);
    [btn setImage:[UIImage imageNamed:@"naviBack"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(foreAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    [self sendHttpRequest];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGBA(0xF7F7F7, 1.0);
    
    [self loadViewWithData:nil];
    // Do any additional setup after loading the view.
}

- (void)sendHttpRequest{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[kCurrentController] = self;
    parameters[@"userId"] = [UserTools getUserId];
    
    [OutsourceNetWork onHttpCode:kUserGetBucketNetWork WithParameters:parameters];
}


- (void)getMyBarrel:(id)responseObject{

    if ([responseObject[@"resCode"] isEqualToString:@"0"]) {
        
        self.bucketLabel.text = [NSString stringWithFormat:@"%ld个",[responseObject[@"result"][@"nBucketNum"] integerValue]];
        
        self.bucketPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",[responseObject[@"result"][@"nBucketMoney"] floatValue]/100];
    }else{
        self.bucketLabel.text = @"0个";
        
        self.bucketPriceLabel.text = @"￥0.00";
        
        [MBProgressHUDManager showTextHUDAddedTo:self.view WithText:responseObject[@"result"] afterDelay:1.0f];
    }
    
}


- (void)refundBucket:(id)responseObject{

    [MBProgressHUDManager showTextHUDAddedTo:self.view WithText:responseObject[@"result"] afterDelay:1.0f];
    
    NSLog(@"%@",responseObject);

}


- (void)loadViewWithData:(id)responseObj{

    UIView *view2 = [UIView new];
    view2.backgroundColor = UIColorFromRGBA(0xFFFFFF, 1.0);
    
    UILabel *v2_label1 = [UILabel new];
    v2_label1.font = kFont(7);
    v2_label1.textColor = UIColorFromRGBA(0x333338, 1.0);
    v2_label1.text = @"水桶个数：";
    
    self.bucketLabel = [UILabel new];
    self.bucketLabel.font = kFont(9);
    self.bucketLabel.textColor = UIColorFromRGBA(0x333338, 1.0);
    self.bucketLabel.text = @"999个";
    self.bucketLabel.textAlignment = NSTextAlignmentCenter;
    
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"icon_bucket"];

    UIView *lineView = [UIView new];
    lineView.backgroundColor = UIColorFromRGBA(0xDDDDDD, 1.0);
    
    UILabel *label1 = [UILabel new];
    label1.font = kFont(7);
    label1.textColor = UIColorFromRGBA(0x333338, 1.0);
    label1.text = @"可退金额：";
    
    self.bucketPriceLabel = [UILabel new];
    self.bucketPriceLabel.font = kFont(9);
    self.bucketPriceLabel.textColor = UIColorFromRGBA(0xFA6650, 1.0);
    self.bucketPriceLabel.text = @"￥400";
    
    [view2 addSubview:v2_label1];
    [view2 addSubview:self.bucketLabel];
    [view2 addSubview:imageView];
    [view2 addSubview:lineView];
    [view2 addSubview:label1];
    [view2 addSubview:self.bucketPriceLabel];
    
    [self.view addSubview:view2];
    
    
    [view2 makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.equalTo(CGSizeMake(kWidth, 93 *kScale));
        
        make.centerX.equalTo(self.view);
        
        make.top.equalTo(self.view).offset(kTopBarHeight);
    }];
    
    [v2_label1 makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.equalTo(10 *kScale);
    }];
    
    [self.bucketLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(view2).offset(25 *kScale);
        
        make.centerX.equalTo(view2);
    }];
    
    [imageView makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.equalTo(CGSizeMake(10*kScale, 10*kScale));
        
        make.centerX.equalTo(view2);
        
        make.top.equalTo(self.bucketLabel.mas_bottom).offset(5 *kScale);
    }];

    [lineView makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.equalTo(CGSizeMake(kWidth - 10 *kScale, 1));
        
        make.centerX.equalTo(view2);
        
        make.top.equalTo(imageView.mas_bottom).offset(10 *kScale);
    }];
    
    [label1 makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(lineView.mas_bottom).offset(10 *kScale);
        
        make.left.equalTo(view2).offset(10 *kScale);
    }];
    
    [self.bucketPriceLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(label1.mas_right);
        
        make.centerY.equalTo(label1);
    }];
    
    UIButton *refundBucket = [UIButton buttonWithType:UIButtonTypeCustom];
    refundBucket.frame = CGRectMake(0, kHeight - 24.5 *kScale, kWidth, 24.5 *kScale);
    [refundBucket setTitle:@"退桶" forState:UIControlStateNormal];
    [refundBucket.titleLabel setFont:kFont(7)];
    [refundBucket.titleLabel setTextColor:UIColorFromRGBA(0xFFFFFF, 1.0)];
    refundBucket.backgroundColor = UIColorFromRGBA(0xFA6650, 1.0);
    [refundBucket addTarget:self action:@selector(refundBucketClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:refundBucket];
}


- (void)refundBucketClick{
    
    WeakSelf(weakSelf);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请输入退桶数量" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        if (weakSelf.refundNumber > weakSelf.currentNumber) {
            
            [MBProgressHUDManager showTextHUDAddedTo:weakSelf.view WithText:@"不能超过现有桶个数" afterDelay:1.0f];
        }else{
        
            NSMutableDictionary *parameters = [NSMutableDictionary new];
            parameters[kCurrentController] = self;
            parameters[@"lUserId"] = [UserTools getUserId];
            parameters[@"strUserName"] = @"liwenhua";
            parameters[@"nBucketNum"] = [NSString stringWithFormat:@"%ld",self.refundNumber];
            
            [OutsourceNetWork onHttpCode:kUserRefundBucketNetWork WithParameters:parameters];
        }

    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        return ;
    }]];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.keyboardType = UIKeyboardTypeNumberPad;
        [[NSNotificationCenter defaultCenter] addObserver:weakSelf selector:@selector(alertTextFieldDidChange:) name:UITextFieldTextDidChangeNotification object:textField];

    }];
    
    [weakSelf presentViewController:alertController animated:YES completion:nil];
    
    
}

- (void)alertTextFieldDidChange:(NSNotification *)noti{

    UITextField *textFile = noti.object;
    
    self.refundNumber = [textFile.text integerValue];
    NSLog(@"%@",textFile.text);
    
}

- (void)foreAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
