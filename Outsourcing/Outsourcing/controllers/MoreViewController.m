//
//  MoreViewController.m
//  Outsourcing
//
//  Created by 李文华 on 2017/8/17.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "MoreViewController.h"
#import "Masonry.h"

#import "FeedbackViewController.h"
#import "ServerViewController.h"
#import "AboutUsViewController.h"
#import "RetrieveViewController.h"


@interface MoreViewController ()<UITableViewDelegate ,UITableViewDataSource>

@property (nonatomic ,strong)UITableView *mainTableView;

@property (nonatomic ,strong)NSArray *dataSource;

@property (nonatomic ,strong)NSArray *subViewControllers;

@property (nonatomic ,strong)UIButton *logout;

@end

@implementation MoreViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.navigationItem.title = @"更多";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 22, 17);
    [btn setImage:[UIImage imageNamed:@"naviBack"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(foreAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    if (![UserTools getUserId]) {
        
        self.logout.hidden = YES;
    }else{
        
        self.logout.hidden = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.mainTableView];
    
    [self.view addSubview:self.logout];
    // Do any additional setup after loading the view.
}

#pragma  mark Setter && Getter

-(UITableView *)mainTableView{
    
    if (!_mainTableView) {
        
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopBarHeight, kWidth, kHeight - kTopBarHeight -24.5 *kScale) style:UITableViewStylePlain];
        
        _mainTableView.backgroundColor = UIColorFromRGBA(0xF7F7F7, 1.0);
        
        _mainTableView.delegate = self;
        
        _mainTableView.dataSource = self;
        
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        _mainTableView.tableFooterView = [UIView new];
    }
    return _mainTableView;
}

-(NSArray *)dataSource{

    if (!_dataSource) {
        
        _dataSource = @[@"意见反馈",@"服务条款",@"关于我们",@"修改密码"];
        
    }
    return _dataSource;
}

-(NSArray *)subViewControllers{

    if (!_subViewControllers) {
        
        FeedbackViewController *feedback = [FeedbackViewController new];
        ServerViewController *server = [ServerViewController new];
        ServerViewController *about = [ServerViewController new];
        RetrieveViewController *retrieve = [RetrieveViewController new];
        
        _subViewControllers = [NSArray arrayWithObjects:feedback,server,about,retrieve, nil];
    }

    return _subViewControllers;
}

-(UIButton *)logout{

    if (!_logout) {
        
        _logout = [UIButton buttonWithType:UIButtonTypeCustom];
        _logout.frame = CGRectMake(0, kHeight - 24.5 *kScale, kWidth, 24.5 *kScale);
        [_logout setTitle:@"退出登录" forState:UIControlStateNormal];
        [_logout.titleLabel setFont:kFont(7)];
        [_logout.titleLabel setTextColor:UIColorFromRGBA(0xFFFFFF, 1.0)];
        _logout.backgroundColor = UIColorFromRGBA(0xFA6650, 1.0);
        [_logout addTarget:self action:@selector(logoutClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logout;
}

#pragma  mark Tatget

- (void)logoutClick{
    
    [UserTools unbindAccount];
    [UserTools logOut];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NEEDLOGIN object:nil];

}

- (void)foreAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark TableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (![UserTools getUserId]) {
        
        return 3;
    }else{
        return 4;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"MoreTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID] ;
        
    }

    UILabel *leftLabel = [UILabel new];
    leftLabel.font = kFont(7);
    leftLabel.textColor = UIColorFromRGBA(0x333338, 1.0);
    leftLabel.text = self.dataSource[indexPath.row];
    
    UIImageView *rightImage = [UIImageView new];
    rightImage.image = [UIImage imageNamed:@"more"];
    
    [cell addSubview:leftLabel];
    [cell addSubview:rightImage];
    
    [leftLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(cell);
        
        make.left.equalTo(cell).offset(15 *kScale);
    }];
    
    [rightImage makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.equalTo(CGSizeMake(5 *kScale, 10 *kScale));
        
        make.centerY.equalTo(cell);
        
        make.right.equalTo(cell).offset(-10 *kScale);
    }];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self gotoViewControllers:indexPath.row];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 27 *kScale;
}

- (void)gotoViewControllers:(NSInteger)index{

    UIViewController *controller = self.subViewControllers[index];
    controller.navigationItem.title = self.dataSource[index];
    
    [self.navigationController pushViewController:controller animated:YES];

}




@end
