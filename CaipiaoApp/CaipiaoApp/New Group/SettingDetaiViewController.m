//
//  SettingDetaiViewController.m
//  CaipiaoApp
//
//  Created by liwenhua on 2018/1/31.
//  Copyright © 2018年 李文华. All rights reserved.
//

#import "SettingDetaiViewController.h"

@interface SettingDetaiViewController ()

@property (weak, nonatomic) IBOutlet UIView *cleanView;



@end

@implementation SettingDetaiViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"设置";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cleanClick:)];
    
    [self.cleanView addGestureRecognizer:tap];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)cleanClick:(UIGestureRecognizer *)tap{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"清除缓存成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
