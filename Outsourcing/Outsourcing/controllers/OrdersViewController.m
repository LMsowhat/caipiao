//
//  OrdersViewController.m
//  Outsourcing
//
//  Created by 李文华 on 2017/6/14.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "OrdersViewController.h"
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
#import "PaymentViewController.h"
#import "OrderCreateController.h"
#import "AboutUsViewController.h"


@interface OrdersViewController ()<UIScrollViewDelegate,UITableViewDelegate ,UITableViewDataSource>

@property (nonatomic ,strong)UIView *topTabView;

@property (nonatomic ,strong)UILabel *finishedLabel;
@property (nonatomic ,strong)UILabel *unfinishedLabel;
@property (nonatomic ,strong)UIView *tagView;


@property (nonatomic ,strong)UIScrollView *mainSrollView;

@property (nonatomic ,strong)UITableView *finishedTableView;
@property (nonatomic ,strong)UITableView *unfinishedTableView;

@property (nonatomic ,strong)NSMutableArray *dataSource;

@property (nonatomic ,strong)NSMutableArray *finishedArr;
@property (nonatomic ,strong)NSMutableArray *unfinishedArr;

@property (nonatomic ,strong)NSMutableDictionary *parameters;

@property (nonatomic ,strong)NoResultView *uView;

@property (nonatomic ,strong)NoResultView *fView;


@end

@implementation OrdersViewController

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];

    self.navigationItem.title = @"我的订单";
    
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
- (void)loasssdConfigUI{
    
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
-(UIView *)dddsssstopTabView{
    
    if (!_topTabView) {
        
        _topTabView = [[UIView alloc] initWithFrame:CGRectMake(0, kTopBarHeight, kWidth, 40)];
        _topTabView.backgroundColor = UIColorFromRGBA(0xFFFFFF, 1.0);
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkOutLabel:)];
        
        [_topTabView addGestureRecognizer:tap];
        
        self.finishedLabel = [UILabel new];
        self.finishedLabel.text = @"未完成";
        self.finishedLabel.font = kFont(7);
        self.finishedLabel.textColor = UIColorFromRGBA(0xFA6650, 1.0);
        self.finishedLabel.textAlignment = NSTextAlignmentCenter;
        
        self.unfinishedLabel = [UILabel new];
        self.unfinishedLabel.font = kFont(7);
        self.unfinishedLabel.text = @"已完成";
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

-(UIView *)topTabView{

    if (!_topTabView) {
        
        _topTabView = [[UIView alloc] initWithFrame:CGRectMake(0, kTopBarHeight, kWidth, 40)];
        _topTabView.backgroundColor = UIColorFromRGBA(0xFFFFFF, 1.0);
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkOutLabel:)];
        
        [_topTabView addGestureRecognizer:tap];
        
        self.finishedLabel = [UILabel new];
        self.finishedLabel.text = @"未完成";
        self.finishedLabel.font = kFont(7);
        self.finishedLabel.textColor = UIColorFromRGBA(0xFA6650, 1.0);
        self.finishedLabel.textAlignment = NSTextAlignmentCenter;
        
        self.unfinishedLabel = [UILabel new];
        self.unfinishedLabel.font = kFont(7);
        self.unfinishedLabel.text = @"已完成";
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
        _parameters[@"lBuyerid"] = [UserTools getUserId];
        _parameters[@"nState"] = @"-1";
    }

    return _parameters;
}

#pragma mark NetWork && 处理数据

- (void)sendHttpRequestForFinish:(BOOL)isFinish{
    
    if (isFinish) {
        self.parameters[@"nState"] = @"3";
    }else{
        self.parameters[@"nState"] = @"-1";
    }
    [OutsourceNetWork onHttpCode:kUserOrderListNetWork WithParameters:self.parameters];

}

- (void)getUserOrderList:(id)responseObj{

    if ([responseObj[@"resCode"] isEqualToString:@"0"]) {
        
        if (responseObj[@"result"][@"dataList"]) {
            
            NSArray *data = responseObj[@"result"][@"dataList"];
            
            if (data.count>0 && ![[data[0][@"nState"] stringValue] isEqualToString:@"3"]) {
                if (data.count < 4) {
                    [self.unfinishedTableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.unfinishedTableView.mj_footer endRefreshing];
                }
                [self.unfinishedTableView.mj_header endRefreshing];

                if (self.currentPage == 1) {
                    [self.unfinishedTableView.mj_header endRefreshing];

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
                }else{
                    [self.finishedTableView.mj_footer endRefreshing];
                }
                if (self.currentPage_another == 1) {
                    [self.finishedTableView.mj_header endRefreshing];

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

- (void)deleteOrderResult:(id)responseObject{

    if ([responseObject[@"resCode"] isEqualToString:@"0"]) {
        
        [MBProgressHUDManager showTextHUDAddedTo:self.view WithText:@"删除成功" afterDelay:1.5f];

        self.currentPage = 1;
        self.currentPage_another = 1;
        [self sendHttpRequestForFinish:NO];
        [self sendHttpRequestForFinish:YES];
    }else{
        
        [MBProgressHUDManager showTextHUDAddedTo:self.view WithText:responseObject[@"result"] afterDelay:1.5f];
    }
    NSLog(@"%@",responseObject);
}



#pragma mark Click-Method

- (void)deleteButtonClick:(UIButton *)sender{
    
    WeakSelf(weakSelf);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确认删除此商品？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        NSDictionary *dict = weakSelf.unfinishedArr[sender.tag];

        NSMutableDictionary *parameters = [NSMutableDictionary new];
        parameters[kCurrentController] = weakSelf;
        parameters[@"lOrderId"] = dict[@"lId"];
        
        [OutsourceNetWork onHttpCode:kDeleteOrderNetWork WithParameters:parameters];
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        return ;
    }]];
    
    [weakSelf presentViewController:alertController animated:YES completion:nil];
}

- (void)payButtonClick:(UIButton *)sender{
    
    NSString *bTitle = sender.titleLabel.text;
    
    NSDictionary *dict = self.unfinishedArr[sender.tag];

    if ([bTitle isEqualToString:@"去结算"]) {
        
        OrderCreateController *creat = [OrderCreateController new];
        creat.orderId = dict[@"lId"];
        
        [self.navigationController pushViewController:creat animated:YES];
    }
    if ([bTitle isEqualToString:@"立即支付"]) {
        
        PaymentViewController *pay = [PaymentViewController new];
        pay.orderId = dict[@"lId"];
        pay.nOrderType = @"0";
        pay.factTotalPrice = [dict[@"nFactPrice"] floatValue];
        
        [self.navigationController pushViewController:pay animated:YES];
    }
    
}

- (void)followOrderClick:(UIButton *)sender{

    NSDictionary *dict = self.finishedArr[sender.tag];

    AboutUsViewController *orderFollow = [AboutUsViewController new];
    orderFollow.orderId = dict[@"lId"];
    
    [self.navigationController pushViewController:orderFollow animated:YES];
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
        
        footer.followOrder.tag = section;
        [footer.followOrder addTarget:self action:@selector(followOrderClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (tableView == self.unfinishedTableView) {
        
        dict = [NSMutableDictionary dictionaryWithDictionary:self.unfinishedArr[section]];
        footer.deleteButton.tag = section;
        footer.payButton.tag = section;
        [footer.deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [footer.payButton addTarget:self action:@selector(payButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    dict[@"conState"] = @"1";
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
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50 *kScale;
}


@end
