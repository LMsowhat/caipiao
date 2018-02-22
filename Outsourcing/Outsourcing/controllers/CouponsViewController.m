//
//  CouponsViewController.m
//  Outsourcing
//
//  Created by 李文华 on 2017/8/10.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "CouponsViewController.h"
#import "CouponsTableViewCell.h"
#import "Masonry.h"
#import "EliveApplication.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "MBProgressHUDManager.h"
#import "ServerViewController.h"

@interface CouponsViewController ()<UITableViewDelegate ,UITableViewDataSource>

@property (nonatomic ,strong)UITableView *mainTableView;

@property (nonatomic ,strong)NSMutableArray *dataSource;

@property (nonatomic ,strong)NoResultView *noDataView;


@end

@implementation CouponsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGBA(0xF7F7F7, 1.0);
    
    self.noDataView = [[NoResultView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight - kTopBarHeight)];
    self.noDataView.hidden = YES;
    self.noDataView.placeHolder.text = @"暂无可用优惠券";

    [self.view addSubview:self.mainTableView];
    [self.view addSubview:self.noDataView];
    
    [self sendRequestHttp];

    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.navigationItem.title = @"优惠券";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 22, 17);
    [btn setImage:[UIImage imageNamed:@"naviBack"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(foreAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0, 0, 25*kScale, 8*kScale);
    btn2.titleLabel.font = kFont(5.5);
    [btn2 setTitle:@"使用须知" forState:UIControlStateNormal];
    [btn2 setTitleColor:UIColorFromRGBA(0xFA6650, 1.0) forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(useRules) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn2];
    [self.navigationItem setRightBarButtonItem:rightItem];
    
    
}

#pragma mark Setter && Getter

-(UITableView *)mainTableView{

    if (!_mainTableView) {
        
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopBarHeight +10, kWidth, kHeight - kTopBarHeight - 10) style:UITableViewStylePlain];
        
        _mainTableView.delegate = self;
        
        _mainTableView.dataSource = self;
        
        _mainTableView.backgroundColor = kWhiteColor;
        
        _mainTableView.showsVerticalScrollIndicator = NO;
        
        _mainTableView.showsHorizontalScrollIndicator = NO;
        
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _mainTableView.tableFooterView = [self createBottomView];
        
        _mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            self.currentPage = 1;
            if (self.dataSource) {
                
                [self.dataSource removeAllObjects];
            }
            [self sendRequestHttp];
        }];
        
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            self.currentPage += 1;
            [self sendRequestHttp];
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

#pragma mark Private Method

- (UIView *)createBottomView {

    UIView *bottom = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 40*kScale)];

    UILabel *label = [UILabel new];
    label.font = kFont(5.5);
    label.textColor = UIColorFromRGBA(0x8F9095, 1.0);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"最终解释权归公司所有";
    
    [bottom addSubview:label];
    
    [label makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(bottom);
        
        make.bottom.equalTo(bottom).offset(-15*kScale);
    }];
    
    return bottom;
}


- (void)useRules{

    ServerViewController *server = [ServerViewController new];
    server.navigationItem.title = @"优惠券说明";
    
    [self.navigationController pushViewController:server animated:YES];
}

- (void)foreAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark NetWorks

- (void)sendRequestHttp{
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[kCurrentController] = self;
    parameters[@"lUserId"] = [UserTools getUserId];
    parameters[@"nMaxNum"] = @"10";
    parameters[@"nPage"] = [NSString stringWithFormat:@"%ld",self.currentPage ? self.currentPage : 1];
    if (self.nFullPrice) {
        
        parameters[@"nFullPrice"] = self.nFullPrice;
    }
    
    [OutsourceNetWork onHttpCode:kUserGetCouponsNetWork WithParameters:parameters];
    
}


- (void)getMyCouponsData:(id)responseObj{
    
    if ([responseObj[@"resCode"] isEqualToString:@"0"]) {
        
        [self.mainTableView.mj_header endRefreshing];
        [self.mainTableView.mj_footer endRefreshing];
        
        NSInteger count = 0;

        if (self.isSelectedCoupons) {
            
            for (NSDictionary *temp in responseObj[@"result"][@"dataList"]) {
                
                if ([[temp[@"nDataFlag"] stringValue] isEqualToString:@"1"]) {
                    
                    count ++;
                    [self.dataSource addObject:temp];
                }
            }
            if (count < 10) {
                
                [self.mainTableView.mj_footer endRefreshingWithNoMoreData];
            }
            
        }else{
            
            if ([responseObj[@"result"][@"dataList"] count] < 10) {
                
                [self.mainTableView.mj_footer endRefreshingWithNoMoreData];
            }
            if (!self.currentPage || self.currentPage == 1) {
                
                self.dataSource = [NSMutableArray arrayWithArray:responseObj[@"result"][@"dataList"]];
            }else{
            
                for (NSDictionary *tem in responseObj[@"result"][@"dataList"]) {
                    
                    [self.dataSource addObject:tem];
                }
            }
        }
        
        self.noDataView.hidden = YES;

        [self.mainTableView reloadData];
        NSLog(@"%@",responseObj);
    }else{
    
        self.noDataView.hidden = NO;
        
//        [MBProgressHUDManager showTextHUDAddedTo:self.view WithText:responseObj[@"result"] afterDelay:1.0f];
    }
    
}


#pragma mark TableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataSource.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"CouponTableViewCell";
    CouponsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil)
    {
        cell = [[CouponsTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID] ;
        
    }
    
    CouponsModel *model = [CouponsModel mj_objectWithKeyValues:self.dataSource[indexPath.row]];
    
    [cell fitDataWithModel:model];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.isSelectedCoupons) {
        
        WeakSelf(weakSelf);
        self.passCoupons(weakSelf.dataSource[indexPath.row]);
        
        [self foreAction];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 52*kScale;
}

@end
