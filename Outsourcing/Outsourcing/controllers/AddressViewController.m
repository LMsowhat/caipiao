//
//  AddressViewController.m
//  Outsourcing
//
//  Created by 李文华 on 2017/8/16.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "AddressViewController.h"
#import "MBProgressHUDManager.h"
#import "EliveApplication.h"
#import "MJExtension.h"
#import "MJRefresh.h"

#import "AddressTableViewCell.h"
#import "NewAddressViewController.h"
#import "AddressModel.h"


@interface AddressViewController ()<UITableViewDelegate ,UITableViewDataSource>

@property (nonatomic ,strong)UITableView *mainTableView;

@property (nonatomic ,strong)NSMutableArray *dataSource;

@property (nonatomic ,strong)UIButton   *seletedButton;

@property (nonatomic ,strong)NoResultView   *noDataView;


@end

@implementation AddressViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.navigationItem.title = @"我的地址";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 22, 17);
    [btn setImage:[UIImage imageNamed:@"naviBack"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(foreAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    [self sendHttpRequest];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGBA(0xF7F7F7, 1.0);
    
    [self loadConfigUI];
    // Do any additional setup after loading the view.
}

- (void)loadConfigUI{

    self.noDataView = [[NoResultView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    self.noDataView.hidden = YES;
    self.noDataView.placeHolder.text = @"暂无收货地址";
    
    [self.view addSubview:self.mainTableView];
    [self.view addSubview:self.noDataView];
    
    UIButton *addNewAddress = [UIButton buttonWithType:UIButtonTypeCustom];
    addNewAddress.frame = CGRectMake(0, kHeight - 24.5 *kScale, kWidth, 24.5 *kScale);
    [addNewAddress setTitle:@"新增收货地址" forState:UIControlStateNormal];
    [addNewAddress.titleLabel setFont:kFont(7)];
    [addNewAddress.titleLabel setTextColor:UIColorFromRGBA(0xFFFFFF, 1.0)];
    addNewAddress.backgroundColor = UIColorFromRGBA(0xFA6650, 1.0);
    [addNewAddress addTarget:self action:@selector(addNewAddresClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:addNewAddress];
    
}


#pragma mark Setter && Getter

-(UITableView *)mainTableView{

    if (!_mainTableView) {
        
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopBarHeight, kWidth, kHeight - kTopBarHeight -25*kScale) style:UITableViewStyleGrouped];
     
        _mainTableView.backgroundColor = UIColorFromRGBA(0xF7F7F7, 1.0);
        
        _mainTableView.delegate = self;
        
        _mainTableView.dataSource = self;
        
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            self.currentPage = 1;
            if (self.dataSource) {
                
                [self.dataSource removeAllObjects];
            }
            [self sendHttpRequest];
        }];
        
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            self.currentPage += 1;
            [self sendHttpRequest];
        }];
        [footer setTitle:@"已经全部加载完毕" forState:MJRefreshStateNoMoreData];
        
        _mainTableView.mj_footer = footer;
    }
    return _mainTableView;
}

-(NSMutableArray *)dataSource{

    if (!_dataSource) {
        
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

#pragma mark Target

- (void)addNewAddresClick{

    NewAddressViewController *newAddress = [NewAddressViewController new];
    newAddress.navigationItem.title = @"新增地址";
    
    [self.navigationController pushViewController:newAddress animated:YES];

}

- (void)seleteBtnClick:(UIButton *)sender{

    self.seletedButton.selected = NO;
    
    sender.selected = YES;

    self.seletedButton = sender;
    
    [self setupDefaultAddress:sender.tag];
}

- (void)deleteBtnClick:(UIButton *)sender{

    WeakSelf(weakSelf);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确认删除" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [weakSelf deleteTheAddress:sender.tag];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        return ;
    }]];
    
    [weakSelf presentViewController:alertController animated:YES completion:nil];
}

- (void)editBtnClick:(UIButton *)sender{
    
    NewAddressViewController *newAddress = [NewAddressViewController new];
    newAddress.navigationItem.title = @"编辑地址";
    newAddress.addressDict = self.dataSource[sender.tag];
    
    [self.navigationController pushViewController:newAddress animated:YES];

}


- (void)foreAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark NetWorks

- (void)sendHttpRequest{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[kCurrentController] = self;
    parameters[@"lUserId"] = [UserTools getUserId];
    parameters[@"nMaxNum"] = @"10";
    parameters[@"nPage"] = [NSString stringWithFormat:@"%ld",self.currentPage ? self.currentPage : 1];
    
    [OutsourceNetWork onHttpCode:kUserAddressNetWork WithParameters:parameters];
}

- (void)setupDefaultAddress:(NSInteger)index{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[kCurrentController] = self;
    parameters[@"lId"] = self.dataSource[index][@"lId"];
    
    [OutsourceNetWork onHttpCode:kUserSetDefaultAddressNetWork WithParameters:parameters];
}

- (void)deleteTheAddress:(NSInteger)index{
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[kCurrentController] = self;
    parameters[@"lId"] = self.dataSource[index][@"lId"];
    
    [OutsourceNetWork onHttpCode:kUserDeleteTheAddressNetWork WithParameters:parameters];
}

- (void)getMyAddressList:(id)responseObj{

    [self.mainTableView.mj_header endRefreshing];
    [self.mainTableView.mj_footer endRefreshing];
    
    if ([responseObj[@"resCode"] isEqualToString:@"0"]) {
        
        self.noDataView.hidden = YES;
        if ([responseObj[@"result"][@"dataList"] count] < 10) {
            
            [self.mainTableView.mj_footer endRefreshingWithNoMoreData];
        }
        if (!self.currentPage || self.currentPage == 1) {
            
            self.dataSource = [NSMutableArray arrayWithArray:responseObj[@"result"][@"dataList"]];
        }else{
        
            for (NSDictionary *temp in self.dataSource) {
                
                [self.dataSource addObject:temp];
            }
        }
        
        for (NSDictionary *temp in self.dataSource) {
            
            if ([temp[@"nIsdefault"] boolValue]) {
                
                [UserTools setUserAddress:temp];
            }
        }
        
        [self.mainTableView reloadData];
    }else{
    
        self.noDataView.hidden = NO;
//        [MBProgressHUDManager showTextHUDAddedTo:self.view WithText:responseObj[@"result"] afterDelay:1.0f];
    }
    
    NSLog(@"%@",responseObj);

}

- (void)resultOfSetDefault:(id)responseObj{

    if ([responseObj[@"resCode"] isEqualToString:@"0"]) {
        
        self.currentPage = 1;
        [self sendHttpRequest];
        [MBProgressHUDManager showTextHUDAddedTo:self.view WithText:@"设置默认地址成功" afterDelay:1.0f];
    }
}

- (void)resultOfDeleteAddress:(id)responseObj{

    if ([responseObj[@"resCode"] isEqualToString:@"0"]) {
        
        self.currentPage = 1;
        [self sendHttpRequest];

        [MBProgressHUDManager showTextHUDAddedTo:self.view WithText:@"删除成功" afterDelay:1.0f];
    }else{
    
        [MBProgressHUDManager showTextHUDAddedTo:self.view WithText:responseObj[@"result"] afterDelay:1.0f];
    }
}


#pragma mark TableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 5 *kScale;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"UITableViewCell";
    AddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.seleteBtn.selected = NO;
    
    if (cell == nil)
    {
        cell = [[AddressTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID] ;
    }

    AddressModel *model = [AddressModel mj_objectWithKeyValues:self.dataSource[indexPath.section]];
    
    [cell fitDataWithModel:model];
    
    cell.seleteBtn.tag = indexPath.section;
    cell.editBtn.tag = indexPath.section;
    cell.deleteBtn.tag = indexPath.section;
    [cell.seleteBtn addTarget:self action:@selector(seleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.editBtn addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([model.nIsdefault boolValue]) {
        
        self.seletedButton = cell.seleteBtn;
        self.seletedButton.selected = YES;
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.isSelectedAddress) {
        
        NSDictionary *dict = self.dataSource[indexPath.section];
        self.passAddress(dict);
        [self foreAction];
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 75.5 *kScale;
}

@end
