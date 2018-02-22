//
//  LoginViewController.m
//  Eliveapp
//
//  Created by 李文华 on 2017/3/28.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "LoginViewController.h"
#import "MBProgressHUDManager.h"
#import "AFNetWorkManagerConfig.h"
#import "EliveApplication.h"
#import "Masonry.h"


#import "RegisterViewController.h"
#import "RetrievePasswordViewController.h"



@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic ,strong)UITextField *uNameTextField;

@property (nonatomic ,strong)UITextField *psdTextField;

@property (nonatomic ,strong)UIButton *bottomLoginBtn;


@end

@implementation LoginViewController

#pragma mark - lifeMethod

-(void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBarHidden = NO;

    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 22, 17);
    [btn setImage:[UIImage imageNamed:@"naviBack"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(foreAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [self.navigationItem setLeftBarButtonItem:leftItem];

    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0, 0, 35, 21);
    btn2.titleLabel.font = kFont(7);
    [btn2 setTitle:@"注册" forState:UIControlStateNormal];
    [btn2 setTitleColor:UIColorFromRGBA(0xFA6650, 1.0) forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(toRegist) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn2];
    [self.navigationItem setRightBarButtonItem:rightItem];
    
    
    self.navigationController.navigationBar.barTintColor = UIColorFromRGBA(0xFFFFFF, 1.0);
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:UIColorFromRGBA(0x1C1F2D, 1.0)};

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"登录";

    self.view.backgroundColor = UIColorFromRGBA(0xF7F7F7, 1.0);

    [self loadConfigView];
 
}

#pragma mark Private Method

- (void)loadConfigView{
    
    UIView *view1 = [UIView new];
    view1.backgroundColor = UIColorFromRGBA(0xFFFFFF, 1.0);
    [view1 addSubview:self.uNameTextField];
    
    UIView *view2 = [UIView new];
    view2.backgroundColor = UIColorFromRGBA(0xFFFFFF, 1.0);
    [view2 addSubview:self.psdTextField];
    
    UIButton *forgetPsd = [UIButton new];
    forgetPsd.titleLabel.font = kFont(6);
    [forgetPsd setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [forgetPsd setTitleColor:UIColorFromRGBA(0x8F9095, 1.0) forState:UIControlStateNormal];
    [forgetPsd setTitleColor:UIColorFromRGBA(0xFA6650, 1.0) forState:UIControlStateHighlighted];
    [forgetPsd addTarget:self action:@selector(forgetPsdClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:view1];
    [self.view addSubview:view2];
    [self.view addSubview:forgetPsd];
    [self.view addSubview:self.bottomLoginBtn];
    
    [view1 makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view);
        
        make.size.equalTo(CGSizeMake(kWidth, 30 * kScale));
        
        make.top.equalTo(self.view).offset(@(kTopBarHeight + 10));
        
    }];
    
    [view2 makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view);
        
        make.size.equalTo(CGSizeMake(kWidth, 30 * kScale));
        
        make.top.equalTo(view1.mas_bottom).offset(10);
        
    }];
    
    
    [self.uNameTextField makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(view1);
        
        make.size.equalTo(CGSizeMake(kWidth - 15*kScale, 30 * kScale));
        
        make.left.equalTo(view1).offset(15*kScale);
        
    }];
    
    [self.psdTextField makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(view2);
        
        make.size.equalTo(CGSizeMake(kWidth - 15*kScale, 30 * kScale));
        
        make.left.equalTo(view2).offset(15*kScale);
        
    }];
    
    [forgetPsd makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view);
        
        make.top.equalTo(view2.mas_bottom).offset(10 *kScale);
        
    }];
    
    [self.bottomLoginBtn makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view);
        
        make.bottom.equalTo(self.view);
        
        make.size.equalTo(CGSizeMake(kWidth, 24.5 * kScale));
    }];

}



- (void)forgetPsdClick{

    RetrievePasswordViewController *getBack = [RetrievePasswordViewController new];

    [self.navigationController pushViewController:getBack animated:YES];
    NSLog(@"forget password！！！！");
}

//loginBtnClick
- (void)loginBtnClick{
    
    BOOL pass = [self checkTheTextFieldInput];
    
    if (pass) {
        
        NSMutableDictionary *parameters = [NSMutableDictionary new];
        parameters[kCurrentController] = self;
        parameters[@"strMobile"] = self.uNameTextField.text;
        parameters[@"strPassword"] = self.psdTextField.text;
        
        [OutsourceNetWork onHttpCode:kUserLoginNetWork WithParameters:parameters];
        
    }
    NSLog(@"loginBtn Click！！！！");
}

- (BOOL)checkTheTextFieldInput{

    if (self.uNameTextField.text.length != 11) {
        
        [MBProgressHUDManager showTextHUDAddedTo:self.navigationController.view WithText:@"请填写正确的用户名" afterDelay:1.0f];
     
        return NO;
    }
    if (self.psdTextField.text.length <= 0) {
        
        [MBProgressHUDManager showTextHUDAddedTo:self.navigationController.view WithText:@"请填写正确的密码" afterDelay:1.0f];

        return NO;
    }
    
    return YES;
}



#pragma mark Setter && Getter

-(UITextField *)uNameTextField{

    if (!_uNameTextField) {
        
        _uNameTextField = [UITextField new];
        
        _uNameTextField.delegate = self;
        
        _uNameTextField.backgroundColor = UIColorFromRGBA(0xFFFFFF, 1.0);
        
        _uNameTextField.font = kFont(7);

        _uNameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入用户名" attributes:@{NSForegroundColorAttributeName:UIColorFromRGBA(0x8F9095, 1.0)}];
        
        [_uNameTextField addTarget:self action:@selector(phoneEditChanged:) forControlEvents:UIControlEventEditingChanged];
        
    }

    return _uNameTextField;
}

-(UITextField *)psdTextField{
    
    if (!_psdTextField) {
        
        _psdTextField = [UITextField new];
        
        _psdTextField.delegate = self;
        
        _psdTextField.secureTextEntry = YES;
        
        _psdTextField.backgroundColor = UIColorFromRGBA(0xFFFFFF, 1.0);
        
        _psdTextField.font = kFont(7);

        _psdTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName:UIColorFromRGBA(0x8F9095, 1.0)}];
        
        [_psdTextField addTarget:self action:@selector(codeEditChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    
    return _psdTextField;
}

-(UIButton *)bottomLoginBtn{

    if (!_bottomLoginBtn) {
        
        _bottomLoginBtn = [UIButton new];
        
        _bottomLoginBtn.backgroundColor = UIColorFromRGBA(0xFA6650, 1.0);
        
        _bottomLoginBtn.titleLabel.font = kFont(7);
        
        [_bottomLoginBtn setTitle:@"登录" forState:UIControlStateNormal];
        
        [_bottomLoginBtn setTitleColor:UIColorFromRGBA(0xFFFFFF, 1.0) forState:UIControlStateNormal];
        
        [_bottomLoginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }

    return _bottomLoginBtn;
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

#pragma mark -处理网络请求

- (void)loginSendCodeGetData:(NSDictionary *)data{

    [self editResultBy:data];
//    [self countDown];
 
}

- (void)loginGetData:(NSDictionary *)data{
    
    if ([data[@"resCode"] isEqualToString:@"0"]) {

        [self loginSuccess:data[@"result"]];

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
                
//                [self.mainView changeGetCodeUIWithText:@"获取验证码" Enable:YES];
                
            });
            
        }else{
            
            //            int minutes = timeout / 60;
            
//            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", timeout];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                
                NSLog(@"____%@",strTime);
                
//                [self.mainView changeGetCodeUIWithText:[NSString stringWithFormat:@"%@秒后重新获取",strTime] Enable:NO];
                
            });
            
            timeout--;
            
        }
        
    });
    
    dispatch_resume(_timer);

}


#pragma mark -处理网络请求结果
- (void)editResultBy:(id)responseObject{

    if ([responseObject isKindOfClass:[NSDictionary class]] && responseObject[@"code"]) {

        NSString *text = nil;
        
        switch ([responseObject[@"code"] integerValue]) {
            case 0:
                text = responseObject[@"data"][@"msg"];
                
                break;
                
            case 1:
                text = @"短信验证码已发送";
                
                break;
                
            case 101:
                text = @"该手机号格式不正确";
                
                break;
            case 103:
                text = @"手机号或验证码不正确";
                
                break;
            case 104:
                text = @"用户不存在,请先注册";
            
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
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];

}

- (void)toRegist{

    RegisterViewController *regist = [RegisterViewController new];
    [self.navigationController pushViewController:regist animated:YES];
    
}

- (void)loginSuccess:(id)responseObject{
    
    if ([[responseObject[@"nUserType"] stringValue] isEqualToString:@"0"]) {
        
        [UserTools setUserEmployees:[responseObject[@"lId"] stringValue]];

        [UserTools setUserEmployeeName:responseObject[@"strUsername"]];
        
    }else{
    
        [UserTools setUserId:[responseObject[@"lId"] stringValue]];
    }
    
    [UserTools bindAccount];

    [UserTools setInvite:responseObject[@"strInvitecode"]];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];

}


@end
