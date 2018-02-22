//
//  MyTicketViewController.m
//  Outsourcing
//
//  Created by 李文华 on 2017/8/17.
//  Copyright © 2017年 李文华. All rights reserved.
//



#import "MyTicketViewController.h"
#import "EliveApplication.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "MBProgressHUDManager.h"

#import "MyTicketTableViewCell.h"
#import "TicketModel.h"


@interface MyTicketViewController ()<UITableViewDelegate ,UITableViewDataSource>

@property (nonatomic ,strong)UITableView *mainTableView;

@property (nonatomic ,strong)NSMutableArray *dataSource;

@property (nonatomic ,strong)NoResultView *noDataView;

@end

@implementation MyTicketViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.navigationItem.title = @"我的水票";
    
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
    
    self.noDataView = [[NoResultView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    self.noDataView.placeHolder.text = @"暂无水票";
    self.noDataView.hidden = YES;
    
    [self.view addSubview:self.mainTableView];
    [self.view addSubview:self.noDataView];
    
//    [self sendRequestHttp];
    // Do any additional setup after loading the view.
}


#pragma  mark Setter && Getter

-(UITableView *)mainTableView{

    if (!_mainTableView) {
        
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopBarHeight, kWidth, kHeight - kTopBarHeight) style:UITableViewStylePlain];
        
        _mainTableView.backgroundColor = UIColorFromRGBA(0xF7F7F7, 1.0);
        
        _mainTableView.delegate = self;
        
        _mainTableView.dataSource = self;
        
        _mainTableView.separatorColor = UIColorFromRGBA(0xDDDDDD, 1.0);
        
        UIView *foot = [UIView new];
//        foot.backgroundColor = UIColorFromRGBA(0xF7F7F7, 1.0);
        _mainTableView.tableFooterView = foot;
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

- (void)foreAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark NetWorks

- (void)sendHttpRequest{

    //获取我的水票列表
    NSMutableDictionary *m_parameters = [NSMutableDictionary new];
    m_parameters[kCurrentController] = self;
    m_parameters[@"lUserId"] = [UserTools getUserId];
    m_parameters[@"nMaxNum"] = @"100";
    m_parameters[@"nPage"] = @"1";
    
    [OutsourceNetWork onHttpCode:kUserGetTicketListNetWork WithParameters:m_parameters];

}

- (void)getMyTicket:(id)responseObject{

    if ([responseObject[@"resCode"] isEqualToString:@"0"]) {
        
        self.dataSource = responseObject[@"result"][@"dataList"];
        
        self.noDataView.hidden = YES;
        [self.mainTableView reloadData];
        NSLog(@"%@",responseObject);
    }else{
        
        self.noDataView.hidden = NO;
//        [MBProgressHUDManager showTextHUDAddedTo:self.view WithText:responseObject[@"result"] afterDelay:1.0f];
    }
}


#pragma mark TableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"UITableViewCell";
    MyTicketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil)
    {
        cell = [[MyTicketTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID] ;
        
    }
    
    TicketModel *model = [TicketModel mj_objectWithKeyValues:self.dataSource[indexPath.row]];
    
    [cell fitDataWithModel:model];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 42 *kScale;
}

@end
