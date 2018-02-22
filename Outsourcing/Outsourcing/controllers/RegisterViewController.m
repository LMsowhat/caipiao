//
//  RegisterViewController.m
//  Eliveapp
//
//  Created by 李文华 on 2017/3/29.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "RegisterViewController.h"
#import "MBProgressHUDManager.h"
#import "AFNetWorkManagerConfig.h"
#import "EliveApplication.h"
#import "AgreementTextViewController.h"
#import "Masonry.h"

@interface RegisterViewController ()<UITextFieldDelegate>

@property (nonatomic ,strong)UITextField *userNameTextField;

@property (nonatomic ,strong)UITextField *messageCodeTextField;

@property (nonatomic ,strong)UITextField *psdTextField;

@property (nonatomic ,strong)UITextField *aPsdTextField;

@property (nonatomic ,strong)UIButton *getCodeBtn;

@property (nonatomic ,strong)UIButton *bottomRegisterBtn;

@end

@implementation RegisterViewController

-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden = NO;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 22, 17);
    [btn setImage:[UIImage imageNamed:@"naviBack"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(foreAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [self.navigationItem setLeftBarButtonItem:leftItem];
   
    self.navigationController.navigationBar.barTintColor = UIColorFromRGBA(0xFFFFFF, 1.0);
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:UIColorFromRGBA(0x1C1F2D, 1.0)};
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册";
    self.view.backgroundColor = UIColorFromRGBA(0xF7F7F7, 1.0);

    [self loadConfigView];
//    
//    WeakSelf(weakSelf);
//
//    self.mainView = [[LoginViews alloc] initWithFrame:CGRectMake(0, kTopBarHeight, kWidth, kHeight/2) Name:@"注册" CodeBlock:^{
//        //倒计时
//        [self countDown];
//        
//    } BottomBlock:^(int type ,BOOL isAgreement) {
//        
//        NSMutableDictionary *parameters = [NSMutableDictionary new];
//        parameters[kCurrentController] = self;
//        parameters[@"strMobile"] = self.mainView.phoneTextField.text;
//        parameters[@"strPassword"] = @"123456";
//        parameters[@"strUserSmsCode"] = @"4444";
//
//        [AFNetWorkManagerConfig POST:@"buyer/register" baseURL:URLHOST params:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
//            
//            NSLog(@"%@",responseObject);
//            
//        } fail:^(NSURLSessionDataTask *task, NSError *error) {
//            
//            NSLog(@"%@",error);
//            
//        }];
//        //
//    }];

}

#pragma mark Privite Method

- (void)loadConfigView{

    UIView *view1 = [UIView new];
    view1.backgroundColor = UIColorFromRGBA(0xFFFFFF, 1.0);
    [view1 addSubview:self.userNameTextField];
    [view1 addSubview:self.getCodeBtn];
    
    UIView *view2 = [UIView new];
    view2.backgroundColor = UIColorFromRGBA(0xFFFFFF, 1.0);
    [view2 addSubview:self.messageCodeTextField];
    
    UIView *view3 = [UIView new];
    view3.backgroundColor = UIColorFromRGBA(0xFFFFFF, 1.0);
    [view3 addSubview:self.psdTextField];
    
    UIView *view4 = [UIView new];
    view4.backgroundColor = UIColorFromRGBA(0xFFFFFF, 1.0);
    [view4 addSubview:self.aPsdTextField];
    
    [self.view addSubview:view1];
    [self.view addSubview:view2];
    [self.view addSubview:view3];
    [self.view addSubview:view4];
    [self.view addSubview:self.bottomRegisterBtn];
    
    [view1 makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view);
        
        make.size.equalTo(CGSizeMake(kWidth, 30 *kScale));
        
        make.top.equalTo(self.view).offset(@(kTopBarHeight + 10));
        
    }];
    
    [view2 makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view);
        
        make.size.equalTo(CGSizeMake(kWidth, 30 *kScale));
        
        make.top.equalTo(view1.mas_bottom).offset(10);
        
    }];
    
    [view3 makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view);
        
        make.size.equalTo(CGSizeMake(kWidth, 30 *kScale));
        
        make.top.equalTo(view2.mas_bottom).offset(10);
        
    }];
    
    [view4 makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view);
        
        make.size.equalTo(CGSizeMake(kWidth, 30 *kScale));
        
        make.top.equalTo(view3.mas_bottom).offset(10);
        
    }];
    
    [self.getCodeBtn makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(view1);
        
        make.size.equalTo(CGSizeMake(68*kScale, 30 * kScale));
        
        make.right.equalTo(view1);
        
        
    }];

    [self.userNameTextField makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(view1);
        
        make.size.equalTo(CGSizeMake(kWidth - 15*kScale - 68*kScale, 30 * kScale));
        
        make.left.equalTo(view1).offset(15*kScale);
        
    }];
    
    [self.messageCodeTextField makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(view2);
        
        make.size.equalTo(CGSizeMake(kWidth - 15*kScale, 30 * kScale));
        
        make.left.equalTo(view2).offset(15*kScale);
        
    }];
    
    [self.psdTextField makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(view3);
        
        make.size.equalTo(CGSizeMake(kWidth - 15*kScale, 30 * kScale));
        
        make.left.equalTo(view3).offset(15*kScale);
        
    }];
    
    [self.aPsdTextField makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(view4);
        
        make.size.equalTo(CGSizeMake(kWidth - 15*kScale, 30 * kScale));
        
        make.left.equalTo(view4).offset(15*kScale);
        
    }];

    [self.bottomRegisterBtn makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view);
        
        make.bottom.equalTo(self.view);
        
        make.size.equalTo(CGSizeMake(kWidth, 24.5 * kScale));
    }];
}

- (void)getCodeClick:(UIButton *)sender{

    if (self.userNameTextField.text.length != 11) {
        
        [MBProgressHUDManager showTextHUDAddedTo:self.navigationController.view WithText:@"请输入正确的手机号" afterDelay:1.0f];
        return;
    }
    sender.userInteractionEnabled = NO;
    
    //获取验证码
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[kCurrentController] = self;
    parameters[@"strMobile"] = self.userNameTextField.text;
    parameters[@"type"] = @"0";
    
    [OutsourceNetWork onHttpCode:kUserSendCodeNetWork WithParameters:parameters];

    [self countDown];

    NSLog(@"getCodeClick !!!!");
}


- (void)registerBtnClick{

    BOOL checkInput = [self checkTheTextFieldInput];

    if (checkInput) {
        
        NSMutableDictionary *parameters = [NSMutableDictionary new];
        parameters[kCurrentController] = self;
        parameters[@"strMobile"] = self.userNameTextField.text;
        parameters[@"strPassword"] = self.psdTextField.text;
        parameters[@"strUserSmsCode"] = self.messageCodeTextField.text;
        
        [OutsourceNetWork onHttpCode:kUserRegisterNetWork WithParameters:parameters];
    }

    NSLog(@"registerBtnClick!!!!");
}

- (BOOL)checkTheTextFieldInput{

    if (self.userNameTextField.text.length != 11) {
        
        [MBProgressHUDManager showTextHUDAddedTo:self.navigationController.view WithText:@"请输入正确的手机号" afterDelay:1.0f];
        return NO;
    }
    if (self.messageCodeTextField.text.length <= 0) {
        
        [MBProgressHUDManager showTextHUDAddedTo:self.navigationController.view WithText:@"请输入验证码" afterDelay:1.0f];
        return NO;
    }
    if (self.psdTextField.text.length <= 0) {
        
        [MBProgressHUDManager showTextHUDAddedTo:self.navigationController.view WithText:@"请输入合格的密码" afterDelay:1.0f];
        return NO;
    }
    return YES;
}

#pragma mark Setter && Getter

-(UITextField *)userNameTextField{

    if (!_userNameTextField) {
        
        _userNameTextField = [UITextField new];
        
        _userNameTextField.delegate = self;
        
        _userNameTextField.backgroundColor = UIColorFromRGBA(0xFFFFFF, 1.0);
        
        _userNameTextField.font = kFont(7);
        
        _userNameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入您的手机号码" attributes:@{NSForegroundColorAttributeName:UIColorFromRGBA(0x8F9095, 1.0)}];
        
        [_userNameTextField addTarget:self action:@selector(phoneEditChanged:) forControlEvents:UIControlEventEditingChanged];
    }

    return _userNameTextField;
}

-(UITextField *)messageCodeTextField{
    
    if (!_messageCodeTextField) {
        
        _messageCodeTextField = [UITextField new];
        
        _messageCodeTextField.delegate = self;
        
        _messageCodeTextField.backgroundColor = UIColorFromRGBA(0xFFFFFF, 1.0);
        
        _messageCodeTextField.font = kFont(7);
        
        _messageCodeTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:@{NSForegroundColorAttributeName:UIColorFromRGBA(0x8F9095, 1.0)}];
        
        [_messageCodeTextField addTarget:self action:@selector(codeEditChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    
    return _messageCodeTextField;
}

-(UITextField *)psdTextField{
    
    if (!_psdTextField) {
        
        _psdTextField = [UITextField new];
        
        _psdTextField.delegate = self;
        
        _psdTextField.backgroundColor = UIColorFromRGBA(0xFFFFFF, 1.0);
        
        _psdTextField.font = kFont(7);
        
        _psdTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName:UIColorFromRGBA(0x8F9095, 1.0)}];
        
        [_psdTextField addTarget:self action:@selector(passWordEditChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    
    return _psdTextField;
}

-(UITextField *)aPsdTextField{
    
    if (!_aPsdTextField) {
        
        _aPsdTextField = [UITextField new];
        
        _aPsdTextField.delegate = self;
        
        _aPsdTextField.backgroundColor = UIColorFromRGBA(0xFFFFFF, 1.0);
        
        _aPsdTextField.font = kFont(7);
        
        _aPsdTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入邀请码" attributes:@{NSForegroundColorAttributeName:UIColorFromRGBA(0x8F9095, 1.0)}];
        
        [_aPsdTextField addTarget:self action:@selector(againPassWordEditChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    
    return _aPsdTextField;
}

-(UIButton *)bottomRegisterBtn{
    
    if (!_bottomRegisterBtn) {
        
        _bottomRegisterBtn = [UIButton new];
        
        _bottomRegisterBtn.backgroundColor = UIColorFromRGBA(0xFA6650, 1.0);
        
        _bottomRegisterBtn.titleLabel.font = kFont(7);
        
        [_bottomRegisterBtn setTitle:@"注册" forState:UIControlStateNormal];
        
        [_bottomRegisterBtn setTitleColor:UIColorFromRGBA(0xFFFFFF, 1.0) forState:UIControlStateNormal];
        
        [_bottomRegisterBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _bottomRegisterBtn;
}

-(UIButton *)getCodeBtn{

    if (!_getCodeBtn) {
        
        _getCodeBtn = [UIButton new];
        _getCodeBtn.backgroundColor = UIColorFromRGBA(0xFA6650, 1.0);
        _getCodeBtn.titleLabel.font = kFont(7);
        [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getCodeBtn setTitleColor:UIColorFromRGBA(0xFFFFFF, 1.0) forState:UIControlStateNormal];
        [_getCodeBtn addTarget:self action:@selector(getCodeClick:) forControlEvents:UIControlEventTouchUpInside];
    }

    return _getCodeBtn;
}

#pragma mark -UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(nonnull NSString *)string
{
    //禁止输入空格
    if ([string isEqual: @" "]) return NO;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //当用户按下ruturn，把焦点从textField移开那么键盘就会消失了
    [textField resignFirstResponder];
    
    return YES;
}

- (void)codeEditChanged:(UITextField *)sender{
    
    
}

- (void)phoneEditChanged:(UITextField *)sender{
    

}

- (void)passWordEditChanged:(UITextField *)sender{
    
 
}

- (void)againPassWordEditChanged:(UITextField *)sender{
    
  
}


#pragma mark -处理网络请求结果

- (void)registerSendCodeGetData:(NSDictionary *)data{

    [MBProgressHUDManager showTextHUDAddedTo:self.view WithText:data[@"result"] afterDelay:1.0f];

}

- (void)registerGetData:(NSDictionary *)data{
    
    if ([data[@"resCode"] isEqualToString:@"0"]) {
        
        [self foreAction];
        
    }else{
        
        [MBProgressHUDManager showTextHUDAddedTo:self.view WithText:data[@"result"] afterDelay:1.0f];
    }
    
}



- (void)countDown{
    
    //
    __block int timeout=60; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout<=0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                
                [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                self.getCodeBtn.userInteractionEnabled = YES;

//                [self.mainView changeGetCodeUIWithText:@"获取验证码" Enable:YES];
                
            });
            
        }else{
            
            //            int minutes = timeout / 60;
            
//            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", timeout];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                
                NSLog(@"____%@",strTime);
                
                [self.getCodeBtn setTitle:[NSString stringWithFormat:@"获取验证码(%@)",strTime] forState:UIControlStateNormal];
                
            });
            
            timeout--;
            
        }
        
    });
    
    dispatch_resume(_timer);
    
}

- (void)editResultBy:(id)responseObject{
    
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        
        NSString *text = nil;

        NSInteger code = 0;
        if (responseObject[@"code"]) {
            code = [responseObject[@"code"] intValue];
        }
        if (responseObject[@"status"]) {
            
            code = [responseObject[@"status"] intValue];
        }
        
        switch (code) {
                
            case 0:
                text = responseObject[@"data"][@"msg"];
                
                break;
                
            case 1:
                text = @"短信验证码已发送";
                
                break;
                
            case 101:
                text = @"该手机号格式不正确";
                
                break;
            case 102:
                text = @"该手机号已注册";
                
                break;
            case 103:
                text = @"手机号或验证码不正确";
                
                break;
            default:
                text = @"请检查网络连接";
                
                break;
        }
        
        [MBProgressHUDManager showTextHUDAddedTo:self.navigationController.view WithText:text afterDelay:2.0f];
    }
    
}


- (UIView *)getLineViewWithFrame:(CGRect)frame color:(UIColor *)color{
    
    UIView *lineView = [[UIView alloc] initWithFrame:frame];
    lineView.backgroundColor = color;
    return lineView;
}


- (void)foreAction{
    
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)loginSuccess:(NSString *)userId{
    
    [UserTools setUserId:userId];
    

}


@end
