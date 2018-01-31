//
//  MyLoveViewController.m
//  CaipiaoApp
//
//  Created by liwenhua on 2018/1/31.
//  Copyright © 2018年 李文华. All rights reserved.
//

#import "MyLoveViewController.h"

@interface MyLoveViewController ()

@property (weak, nonatomic) IBOutlet UILabel *showLabel;



@end

@implementation MyLoveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.showLabel.text = self.showTitle;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
