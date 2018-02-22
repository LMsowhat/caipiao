//
//  FeedbackViewController.m
//  Outsourcing
//
//  Created by 李文华 on 2017/9/16.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "FeedbackViewController.h"
#import "MBProgressHUDManager.h"
#import "EliveApplication.h"



@interface FeedbackViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *myTextView;

@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@property (nonatomic ,strong)NSString *inputString;


@end

@implementation FeedbackViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.navigationItem.title = @"意见反馈";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 22, 17);
    [btn setImage:[UIImage imageNamed:@"naviBack"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(foreAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myTextView.delegate = self;
    
    [self.submitButton addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view from its nib.
}


- (void)submitClick:(UIButton *)sender{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[kCurrentController] = self;
    parameters[@"lUserId"] = [UserTools getUserId];
    parameters[@"strContent"] = self.inputString;
    
    [OutsourceNetWork onHttpCode:kUserFeedbackNetWork WithParameters:parameters];

}

- (void)resultOfFeedback:(id)responstObject{

    if ([responstObject[@"resCode"] isEqualToString:@"0"]) {
        
        [MBProgressHUDManager showTextHUDAddedTo:self.view WithText:@"已收到您的反馈" afterDelay:1.0f];
        
        self.myTextView.text = @"";
        
    }else{
    
        [MBProgressHUDManager showTextHUDAddedTo:self.view WithText:responstObject[@"result"] afterDelay:1.0f];
    }
    
}



- (void)foreAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark -UITextViewDelegate

/**
 开始编辑
 @param textView textView
 */
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"您的意见是我们前进的最大动力，谢谢！"]) {
        
        textView.text = @"";
        
    }
}

/**
 结束编辑
 
 @param textView textView
 */
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length <1) {
        textView.text = @"您的意见是我们前进的最大动力，谢谢！";
    }
    
}

/**
 内容发生改变编辑 自定义文本框placeholder
 有时候我们要控件自适应输入的文本的内容的高度，只要在textViewDidChange的代理方法中加入调整控件大小的代理即可
 @param textView textView
 */
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.markedTextRange == nil) {

        self.inputString = textView.text;
    }
    

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //当用户按下ruturn，把焦点从textField移开那么键盘就会消失了
    [textField resignFirstResponder];
    
    return YES;
}



@end
