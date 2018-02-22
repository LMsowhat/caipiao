//
//  ActivityViewController.m
//  Outsourcing
//
//  Created by 李文华 on 2017/10/6.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "ActivityViewController.h"
#import "Masonry.h"
#import "WXApi.h"
#import "MBProgressHUDManager.h"

#import "WechatShareView.h"


@interface ActivityViewController ()

@property (nonatomic ,strong)UIWebView *webView;

@property (nonatomic ,strong)WechatShareView *shareView;

@property (nonatomic ,strong)SendMessageToWXReq *req;


@end

@implementation ActivityViewController
-(void)viewWillAsafsafasfppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 22, 17);
    [btn setImage:[UIImage imageNamed:@"naviBack"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(foreAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0, 0, 25*kScale, 8*kScale);
    btn2.titleLabel.font = kFont(7);
    [btn2 setTitle:@"分享" forState:UIControlStateNormal];
    [btn2 setTitleColor:UIColorFromRGBA(0xFA6650, 1.0) forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(useRules) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn2];
    [self.navigationItem setRightBarButtonItem:rightItem];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wechatShareCallback:) name:wechatShare object:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
        
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 22, 17);
    [btn setImage:[UIImage imageNamed:@"naviBack"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(foreAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0, 0, 25*kScale, 8*kScale);
    btn2.titleLabel.font = kFont(7);
    [btn2 setTitle:@"分享" forState:UIControlStateNormal];
    [btn2 setTitleColor:UIColorFromRGBA(0xFA6650, 1.0) forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(useRules) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn2];
    [self.navigationItem setRightBarButtonItem:rightItem];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wechatShareCallback:) name:wechatShare object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, kTopBarHeight, kWidth, kHeight - kTopBarHeight)];
    self.webView.scalesPageToFit = YES;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.infoDict[@"strUrl"]]];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    [self.webView loadRequest:request];

    [self.view addSubview:self.webView];
    [self.view addSubview:self.shareView];
    // Do any additional setup after loading the view.
}
- (void)viewDisdktributiondLoad {
    [super viewDidLoad];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, kTopBarHeight, kWidth, kHeight - kTopBarHeight)];
    self.webView.scalesPageToFit = YES;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.infoDict[@"strUrl"]]];
    //    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    [self.webView loadRequest:request];
    
    [self.view addSubview:self.webView];
    [self.view addSubview:self.shareView];
    // Do any additional setup after loading the view.
}


-(WechatShareView *)shareView{

    if (!_shareView) {
        
        _shareView = [[NSBundle mainBundle] loadNibNamed:@"WechatShareView" owner:nil options:nil].lastObject;
        _shareView.frame = self.view.frame;
        _shareView.backgroundColor = UIColorFromRGBA(0xDDDDDD, 0.3f);
        _shareView.hidden = YES;
        
        [_shareView.friendsButton addTarget:self action:@selector(friendsButtonClick) forControlEvents:UIControlEventTouchUpInside];

        [_shareView.momentsButton addTarget:self action:@selector(momentsButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareView;
}

-(SendMessageToWXReq *)req{

    if (!_req) {
        
        _req = [[SendMessageToWXReq alloc] init];
        
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = [self.infoDict objectForKey:@"title"];
        message.description = [self.infoDict objectForKey:@"strRemarks"];
        NSData *data = [self imageWithImage:kGetImageUrl(URLHOST, @"1", self.infoDict[@"lId"]) scaledToSize:CGSizeMake(100, 100)];
        [message setThumbImage:[UIImage imageWithData:data]];
        WXWebpageObject *webpageObject = [WXWebpageObject object];
        webpageObject.webpageUrl = self.infoDict[@"strUrl"];
        message.mediaObject = webpageObject;
        
        _req.bText = NO;
        _req.message = message;
        
    }
    return _req;
}

// 压缩图片尺寸
- (NSData *)imageWithImage:(NSURL*)imageUrl scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext(newSize);
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return UIImageJPEGRepresentation(newImage, 0.5);
}

- (void)useRules{
    
    self.shareView.hidden = NO;
    
}

- (void)friendsButtonClick{
    
    self.req.scene = WXSceneSession;
    
    [WXApi sendReq:self.req];
}

- (void)momentsButtonClick{

    self.req.scene = WXSceneTimeline;

    [WXApi sendReq:self.req];
}

- (void)wechatShareCallback:(NSNotification *)noti{

    NSDictionary *resultDic = noti.userInfo;
    
    if ([resultDic[@"resCode"] isEqualToString:@"0"]) {
        
        self.shareView.hidden = YES;
        [MBProgressHUDManager showTextHUDAddedTo:self.view WithText:@"分享成功" afterDelay:1.0f];
        NSLog(@"展示成功页面");
    }
}

- (void)foreAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
