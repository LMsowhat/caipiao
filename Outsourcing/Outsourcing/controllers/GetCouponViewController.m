//
//  GetCouponViewController.m
//  Outsourcing
//
//  Created by 李文华 on 2017/12/19.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "GetCouponViewController.h"

@interface GetCouponViewController ()

@property (nonatomic ,strong)UIWebView *webView;

@end

@implementation GetCouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"领券中心";
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
//    self.webView.scalesPageToFit = YES;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://gk.fuzhents.com/page/coupon/center.jsp?luserId=%@",[UserTools getUserId]]]];
//    NSLog(@"%@",request.URL);
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
    // Do any additional setup after loading the view.
}

@end
