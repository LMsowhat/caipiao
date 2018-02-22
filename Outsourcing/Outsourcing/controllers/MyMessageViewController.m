//
//  MyMessageViewController.m
//  Outsourcing
//
//  Created by 李文华 on 2017/9/23.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "MyMessageViewController.h"
#import "Masonry.h"
#import "EliveApplication.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "MBProgressHUDManager.h"
#import "MessageCell.h"

@interface MyMessageViewController ()<UITableViewDelegate ,UITableViewDataSource>


@property (nonatomic ,strong)UITableView *mainTableView;

@property (nonatomic ,strong)NSMutableArray *dataSource;

@property (nonatomic ,strong)NoResultView *noDataView;


@end

@implementation MyMessageViewController
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"我的消息";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 22, 17);
    [btn setImage:[UIImage imageNamed:@"naviBack"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(foreAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [self.navigationItem setLeftBarButtonItem:leftItem];
 
    [self sendHttpRequest];
    [self registerMessageReceive];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.mainTableView];
    
    [self.view addSubview:self.noDataView];
    // Do any additional setup after loading the view.
}


#pragma mark Setter && Getter

-(UITableView *)mainTableView{
    
    if (!_mainTableView) {
        
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopBarHeight +10, kWidth, kHeight - kTopBarHeight - 10) style:UITableViewStylePlain];
        
        _mainTableView.delegate = self;
        
        _mainTableView.dataSource = self;
        
        _mainTableView.backgroundColor = kWhiteColor;
        
        _mainTableView.tableFooterView = [UIView new];
        
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

-(NoResultView *)noDataView{

    if (!_noDataView) {
        
        _noDataView = [[NoResultView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
        
        _noDataView.placeHolder.text = @"暂无消息";
    }
    return _noDataView;
}

#pragma mark NetWorks

- (void)sendHttpRequest{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[kCurrentController] = self;
    parameters[@"lUserId"] = [UserTools getUserId];
    parameters[@"nMaxNum"] = @"10";
    parameters[@"nPage"] = [NSString stringWithFormat:@"%ld",self.currentPage ? self.currentPage : 1];
    
    [OutsourceNetWork onHttpCode:kUserGetMessageNetWork WithParameters:parameters];
}


- (void)getMyMessageList:(id)responseObject{
    
    [self.mainTableView.mj_header endRefreshing];
    [self.mainTableView.mj_footer endRefreshing];
    
    if ([responseObject[@"resCode"] isEqualToString:@"0"]) {
        
        if ([[responseObject[@"result"] allKeys] containsObject:@"dataList"]) {
            
            if (!self.currentPage || self.currentPage == 1) {
                
                self.dataSource = [NSMutableArray arrayWithArray:responseObject[@"result"][@"dataList"]];
                
            }else{
            
                for (NSDictionary *tem in responseObject[@"result"][@"dataList"]) {
                    
                    [self.dataSource addObject:tem];
                }
            }
            
            if ([responseObject[@"result"][@"dataList"] count] < 10) {
                
                [self.mainTableView.mj_footer endRefreshingWithNoMoreData];
            }
            
            self.noDataView.hidden = YES;
            
            [self.mainTableView reloadData];
        }
    }else{
    
        self.noDataView.hidden = NO;

        [MBProgressHUDManager showTextHUDAddedTo:self.view WithText:responseObject[@"result"] afterDelay:1.0f];
    }

}


/**
 *    注册推送消息到来监听
 */
- (void)registerMessageReceive
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onMessageReceived:)
                                                 name:@"CCPDidReceiveMessageNotification"
                                               object:nil];
}
/**
 *    处理到来推送消息
 *
 */

- (void)onMessageReceived:(NSNotification *)notification
{
    [self sendHttpRequest];
}




- (void)foreAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark TableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"UITableViewCell";
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"MessageCell" owner:nil options:nil].lastObject;
        
    }
    [cell fitDataWithDict:self.dataSource[indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 90;
}


@end
