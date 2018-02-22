
//
//  MyInvitationViewController.m
//  Outsourcing
//
//  Created by 李文华 on 2017/8/16.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "MyInvitationViewController.h"
#import "Masonry.h"



@interface MyInvitationViewController ()

@end

@implementation MyInvitationViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.navigationItem.title = @"我要邀请";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 22, 17);
    [btn setImage:[UIImage imageNamed:@"naviBack"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(foreAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGBA(0xF7F7F7, 1.0);
    
    [self loadViewWithData:nil];
    // Do any additional setup after loading the view.
}

- (void)loadViewWithData:(id)responseObj{

    UIView *view1 = [UIView new];
    view1.backgroundColor = UIColorFromRGBA(0xFFFFFF, 1.0);
    
    UILabel *v1_label1 = [UILabel new];
    v1_label1.font = kFont(7);
    v1_label1.textColor = UIColorFromRGBA(0x333338, 1.0);
    v1_label1.text = @"促销活动：";
    
    UILabel *v1_label2 = [UILabel new];
    v1_label2.font = kFont(5.5);
    v1_label2.textColor = UIColorFromRGBA(0x8F9095, 1.0);
    v1_label2.text = @"2017-07-20 16:20";
    
    UILabel *v1_label3 = [UILabel new];
    v1_label3.numberOfLines = 0;
//    v1_label3.font = kFont(6);
//    v1_label3.textColor = UIColorFromRGBA(0x8F9095, 1.0);
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentJustified;
    NSString *tString = @"活动说明内容抽奖成功，您已获得20元优惠券请到我的优惠券中查看详情。优惠券有效期20天。另外成功邀请朋友可以再获得50元优惠券。";
    NSMutableAttributedString *muString = [[NSMutableAttributedString alloc] initWithString:tString];
    NSRange range =NSMakeRange(0,tString.length);
    [muString addAttribute:NSParagraphStyleAttributeName value:paragraph range:range];
    [muString addAttributes:@{NSForegroundColorAttributeName:UIColorFromRGBA(0x8F9095, 1.0),NSFontAttributeName:kFont(6)} range:range];
    v1_label3.attributedText = muString;
    
    UIView *view2 = [UIView new];
    view2.backgroundColor = UIColorFromRGBA(0xFFFFFF, 1.0);

    UILabel *v2_label1 = [UILabel new];
    v2_label1.font = kFont(7);
    v2_label1.textColor = UIColorFromRGBA(0x333338, 1.0);
    v2_label1.text = @"我的邀请码：";
    
    UILabel *v2_label2 = [UILabel new];
    v2_label2.font = kFont(9);
    v2_label2.textColor = UIColorFromRGBA(0x333338, 1.0);
    v2_label2.text = [UserTools userInviteCode];
    v2_label2.textAlignment = NSTextAlignmentCenter;
    
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"icon_invite"];
    
    [view1 addSubview:v1_label1];
    [view1 addSubview:v1_label2];
    [view1 addSubview:v1_label3];

    [view2 addSubview:v2_label1];
    [view2 addSubview:v2_label2];
    [view2 addSubview:imageView];
    
    [self.view addSubview:view1];
    [self.view addSubview:view2];
    
    [view1 makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.equalTo(CGSizeMake(kWidth, 60 *kScale));
        
        make.top.equalTo(self.view).offset(kTopBarHeight);
        
        make.centerX.equalTo(self.view);
    }];
    
    [v1_label1 makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.equalTo(view1).offset(10*kScale);;
    }];
    
    [v1_label2 makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(v1_label1);
        
        make.right.equalTo(view1).offset(-10 *kScale);
    }];
    
    [v1_label3 makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(view1);
        
        make.top.equalTo(view1).offset(23 *kScale);
        
        make.left.equalTo(view1).offset(10 *kScale);
        
        make.right.equalTo(view1).offset(-10 *kScale);
    }];
    
    [view2 makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.equalTo(CGSizeMake(kWidth, 62 *kScale));
        
        make.centerX.equalTo(self.view);
        
        make.top.equalTo(view1.mas_bottom).offset(5 *kScale);
    }];
    
    [v2_label1 makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.equalTo(10 *kScale);
    }];
    
    [v2_label2 makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(view2).offset(25 *kScale);
        
        make.centerX.equalTo(view2);
    }];
    
    [imageView makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.equalTo(CGSizeMake(10*kScale, 10*kScale));
        
        make.centerX.equalTo(view2);
        
        make.top.equalTo(v2_label2.mas_bottom).offset(5 *kScale);
    }];
}

- (void)foreAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
