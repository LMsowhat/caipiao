//
//  ViewController.m
//  CaipiaoApp
//
//  Created by 李文华 on 2018/1/15.
//  Copyright © 2018年 李文华. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *mainWebView;
    
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainWebView.scalesPageToFit = YES;
    [self httpRequest];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)httpRequest{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager GET:@"http://api.ceshiptyl333.com/configuration/?id=nsU9rVtBZRQaCWCG3655jCls2sNBoby8" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *url = responseObject[@"Url"];
        if (responseObject && responseObject[@"IsOpen"] && url.length > 1) {
            
            [self webViewLoad:responseObject[@"Url"]];
        }else{
            [self webViewLoad:nil];
        }
        NSLog(@"%@",responseObject);
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
}
    
- (void)webViewLoad:(NSString *)h5{
    
    if (h5) {
        [self.mainWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:h5]]];

    }else{
        [self.mainWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://map.sogou.com/m/webapp/m.html"]]];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
