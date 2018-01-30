//
//  MainTabBarViewController.m
//  CaipiaoApp
//
//  Created by liwenhua on 2018/1/30.
//  Copyright © 2018年 李文华. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "HomeViewController.h"
#import "PastViewController.h"
#import "SettingViewController.h"

#define UIColorFromRGBA(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 blue:((float)(rgbValue & 0x0000FF))/255.0 alpha:alphaValue]

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HomeViewController *home = [HomeViewController new];
    UINavigationController *navi1 = [[UINavigationController alloc] initWithRootViewController:home];
    navi1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"主页" image:[[UIImage imageNamed:@"tabbar_home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_home_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [navi1.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromRGBA(0xd80c18, 1.0),NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    PastViewController *past = [PastViewController new];
    UINavigationController *navi2 = [[UINavigationController alloc] initWithRootViewController:past];
    navi2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"往期" image:[[UIImage imageNamed:@"tabbar_courseList"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_courseList_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [navi2.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromRGBA(0xd80c18, 1.0),NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];

    SettingViewController *setting = [SettingViewController new];
    UINavigationController *navi3 = [[UINavigationController alloc] initWithRootViewController:setting];
    navi3.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[[UIImage imageNamed:@"tabbar_setting"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_setting_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [navi3.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromRGBA(0xd80c18, 1.0),NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];

    self.viewControllers = @[navi1,navi2,navi3];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
