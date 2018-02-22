//
//  MyViewController.m
//  Outsourcing
//
//  Created by 李文华 on 2017/6/14.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "MyViewController.h"
#import "UIButton+myButton.h"
#import "Masonry.h"
#import "EliveApplication.h"

#import "CouponsViewController.h"
#import "MyInvitationViewController.h"
#import "AddressViewController.h"
#import "MyBarrelViewController.h"
#import "MyTicketViewController.h"
#import "MoreViewController.h"
#import "OrdersViewController.h"
#import "EmployeeViewController.h"
#import "MyMessageViewController.h"
#import "GetCouponViewController.h"

@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UITableView *mainTableView;

@property (nonatomic ,strong)NSMutableArray *dataSource;

@property (nonatomic ,strong)UIImageView *userIcon;

@property (nonatomic ,strong)UILabel *userPhone;

@property (nonatomic ,strong)NSArray *childControllers;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    
    self.view.backgroundColor = UIColorFromRGBA(0xF7F7F7, 1.0);
    
    [self dealDataSource];
    
    [self.view addSubview:self.mainTableView];
    
    if ([UserTools getUserId]) {
        
        self.userPhone.text = @"登录";
    }
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden = NO;
   
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 20, 20);
    [rightBtn setImage:[UIImage imageNamed:@"icon_massage"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(messageClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [self.navigationItem setRightBarButtonItem:rightItem];
    
    self.navigationController.navigationBar.barTintColor = UIColorFromRGBA(0xFFFFFF, 1.0);
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:UIColorFromRGBA(0x1C1F2D, 1.0)};
    if ([UserTools getUserId]) {
        
        [self sendHttpRequest];
    }
}

#pragma mark NetWorks

- (void)sendHttpRequest{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[kCurrentController] = self;
    parameters[@"userId"] = [UserTools getUserId];
    
    [OutsourceNetWork onHttpCode:kUserGetInfoNetWork WithParameters:parameters];
}

- (void)getMyInfo:(id)responseObject{

    if ([responseObject[@"resCode"] isEqualToString:@"0"]) {
        
        self.userPhone.text = responseObject[@"result"][@"strMobile"];
    }
    [self dealDataSource];
    [self.mainTableView reloadData];
}


#pragma mark Setter && Getter

-(UITableView *)mainTableView{

    if (!_mainTableView) {
        
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopBarHeight, kWidth, kHeight - kTopBarHeight - kTabBarHeight) style:UITableViewStyleGrouped];
        
        _mainTableView.delegate = self;
        
        _mainTableView.dataSource = self;
        
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _mainTableView.showsVerticalScrollIndicator = NO;
        
        _mainTableView.showsHorizontalScrollIndicator = NO;
        
    }

    return _mainTableView;
}

-(UIImageView *)userIcon{

    if (!_userIcon) {
        
        _userIcon = [UIImageView new];
        
        _userIcon.image = [UIImage imageNamed:@"icon_avatar"];
    }
    return _userIcon;
}

-(UILabel *)userPhone{

    if (!_userPhone) {
        
        _userPhone = [UILabel new];
        
        _userPhone.font = kFont(7);
        
        _userPhone.text = @"登录";
    }

    return _userPhone;
}

#pragma mark Private Method

- (void)messageClick{

    if (![UserTools getUserId]) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NEEDLOGIN object:nil];
    }else{
    
        MyMessageViewController *myMessage = [MyMessageViewController new];
        
        [self.navigationController pushViewController:myMessage animated:YES];
    }
    
}

- (void)dealDataSource{

    //优惠券
    CouponsViewController *coupon = [CouponsViewController new];
    //优惠券
    EmployeeViewController *employee = [EmployeeViewController new];
    //订单
    OrdersViewController *order = [OrdersViewController new];
    //领券中心
    GetCouponViewController *getCoupon = [GetCouponViewController new];
    //我的邀请
    MyInvitationViewController *invitate = [MyInvitationViewController new];
    //我的地址
    AddressViewController *address = [AddressViewController new];
    //我的水桶
    MyBarrelViewController *barrel = [MyBarrelViewController new];
    //我的水票
    MyTicketViewController *ticket = [MyTicketViewController new];
    //更多
    MoreViewController *more = [MoreViewController new];
    
    if ([UserTools userEmployeesId]) {
        
        self.dataSource = [[NSMutableArray alloc] initWithObjects:@[@[@"icon_coupon",@"我的优惠券"],@[@"icon_myorder",@"我的配送单"],@[@"icon_myorder",@"我的订单"],@[@"icon_myorder",@"我领券中心"],@[@"icon_invite",@"我要邀请"],@[@"icon_address",@"我的地址"]],@[@[@"icon_bucket",@"我的水桶"],@[@"icon_ticket",@"我的水票"],@[@"icon_more",@"更多"]], nil];

        self.childControllers = @[@[coupon,employee,order,getCoupon,invitate,address],@[barrel,ticket,more]];
    }else{
        self.dataSource = [[NSMutableArray alloc] initWithObjects:@[@[@"icon_coupon",@"我的优惠券"],@[@"icon_myorder",@"我的订单"],@[@"icon_myorder",@"领券中心"],@[@"icon_invite",@"我要邀请"],@[@"icon_address",@"我的地址"]],@[@[@"icon_bucket",@"我的水桶"],@[@"icon_ticket",@"我的水票"],@[@"icon_more",@"更多"]], nil];
        
        self.childControllers = @[@[coupon,order,getCoupon,invitate,address],@[barrel,ticket,more]];
    }
}

- (UIView *)createUserView{

    UIView *userView = [UIView new];
    
    [userView addSubview:self.userIcon];
    [userView addSubview:self.userPhone];

    [self.userIcon makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.equalTo(CGSizeMake(25*kScale, 25*kScale));
        
        make.centerY.equalTo(userView);
        
        make.left.equalTo(userView).offset(10*kScale);
    }];
    
    [self.userPhone makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(userView);
        
        make.left.equalTo(self.userIcon.mas_right).offset(5*kScale);
        
    }];
    
    return userView;
}

- (UIView *)createTableViewCell:(NSString *)imageName Text:(NSString *)text{

    UIView *cell = [UIView new];

    UIImageView *leftImage = [UIImageView new];
    leftImage.image = [UIImage imageNamed:imageName];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.font = kFont(7);
    titleLabel.text = text;
    
    UIImageView *rightImage = [UIImageView new];
    rightImage.image = [UIImage imageNamed:@"more"];
    
    [cell addSubview:rightImage];
    [cell addSubview:leftImage];
    [cell addSubview:titleLabel];
    
    [leftImage makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(cell);
        
        make.size.equalTo(CGSizeMake(24, 24));
        
        make.left.equalTo(cell).offset(20 *kScale);
    }];
    
    [titleLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(cell);
        
        make.left.equalTo(leftImage.mas_right).offset(5*kScale);
        
    }];
    
    [rightImage makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(cell);
        
        make.size.equalTo(CGSizeMake(5 *kScale, 10 *kScale));
        
        make.right.equalTo(cell).offset(-10*kScale);
    }];
    
    return cell;
}


#pragma mark TableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.dataSource.count + 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 1;
    }
    return [self.dataSource[section -1] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 5*kScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID] ;
        
    }
    switch (indexPath.section) {
        case 0:
        {
            UIView *userView = [self createUserView];
            
            [cell addSubview:userView];
            
            [userView makeConstraints:^(MASConstraintMaker *make) {
                
                make.size.equalTo(cell);
            }];
        }
            break;
            
        default:
        {
            [self configCell:cell withIndexPath:indexPath];
        }
            break;
    }
    
    return cell;
}

- (void)configCell:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath{

    UIView *cellView = [self createTableViewCell:self.dataSource[indexPath.section -1][indexPath.row][0] Text:self.dataSource[indexPath.section -1][indexPath.row][1]];
    
    for (UIView *view in cell.subviews) {
        
        [view removeFromSuperview];
    }
    [cell addSubview:cellView];
    [cellView makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.equalTo(cell);
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BOOL isLogin = [[UserTools getUserId] boolValue];
    
    if (!isLogin) {
        
        if (indexPath.row == 2){
            
            UIViewController *detail = self.childControllers[indexPath.section - 1][indexPath.row];
            
            [self.navigationController pushViewController:detail animated:YES];
        }else{
            
            [[NSNotificationCenter defaultCenter] postNotificationName:NEEDLOGIN object:nil];
        }
    }
    if (isLogin) {
        
        if (indexPath.section != 0) {
            
            UIViewController *detail = self.childControllers[indexPath.section - 1][indexPath.row];
            
            [self.navigationController pushViewController:detail animated:YES];
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return 45 * kScale;
    }
    return 27 * kScale;
}



@end
