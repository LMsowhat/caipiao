//
//  WaterTicketViewController.m
//  Outsourcing
//
//  Created by 李文华 on 2017/6/14.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "WaterTicketViewController.h"
#import "Masonry.h"
#import "MJExtension.h"
#import "EliveApplication.h"
#import "MBProgressHUDManager.h"
#import "MJRefresh.h"

#import "TicketListTableViewCell.h"
#import "BuyTicketViewController.h"
#import "TicketModel.h"


@interface WaterTicketViewController ()<UIScrollViewDelegate,UITableViewDelegate ,UITableViewDataSource>

@property (nonatomic ,strong)UIView *topTabView;

@property (nonatomic ,strong)UILabel *myTicketLabel;
@property (nonatomic ,strong)UILabel *buyTicketLabel;
@property (nonatomic ,strong)UIView *tagView;


@property (nonatomic ,strong)UIScrollView *mainSrollView;

@property (nonatomic ,strong)UITableView *myTicketTableView;
@property (nonatomic ,strong)UITableView *buyTicketTableView;

@property (nonatomic ,strong)NSMutableArray *dataSource;

@property (nonatomic ,strong)NSMutableArray *m_dataSource;

@property (nonatomic ,strong)NoResultView *uView;

@property (nonatomic ,strong)NoResultView *fView;


@end

@implementation WaterTicketViewController


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"水票";
    
    [self sendRequestHttp];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigUI];
    // Do any additional setup after loading the view.
}

- (void)loadConfigUI{
    
    [self.view addSubview:self.topTabView];
    
    [self.mainSrollView addSubview:self.buyTicketTableView];
    
    [self.mainSrollView addSubview:self.myTicketTableView];
    
    self.uView = [[NoResultView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight - kTopBarHeight - 40)];
    self.uView.placeHolder.text = @"暂无水票";
    self.uView.hidden = YES;
    
    self.fView = [[NoResultView alloc] initWithFrame:CGRectMake(kWidth, 0, kWidth, kHeight - kTopBarHeight - 40)];
    self.fView.placeHolder.text = @"暂无水票";
    self.fView.hidden = YES;
    
    [self.mainSrollView addSubview:self.uView];
    [self.mainSrollView addSubview:self.fView];
    
    [self.view addSubview:self.mainSrollView];
    

}


#pragma mark Setter & Getter

-(UIView *)topTabView{
    
    if (!_topTabView) {
        
        _topTabView = [[UIView alloc] initWithFrame:CGRectMake(0, kTopBarHeight, kWidth, 40)];
        _topTabView.backgroundColor = UIColorFromRGBA(0xFFFFFF, 1.0);
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkOutLabel:)];
        
        [_topTabView addGestureRecognizer:tap];
        
        self.myTicketLabel = [UILabel new];
        self.myTicketLabel.text = @"购买水票";
        self.myTicketLabel.font = kFont(7);
        self.myTicketLabel.textColor = UIColorFromRGBA(0xFA6650, 1.0);
        self.myTicketLabel.textAlignment = NSTextAlignmentCenter;
        
        self.buyTicketLabel = [UILabel new];
        self.buyTicketLabel.font = kFont(7);
        self.buyTicketLabel.text = @"我的水票";
        self.buyTicketLabel.textColor = UIColorFromRGBA(0x333338, 1.0);
        self.buyTicketLabel.textAlignment = NSTextAlignmentCenter;
        
        self.tagView = [UIView new];
        self.tagView.backgroundColor = UIColorFromRGBA(0xFA6650, 1.0);
        
        [_topTabView addSubview:self.myTicketLabel];
        [_topTabView addSubview:self.buyTicketLabel];
        [_topTabView addSubview:self.tagView];
        
        [self.myTicketLabel makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(_topTabView).offset(-kWidth/4);
            make.centerY.equalTo(_topTabView);
            
        }];
        
        [self.buyTicketLabel makeConstraints:^(MASConstraintMaker *make) {
            
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


-(UITableView *)myTicketTableView {
    
    if (!_myTicketTableView) {
        
        _myTicketTableView = [[UITableView alloc] initWithFrame:CGRectMake(kWidth, 0, kWidth, kHeight - kTopBarHeight - 40 - kTabBarHeight) style:UITableViewStylePlain];
        
        _myTicketTableView.delegate = self;
        _myTicketTableView.dataSource = self;
        _myTicketTableView.separatorColor = kClearColor;
        
        _myTicketTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            self.currentPage_another = 1;
            if (self.m_dataSource) {
                
                [self.m_dataSource removeAllObjects];
            }
            [self getMyTicketListRequest];
        }];
        
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            self.currentPage_another += 1;
            [self getMyTicketListRequest];
        }];
        [footer setTitle:@"已经全部加载完毕" forState:MJRefreshStateNoMoreData];
        
        _myTicketTableView.mj_footer = footer;
        
    }
    
    return _myTicketTableView;
}

-(UITableView *)buyTicketTableView{
    
    if (!_buyTicketTableView) {
        
        _buyTicketTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight - kTopBarHeight - 40 - kTabBarHeight) style:UITableViewStylePlain];
        
        _buyTicketTableView.delegate = self;
        _buyTicketTableView.dataSource = self;
        _buyTicketTableView.separatorColor = kClearColor;
        
        _buyTicketTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            self.currentPage = 1;
            if (self.dataSource) {
                
                [self.dataSource removeAllObjects];
            }
            [self getTiketListRequest];
        }];
        
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            self.currentPage += 1;
            [self getTiketListRequest];
        }];
        [footer setTitle:@"已经全部加载完毕" forState:MJRefreshStateNoMoreData];
        
        _buyTicketTableView.mj_footer = footer;
    }
    
    return _buyTicketTableView;
}


-(UIScrollView *)mainSrollView{
    
    if (!_mainSrollView) {
        
        _mainSrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kTopBarHeight + 40, kWidth, kHeight - kTopBarHeight - 40 - kTabBarHeight)];
        _mainSrollView.delegate = self;
        _mainSrollView.contentSize = CGSizeMake(kWidth * 2, 0);
        _mainSrollView.pagingEnabled = YES;
        _mainSrollView.showsVerticalScrollIndicator = NO;
        _mainSrollView.showsHorizontalScrollIndicator = NO;
        _mainSrollView.bounces = NO;
        
    }
    
    return _mainSrollView;
}

-(NSMutableArray *)dataSource{

    if (!_dataSource) {
        
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

-(NSMutableArray *)m_dataSource{

    if (!_m_dataSource) {
        
        _m_dataSource = [NSMutableArray new];
    }
    return _m_dataSource;
}


#pragma mark Click_Method

- (void)buyBtnClick:(UIButton *)sender{
    
    BuyTicketViewController *buyTicket = [BuyTicketViewController new];
    buyTicket.ticketId = self.dataSource[sender.tag][@"lId"];
    
    [self.navigationController pushViewController:buyTicket animated:YES];

}

- (void)checkOutLabel:(UITapGestureRecognizer *)sender{
    
    CGPoint point = [sender locationInView:self.view];
    NSLog(@"+++++x=%f,y=%f",point.x,point.y);
    
    if (CGRectContainsPoint(CGRectMake(0, kTopBarHeight, kWidth/2, 40), point))
    {
        [self.buyTicketTableView.mj_header beginRefreshing];

        [self checkOutLabelWith:0];
        
        self.mainSrollView.contentOffset = CGPointMake(0, 0);
        
    }else{

        [self.myTicketTableView.mj_header beginRefreshing];

        [self checkOutLabelWith:1];
        
        self.mainSrollView.contentOffset = CGPointMake(kWidth, 0);
        
    }
    
}

- (void)checkOutLabelWith:(NSInteger)tag{
    
    if (tag == 0){
        
        self.myTicketLabel.textColor = UIColorFromRGBA(0xFA6650, 1.0);
        self.buyTicketLabel.textColor = UIColorFromRGBA(0x333338, 1.0);
        
        [self.myTicketTableView.mj_header beginRefreshing];
        [self.tagView updateConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(_topTabView).offset(-kWidth/4);;
        }];
    }else{
        self.buyTicketLabel.textColor = UIColorFromRGBA(0xFA6650, 1.0);
        self.myTicketLabel.textColor = UIColorFromRGBA(0x333338, 1.0);
        
        [self.tagView updateConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(_topTabView).offset(kWidth/4);;
        }];
    }
}


#pragma mark NetWorks

- (void)sendRequestHttp{
    
    [self getTiketListRequest];
    
    [self getMyTicketListRequest];
}

- (void)getTiketListRequest{

    //获取水票列表
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[kCurrentController] = self;
    parameters[@"nMaxNum"] = @"10";
    parameters[@"nPage"] = self.currentPage ? [NSString stringWithFormat:@"%ld",self.currentPage] : @"1";
    
    [OutsourceNetWork onHttpCode:kProductionTicketListNetWork WithParameters:parameters];
}

- (void)getMyTicketListRequest{

    if ([UserTools getUserId]) {
        //获取我的水票列表
        NSMutableDictionary *m_parameters = [NSMutableDictionary new];
        m_parameters[kCurrentController] = self;
        m_parameters[@"lUserId"] = [UserTools getUserId];
        m_parameters[@"nMaxNum"] = @"10";
        m_parameters[@"nPage"] = self.currentPage_another ? [NSString stringWithFormat:@"%ld",self.currentPage_another] : @"1";
        
        [OutsourceNetWork onHttpCode:kUserGetTicketListNetWork WithParameters:m_parameters];
    }else{
        
//        [self.myTicketTableView.mj_header endRefreshing];
    }
    
}


- (void)getTicketList:(id)responseObj{
    
    [self.buyTicketTableView.mj_header endRefreshing];
    [self.buyTicketTableView.mj_footer endRefreshing];
    
    if ([responseObj[@"resCode"] isEqualToString:@"0"]) {
        
        if (!self.currentPage || self.currentPage == 1) {
            
            self.dataSource = [NSMutableArray arrayWithArray:responseObj[@"result"][@"dataList"]];
        }else{
        
            for (NSDictionary *temp in responseObj[@"result"][@"dataList"]) {
                
                [self.dataSource addObject:temp];
            }
        }
        if ([responseObj[@"result"][@"dataList"] count] < 10) {
            
            [self.buyTicketTableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        self.uView.hidden = YES;
        [self.buyTicketTableView reloadData];
        NSLog(@"%@",responseObj);
    }else{
        
        self.uView.hidden = NO;
        
//        [MBProgressHUDManager showTextHUDAddedTo:self.view WithText:responseObj[@"result"] afterDelay:1.0f];
    }
}

- (void)getUserTicketList:(id)responseObj{

    [self.myTicketTableView.mj_header endRefreshing];
    [self.myTicketTableView.mj_footer endRefreshing];
    
    if ([responseObj[@"resCode"] isEqualToString:@"0"]) {
        
        if (!self.currentPage_another || self.currentPage_another == 1) {
            
            self.m_dataSource = [NSMutableArray arrayWithArray:responseObj[@"result"][@"dataList"]];
        }else{
            
            for (NSDictionary *temp in responseObj[@"result"][@"dataList"]) {
                
                [self.m_dataSource addObject:temp];
            }
        }
        if ([responseObj[@"result"][@"dataList"] count] < 10) {
            
            [self.myTicketTableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        self.fView.hidden = YES;
        [self.myTicketTableView reloadData];
        NSLog(@"%@",responseObj);
    }else{
    
        self.fView.hidden = NO;
//        [MBProgressHUDManager showTextHUDAddedTo:self.view WithText:responseObj[@"result"] afterDelay:1.0f];
    }
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
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.buyTicketTableView) {
        
        return self.dataSource.count;
    }
    if (tableView == self.myTicketTableView) {
        
        return self.m_dataSource.count;
    }
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"TicketCell";
    TicketListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil)
    {
        cell = [[TicketListTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    if (tableView == self.myTicketTableView) {
        
        TicketModel *model = [TicketModel mj_objectWithKeyValues:self.m_dataSource[indexPath.row]];

        [cell myTicketFitData:model];
    }else{
    
        TicketModel *model = [TicketModel mj_objectWithKeyValues:self.dataSource[indexPath.row]];
        [cell buyTicketFitData:model];
        
        cell.buyBtn.tag = indexPath.row;
        [cell.buyBtn addTarget:self action:@selector(buyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 150;
}


@end
