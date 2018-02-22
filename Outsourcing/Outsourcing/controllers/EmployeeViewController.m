//
//  EmployeeViewController.m
//  Outsourcing
//
//  Created by 李文华 on 2017/9/23.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "EmployeeViewController.h"
#import "Masonry.h"
#import "EliveApplication.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "MBProgressHUDManager.h"

#import "OrderListTableViewCell.h"
#import "OrderModel.h"

#import "OrderListCell.h"
#import "OrderListHeaderView.h"
#import "OrderListFooterView.h"
#import "NoResultView.h"
#import "EmployeeDetailController.h"


@interface EmployeeViewController ()<UIScrollViewDelegate,UITableViewDelegate ,UITableViewDataSource>

@property (nonatomic ,strong)UIView *topTabView;

@property (nonatomic ,strong)UILabel *finishedLabel;
@property (nonatomic ,strong)UILabel *unfinishedLabel;
@property (nonatomic ,strong)UIView *tagView;


@property (nonatomic ,strong)UIScrollView *mainSrollView;

@property (nonatomic ,strong)UITableView *finishedTableView;
@property (nonatomic ,strong)UITableView *unfinishedTableView;

@property (nonatomic ,strong)NSMutableArray *finishedArr;
@property (nonatomic ,strong)NSMutableArray *unfinishedArr;

@property (nonatomic ,strong)NSMutableDictionary *parameters;

@property (nonatomic ,strong)NoResultView *uView;

@property (nonatomic ,strong)NoResultView *fView;


@end

@implementation EmployeeViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"我的配送单";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 22, 17);
    [btn setImage:[UIImage imageNamed:@"naviBack"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(foreAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    [self sendHttpRequestForFinish:NO];
    
    [self sendHttpRequestForFinish:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentPage = 1;
    self.currentPage_another = 1;
    
    [self loadConfigUI];
    
    // Do any additional setup after loading the view.
}

- (void)loadConfigUI{
    
    [self.view addSubview:self.topTabView];
    
    [self.mainSrollView addSubview:self.unfinishedTableView];
    
    [self.mainSrollView addSubview:self.finishedTableView];
    
    self.uView = [[NoResultView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight - kTopBarHeight - 40)];
    self.uView.placeHolder.text = @"暂无订单数据";
    self.uView.hidden = YES;
    
    self.fView = [[NoResultView alloc] initWithFrame:CGRectMake(kWidth, 0, kWidth, kHeight - kTopBarHeight - 40)];
    self.fView.placeHolder.text = @"暂无订单数据";
    self.fView.hidden = YES;
    
    [self.mainSrollView addSubview:self.uView];
    [self.mainSrollView addSubview:self.fView];
    
    
    [self.view addSubview:self.mainSrollView];
    
    
    
    
}

-(UIView *)topTabView{
    
    if (!_topTabView) {
        
        _topTabView = [[UIView alloc] initWithFrame:CGRectMake(0, kTopBarHeight, kWidth, 40)];
        _topTabView.backgroundColor = UIColorFromRGBA(0xFFFFFF, 1.0);
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkOutLabel:)];
        
        [_topTabView addGestureRecognizer:tap];
        
        self.finishedLabel = [UILabel new];
        self.finishedLabel.text = @"未配送";
        self.finishedLabel.font = kFont(7);
        self.finishedLabel.textColor = UIColorFromRGBA(0xFA6650, 1.0);
        self.finishedLabel.textAlignment = NSTextAlignmentCenter;
        
        self.unfinishedLabel = [UILabel new];
        self.unfinishedLabel.font = kFont(7);
        self.unfinishedLabel.text = @"已配送";
        self.unfinishedLabel.textColor = UIColorFromRGBA(0x333338, 1.0);
        self.unfinishedLabel.textAlignment = NSTextAlignmentCenter;
        
        self.tagView = [UIView new];
        self.tagView.backgroundColor = UIColorFromRGBA(0xFA6650, 1.0);
        
        [_topTabView addSubview:self.unfinishedLabel];
        [_topTabView addSubview:self.finishedLabel];
        [_topTabView addSubview:self.tagView];
        
        [self.finishedLabel makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(_topTabView).offset(-kWidth/4);
            make.centerY.equalTo(_topTabView);
            
        }];
        
        [self.unfinishedLabel makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(_topTabView).offset(kWidth/4);
            make.centerY.equalTo(_topTabView);
            
        }];
        
        [self.tagView makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.equalTo(CGSizeMake(kWidth/4, 2));
            make.centerX.equalTo(_topTabView).offset(-kWidth/4);;
            make.top.equalTo(_topTabView);
            
        }];
        
    }
    
    return _topTabView;
}


-(UITableView *)finishedTableView {
    
    if (!_finishedTableView) {
        
        _finishedTableView = [[UITableView alloc] initWithFrame:CGRectMake(kWidth, 0, kWidth, kHeight - kTopBarHeight - 40) style:UITableViewStyleGrouped];
        
        _finishedTableView.delegate = self;
        _finishedTableView.dataSource = self;
        _finishedTableView.separatorColor = kClearColor;
        
        _finishedTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            self.currentPage_another = 1;
            self.parameters[@"nPage"] = @"1";
            if (self.finishedArr) {
                
                [self.finishedArr removeAllObjects];
            }
            [self sendHttpRequestForFinish:YES];
        }];
        
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            self.currentPage_another += 1;
            self.parameters[@"nPage"] = [NSString stringWithFormat:@"%ld",self.currentPage_another];
            [self sendHttpRequestForFinish:YES];
        }];
        [footer setTitle:@"已经全部加载完毕" forState:MJRefreshStateNoMoreData];
        
        _finishedTableView.mj_footer = footer;
    }
    
    return _finishedTableView;
}

-(UITableView *)unfinishedTableView{
    
    if (!_unfinishedTableView) {
        
        _unfinishedTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight - kTopBarHeight - 40) style:UITableViewStyleGrouped];
        
        _unfinishedTableView.delegate = self;
        _unfinishedTableView.dataSource = self;
        _unfinishedTableView.separatorColor = kClearColor;
        
        _unfinishedTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            self.currentPage = 1;
            self.parameters[@"nPage"] = @"1";
            if (self.unfinishedArr) {
                
                [self.unfinishedArr removeAllObjects];
            }
            [self sendHttpRequestForFinish:NO];
        }];
        
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            self.currentPage += 1;
            self.parameters[@"nPage"] = [NSString stringWithFormat:@"%ld",self.currentPage];
            [self sendHttpRequestForFinish:NO];
        }];
        [footer setTitle:@"已经全部加载完毕" forState:MJRefreshStateNoMoreData];
        
        _unfinishedTableView.mj_footer = footer;
    }
    
    return _unfinishedTableView;
}


-(UIScrollView *)mainSrollView{
    
    if (!_mainSrollView) {
        
        _mainSrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kTopBarHeight + 40, kWidth, kHeight - kTopBarHeight - 40)];
        _mainSrollView.delegate = self;
        _mainSrollView.contentSize = CGSizeMake(kWidth * 2, 0);
        _mainSrollView.pagingEnabled = YES;
        _mainSrollView.showsVerticalScrollIndicator = NO;
        _mainSrollView.showsHorizontalScrollIndicator = NO;
        _mainSrollView.bounces = NO;
    }
    
    return _mainSrollView;
}

-(NSMutableDictionary *)parameters{
    
    if (!_parameters) {
        
        _parameters = [NSMutableDictionary new];
        _parameters[kCurrentController] = self;
        _parameters[@"nPage"] = @"1";
        _parameters[@"nMaxNum"] = @"4";
        _parameters[@"lDeliveryid"] = [UserTools userEmployeesId];
        _parameters[@"nSendState"] = @"0";
    }
    
    return _parameters;
}

#pragma mark NetWork && 处理数据

- (void)sendHttpRequestForFinish:(BOOL)isFinish{
    
    if (isFinish) {
        
        self.parameters[@"nSendState"] = @"1";
        
    }else{
        
        self.parameters[@"nSendState"] = @"0";
    }
    
    [OutsourceNetWork onHttpCode:kUserOrderListNetWork WithParameters:self.parameters];
    
}


- (void)getUserOrderList:(id)responseObj{
    
    [self.unfinishedTableView.mj_header endRefreshing];
    [self.unfinishedTableView.mj_footer endRefreshing];

    [self.finishedTableView.mj_header endRefreshing];
    [self.finishedTableView.mj_footer endRefreshing];

    if ([responseObj[@"resCode"] isEqualToString:@"0"]) {
        
        if (responseObj[@"result"][@"dataList"]) {
            
            NSArray *data = responseObj[@"result"][@"dataList"];
            
            if (data.count>0 && ![[data[0][@"nSendState"] stringValue] isEqualToString:@"1"]) {
                
                if (data.count < 4) {
                    
                    [self.unfinishedTableView.mj_footer endRefreshingWithNoMoreData];
                }
                if (!self.currentPage || self.currentPage == 1) {
                    
                    self.unfinishedArr = [NSMutableArray arrayWithArray:data];
                }else{
                    
                    for (NSDictionary *dict in data) {
                        
                        [self.unfinishedArr addObject:dict];
                    }
                }
                self.uView.hidden = YES;
                
                [self.unfinishedTableView reloadData];
            }else{
                
                if (data.count < 4) {
                    
                    [self.finishedTableView.mj_footer endRefreshingWithNoMoreData];
                }
                if (!self.currentPage_another || self.currentPage_another == 1) {
                    
                    self.finishedArr = [NSMutableArray arrayWithArray:data];
                }else{
                    
                    for (NSDictionary *dict in data) {
                        
                        [self.finishedArr addObject:dict];
                    }
                }
                self.fView.hidden = YES;
                
                [self.finishedTableView reloadData];
            }
        }
    }
    
    if (!self.finishedArr.count || self.finishedArr.count == 0) {
        
        self.fView.hidden = NO;
    }
    if (!self.unfinishedArr.count || self.unfinishedArr.count == 0) {
        
        self.uView.hidden = NO;
    }
    
}

#pragma mark Click-Method

- (void)sendButtonClick:(UIButton *)sender{

    NSDictionary *dict = self.unfinishedArr[sender.tag];
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[kCurrentController] = self;
    parameters[@"lOrderId"] = dict[@"lId"];
    parameters[@"lDeliveryid"] = [UserTools userEmployeesId];
    parameters[@"strDeliveryname"] = [UserTools userEmployeesName];
    
    [OutsourceNetWork onHttpCode:kJustSendNetWork WithParameters:parameters];
}

- (void)checkOutLabel:(UITapGestureRecognizer *)sender{
    
    CGPoint point = [sender locationInView:self.view];
    NSLog(@"+++++x=%f,y=%f",point.x,point.y);
    
    if (CGRectContainsPoint(CGRectMake(0, kTopBarHeight, kWidth/2, 40), point))
    {
        [self.unfinishedTableView.mj_header beginRefreshing];
        [self checkOutLabelWith:0];//未完成
        
        self.mainSrollView.contentOffset = CGPointMake(0, 0);
        
    }else{
        
        [self.finishedTableView.mj_header beginRefreshing];
        [self checkOutLabelWith:1];//已完成
        
        self.mainSrollView.contentOffset = CGPointMake(kWidth, 0);
    }
}

- (void)checkOutLabelWith:(NSInteger)tag{
    
    if (tag == 0){
        
        self.finishedLabel.textColor = UIColorFromRGBA(0xFA6650, 1.0);
        self.unfinishedLabel.textColor = UIColorFromRGBA(0x333338, 1.0);
        
        [self.tagView updateConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(_topTabView).offset(-kWidth/4);;
            
        }];
        
        
    }else{
        
        self.unfinishedLabel.textColor = UIColorFromRGBA(0xFA6650, 1.0);
        self.finishedLabel.textColor = UIColorFromRGBA(0x333338, 1.0);
        
        [self.tagView updateConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(_topTabView).offset(kWidth/4);;
            
        }];
        
    }
    
}

- (void)foreAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView == self.mainSrollView) {
        
        NSInteger tag = (NSInteger)scrollView.contentOffset.x/kWidth;
        
        [self checkOutLabelWith:tag];
        
    }
    
}

#pragma mark TableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.unfinishedTableView) {
        
        return self.unfinishedArr.count;
    }else {
        
        return self.finishedArr.count;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.unfinishedTableView) {
        
        return [self.unfinishedArr[section][@"orderGoods"] count];
    }else {
        
        return [self.finishedArr[section][@"orderGoods"] count];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    OrderListHeaderView *header = [[NSBundle mainBundle] loadNibNamed:@"OrderListHeaderView" owner:nil options:nil].lastObject;
    
    NSDictionary *dict = [NSDictionary dictionary];
    
    if (tableView == self.finishedTableView) {
        
        dict = self.finishedArr[section];
    }
    if (tableView == self.unfinishedTableView) {
        
        dict = self.unfinishedArr[section];
    }
    
    OrderModel *model = [OrderModel mj_objectWithKeyValues:dict];
    
    [header fitDataWithModel:model];
    
    return header;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    OrderListFooterView *footer = [[NSBundle mainBundle] loadNibNamed:@"OrderListFooterView" owner:nil options:nil].lastObject;
    
    NSMutableDictionary *dict = nil;
    
    if (tableView == self.finishedTableView) {
        
        dict = [NSMutableDictionary dictionaryWithDictionary:self.finishedArr[section]];
    }
    if (tableView == self.unfinishedTableView) {
        
        dict = [NSMutableDictionary dictionaryWithDictionary:self.unfinishedArr[section]];
        footer.sendButton.tag = section;
        [footer.sendButton addTarget:self action:@selector(sendButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    dict[@"conState"] = @"2";
    OrderModel *model = [OrderModel mj_objectWithKeyValues:dict];
    
    [footer fitDataWithModel:model];
    
    return footer;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"UITableViewCell";
    OrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"OrderListCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    NSDictionary *dict = [NSDictionary dictionary];
    
    if (tableView == self.finishedTableView) {
        
        dict = self.finishedArr[indexPath.section][@"orderGoods"][indexPath.row];
    }
    if (tableView == self.unfinishedTableView) {
        
        dict = self.unfinishedArr[indexPath.section][@"orderGoods"][indexPath.row];
    }
    ProductionModel *model = [ProductionModel mj_objectWithKeyValues:dict];
    
    [cell fitConfigWithModel:model];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    EmployeeDetailController *detail = [EmployeeDetailController new];
    if (tableView == self.unfinishedTableView) {
        
        detail.isFinished = NO;
        detail.orderId = self.unfinishedArr[indexPath.section][@"lId"];
    }else{
    
        detail.isFinished = YES;
        detail.orderId = self.finishedArr[indexPath.section][@"lId"];
    }
    
    [self.navigationController pushViewController:detail animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50 *kScale;
}


@end
