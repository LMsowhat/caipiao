//
//  SettingViewController.m
//  CaipiaoApp
//
//  Created by liwenhua on 2018/1/30.
//  Copyright © 2018年 李文华. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTableViewCell.h"
#import "SettingDetaiViewController.h"
#import "MyLoveViewController.h"

@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

// strong
/** 注释 */
@property (strong, nonatomic) NSArray * dataSource;

@end

@implementation SettingViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"我的";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    
    self.mainTableView.tableFooterView = [UIView new];
    // Do any additional setup after loading the view from its nib.
}

-(NSArray *)dataSource{
    
    if (!_dataSource) {
        _dataSource = @[@{@"image":@"setting_mySetting",@"title":@"设置"},@{@"image":@"setting_myCollection",@"title":@"我喜欢的号码"},@{@"image":@"setting_myOrder",@"title":@"选中记录"},@{@"image":@"setting_myCourse",@"title":@"选中差距"},@{@"image":@"setting_myMessage",@"title":@"中奖信息"},@{@"image":@"setting_wallet",@"title":@"我的中奖总金额"}];
    }
    return _dataSource;
}

#pragma mark TableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}


#pragma mark TableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier =@"TableViewCellIdentifier";
    
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"SettingTableViewCell" owner:nil options:nil].lastObject;
    }
    
    cell.imageView.image = [UIImage imageNamed:self.dataSource[indexPath.row][@"image"]];
    cell.titleLabel.text = self.dataSource[indexPath.row][@"title"];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        
        SettingDetaiViewController *detail = [SettingDetaiViewController new];
        
        detail.title = @"我的设置";
        
        [self.navigationController pushViewController:detail animated:YES];
        
    }else if (indexPath.row == 1){
        
        MyLoveViewController *love = [MyLoveViewController new];
        
        love.title = @"我喜欢的号码";
        
        love.showTitle = @"暂无我喜欢的号码";
        
        [self.navigationController pushViewController:love animated:YES];

    }else if (indexPath.row == 2){
        
        MyLoveViewController *love = [MyLoveViewController new];

        love.title = @"选中记录";
        
        love.showTitle = @"暂无选中记录";

        [self.navigationController pushViewController:love animated:YES];

        
    }else if (indexPath.row == 3){
        
        MyLoveViewController *love = [MyLoveViewController new];

        love.title = @"选中差距";
        
        love.showTitle = @"暂无选中差距";

        [self.navigationController pushViewController:love animated:YES];

        
    }else if (indexPath.row == 4){
        
        MyLoveViewController *love = [MyLoveViewController new];

        love.title = @"中奖信息";
        
        love.showTitle = @"暂无中奖信息";

        [self.navigationController pushViewController:love animated:YES];

        
    }else if (indexPath.row == 5){
        
        MyLoveViewController *love = [MyLoveViewController new];

        love.title = @"我的中奖金额";
        
        love.showTitle = @"暂无中奖金额";

        [self.navigationController pushViewController:love animated:YES];

        
    }
    
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
