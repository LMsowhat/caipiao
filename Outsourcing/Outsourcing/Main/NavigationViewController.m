//
//  NavigationViewController.m
//  Outsourcing
//
//  Created by 李文华 on 2017/6/14.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "NavigationViewController.h"
#import "HomeViewController.h"
#import "WaterTicketViewController.h"
#import "MyViewController.h"
#import "ShoppingCartController.h"



@interface NavigationViewController ()<UINavigationControllerDelegate>

@end

@implementation NavigationViewController

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];

    self.navigationBar.barTintColor = UIColorFromRGBA(0xFFFFFF, 1.0);
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:UIColorFromRGBA(0x1C1F2D, 1.0)};
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;

    // Do any additional setup after loading the view.
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    BOOL isFirstController = [viewController isKindOfClass:[HomeViewController class]] || [viewController isKindOfClass:[ShoppingCartController class]] || [viewController isKindOfClass:[WaterTicketViewController class]] || [viewController isKindOfClass:[MyViewController class]];
   
    if (!isFirstController) {
        
        self.tabBarController.tabBar.hidden = YES;
    }else{
        
        self.tabBarController.tabBar.hidden = NO;
    }
    
    
}

@end
