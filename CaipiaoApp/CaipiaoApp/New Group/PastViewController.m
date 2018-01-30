//
//  PastViewController.m
//  CaipiaoApp
//
//  Created by liwenhua on 2018/1/30.
//  Copyright © 2018年 李文华. All rights reserved.
//

#import "PastViewController.h"

@interface PastViewController ()

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

// strong
/** 注释 */
@property (strong, nonatomic) NSArray * dataSource;

@end

@implementation PastViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"往期中奖号码";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (NSArray *)dataSource{
    
    if (!_dataSource) {
        _dataSource = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pastnumber" ofType:@"plist"]];
    }
    NSLog(@"%@",_dataSource);
    return _dataSource;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
