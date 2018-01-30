//
//  HomeViewController.m
//  CaipiaoApp
//
//  Created by liwenhua on 2018/1/30.
//  Copyright © 2018年 李文华. All rights reserved.
//

#import "HomeViewController.h"
#import "RandomView.h"

#define kWidth [[UIScreen mainScreen] bounds].size.width
#define kHeight [[UIScreen mainScreen] bounds].size.height
#define UIColorFromRGBA(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 blue:((float)(rgbValue & 0x0000FF))/255.0 alpha:alphaValue]

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label1;

@property (weak, nonatomic) IBOutlet UILabel *label2;

@property (weak, nonatomic) IBOutlet UILabel *label3;

@property (weak, nonatomic) IBOutlet UILabel *label4;

@property (weak, nonatomic) IBOutlet UILabel *label5;

@property (weak, nonatomic) IBOutlet UILabel *label6;

@property (weak, nonatomic) IBOutlet UILabel *label7;

@property (weak, nonatomic) IBOutlet UIButton *selectedButton;

@property (weak, nonatomic) IBOutlet UIButton *sureButton;

// strong
/** 注释 */
@property (strong, nonatomic) NSArray * labels;

@end

@implementation HomeViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"首页";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.labels = @[self.label1,self.label2,self.label3,self.label4,self.label5,self.label6,self.label7];
    [self.selectedButton addTarget:self action:@selector(selectedButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];

    
}

- (void)selectedButtonClick: (UIButton *)sender{
    
    for (int i = 0; i < 7; i++) {
        int tNum = 0;
        
        UILabel *label = self.labels[i];
        
        if (i != 6) {
            
            tNum = arc4random() % 32 + 1;
        }else{
            tNum = arc4random() % 15 + 1;
        }
        if (tNum > 0) {
            
            label.text = [NSString stringWithFormat:@"%.2d",tNum];
        }else{
            label.text = @"12";
        }
    }
    
    self.sureButton.backgroundColor = UIColorFromRGBA(0xD80C18, 1.0);
    
}

- (void)sureButtonClick{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定选中这组好码吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"重新选择" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.tabBarController.selectedIndex = 2;
    }];
    
    [alertController addAction:cancel];
    [alertController addAction:sure];
    [self presentViewController:alertController animated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
