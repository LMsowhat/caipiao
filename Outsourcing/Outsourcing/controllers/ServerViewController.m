//
//  ServerViewController.m
//  Outsourcing
//
//  Created by 李文华 on 2017/9/16.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "ServerViewController.h"
#import "EliveApplication.h"
#import "MBProgressHUDManager.h"

@interface ServerViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;


@end

@implementation ServerViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
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

    self.webView.scalesPageToFit = YES;
    
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
//    [self.webView loadHTMLString:<#(nonnull NSString *)#> baseURL:<#(nullable NSURL *)#>];
    // Do any additional setup after loading the view.
}




- (void)sendHttpRequest{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[kCurrentController] = self;
    if ([self.navigationItem.title isEqualToString:@"服务条款"]) {
        
        parameters[@"nType"] = @"0";
    }
    if ([self.navigationItem.title isEqualToString:@"关于我们"]) {
        
        parameters[@"nType"] = @"1";
    }
    if ([self.navigationItem.title isEqualToString:@"优惠券说明"]) {
        
        parameters[@"nType"] = @"2";
    }
    if ([self.navigationItem.title isEqualToString:@"桶押金说明"]) {
        
        parameters[@"nType"] = @"4";
    }
    
    [OutsourceNetWork onHttpCode:kSettingGetMoreNetWork WithParameters:parameters];

}

- (void)getServerContent:(id)responseObject{

    if ([responseObject[@"resCode"] isEqualToString:@"0"]) {
        
        [self.webView loadHTMLString:responseObject[@"result"] baseURL:nil];
    }else{
    
        [MBProgressHUDManager showTextHUDAddedTo:self.view WithText:responseObject[@"result"] afterDelay:1.0f];
    }
    NSLog(@"%@",responseObject);
}

- (void)foreAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



@end
