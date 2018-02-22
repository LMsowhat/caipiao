//
//  RetrieveViewController.m
//  Outsourcing
//
//  Created by 李文华 on 2017/9/16.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "RetrieveViewController.h"
#import "MBProgressHUDManager.h"

#import "EliveApplication.h"


@interface RetrieveViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (weak, nonatomic) IBOutlet UITextField *oldTextField;

@property (weak, nonatomic) IBOutlet UITextField *newsTextField;

@property (weak, nonatomic) IBOutlet UIButton *submitButton;


@property (nonatomic ,strong)NSMutableDictionary *submitData;


@end

@implementation RetrieveViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.navigationItem.title = @"修改密码";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 22, 17);
    [btn setImage:[UIImage imageNamed:@"naviBack"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(foreAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    if (self.phoneTextField) {
        
        self.phoneTextField.text = @"";
    }
    if (self.oldTextField) {
        
        self.oldTextField.text = @"";
    }
    if (self.newsTextField) {
        
        self.newsTextField.text = @"";
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGBA(0xF7F7F7, 1.0);
    
    [self.submitButton addTarget:self action:@selector(submitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.phoneTextField.delegate = self;
    [self.phoneTextField addTarget:self action:@selector(phoneTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.oldTextField.delegate = self;
    [self.oldTextField addTarget:self action:@selector(phoneTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.newsTextField.delegate = self;
    [self.newsTextField addTarget:self action:@selector(phoneTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    // Do any additional setup after loading the view.
}


- (NSMutableDictionary *)submitData{

    if (!_submitData) {
        
        _submitData = [NSMutableDictionary new];
        _submitData[@"phone"] = self.phoneTextField.text;
        _submitData[@"oldPsd"] = self.oldTextField.text;
        _submitData[@"newPsd"] = self.newsTextField.text;
        
    }
    return _submitData;
}



- (void)sendHttpRequest{
    
}

- (BOOL)checkInput{

    if (!self.submitData[@"phone"] || [self.submitData[@"phone"] length] != 11) {
        
        [MBProgressHUDManager showTextHUDAddedTo:self.view WithText:@"请输入11位手机号" afterDelay:1.0f];
        return NO;
    }

    if (!self.submitData[@"oldPsd"] || [self.submitData[@"oldPsd"] length] < 6) {
        
        [MBProgressHUDManager showTextHUDAddedTo:self.view WithText:@"请输入6位以上密码" afterDelay:1.0f];
        return NO;
    }
    
    if (!self.submitData[@"newPsd"] || [self.submitData[@"newPsd"] length] < 6) {
        
        [MBProgressHUDManager showTextHUDAddedTo:self.view WithText:@"请输入6位以上密码" afterDelay:1.0f];
        return NO;
    }

    return YES;
}

#pragma mark ClickAction


- (void)submitButtonClick:(UIButton *)sender{

    BOOL isOk = [self checkInput];
    
    if (isOk) {
        
        NSMutableDictionary *parameters = [NSMutableDictionary new];
        parameters[kCurrentController] = self;
        parameters[@"lUserId"] = [UserTools getUserId];
        parameters[@"strPasswordOld"] = self.submitData[@"oldPsd"];
        parameters[@"strMobile"] = self.submitData[@"phone"];
        parameters[@"strPassword"] = self.submitData[@"newPsd"];
        
        [OutsourceNetWork onHttpCode:kUserUpdatePassWorkNetWork WithParameters:parameters];
    }

}

- (void)resultOfUpdatePasswork:(id)responseObject{

    [MBProgressHUDManager showTextHUDAddedTo:self.view WithText:responseObject[@"result"] afterDelay:1.0f];
    
    if ([responseObject[@"resCode"] isEqualToString:@"0"]) {
        
        [self foreAction];
    }
}




- (void)foreAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark textFieldAction

- (void)phoneTextFieldDidChange:(UITextField *)textField{

    if (textField == self.phoneTextField) {
        
        self.submitData[@"phone"] = textField.text;
    }
    if (textField == self.oldTextField) {
        
        self.submitData[@"oldPsd"] = textField.text;
    }
    if (textField == self.newsTextField) {
        
        self.submitData[@"newPsd"] = textField.text;
    }

}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //当用户按下ruturn，把焦点从textField移开那么键盘就会消失了
    [textField resignFirstResponder];
    
    return YES;
}



@end
