//
//  AgreementTextViewController.m
//  Eliveapp
//
//  Created by 李文华 on 2017/4/25.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "AgreementTextViewController.h"
#import "ProtocolViews.h"


@interface AgreementTextViewController ()

@property (nonatomic ,strong)UIScrollView *mainScrollView;

@property (nonatomic ,strong)UILabel *textLabel;

@end

@implementation AgreementTextViewController

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 17, 17);
    [btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(shutDown) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    self.navigationItem.title = @"知金在线用户协议";

}

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kTopBarHeight, kWidth, kHeight - kTopBarHeight)];
    [self.view addSubview:self.mainScrollView];

    
    NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"zhijinprotocol" ofType:@"json"]];
    
    NSDictionary *protocol = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    
    NSArray *keys = protocol[@"keys"];
    
    CGFloat tHeight = 0.0;
    for (int i = 0; i < keys.count; i++) {
        
        UIView *textView = [ProtocolViews creatViewWithTitle:keys[i] Detail:[protocol objectForKey:keys[i]]];
        textView.frame = CGRectMake(0, tHeight, kWidth, textView.bounds.size.height);
        
        [self.mainScrollView addSubview:textView];
        
        tHeight += textView.bounds.size.height;
    }
    
    self.mainScrollView.contentSize = CGSizeMake(kWidth, tHeight);    
    
    
    // Do any additional setup after loading the view.
}

- (void)shutDown{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
