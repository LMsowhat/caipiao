//
//  EmployeeDetailController.m
//  Outsourcing
//
//  Created by 李文华 on 2017/9/28.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "EmployeeDetailController.h"
#import "EliveApplication.h"
#import "MJExtension.h"
#import "MBProgressHUDManager.h"

#import "OrderDetailListCell.h"
#import "SubmitOrderProModel.h"
#import "ProductionShowView.h"

#import "EmploeeDetailHeaderView.h"
#import "EmploeeDetailFooterView.h"

@interface EmployeeDetailController ()<UITableViewDelegate,UITableViewDataSource>

//提交订单按钮
@property (nonatomic ,strong)UIButton *oSettlementBtn;

//订单商品列表
@property (nonatomic ,strong)UITableView *mainTableView;

@property (nonatomic ,strong)NSDictionary *dataSource;

@property (nonatomic ,strong)EmploeeDetailHeaderView *headerView;

@property (nonatomic ,strong)EmploeeDetailFooterView *footerView;

@property (nonatomic ,strong)NSTimer *timer;


@end

@implementation EmployeeDetailController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"配送单详情";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 22, 17);
    [btn setImage:[UIImage imageNamed:@"naviBack"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(foreAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    [self sendHttpRequest];

}

-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
    [self.timer invalidate];
    self.timer = nil;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.mainTableView];
    [self.view addSubview:self.oSettlementBtn];
    
    // Do any additional setup after loading the view.
}

#pragma mark Setter && Getter

-(UITableView *)mainTableView{
    
    if (!_mainTableView) {
        
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopBarHeight, kWidth, kHeight - kTopBarHeight - 24.5 *kScale) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.showsVerticalScrollIndicator = NO;
        _mainTableView.showsHorizontalScrollIndicator = NO;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.headerView = [[NSBundle mainBundle] loadNibNamed:@"EmploeeDetailHeaderView" owner:nil options:nil].lastObject;
        
        self.footerView = [[NSBundle mainBundle] loadNibNamed:@"EmploeeDetailFooterView" owner:nil options:nil].lastObject;
        
        _mainTableView.tableHeaderView = self.headerView;
        _mainTableView.tableFooterView = self.footerView;
        
    }
    return _mainTableView;
}

-(NSDictionary *)dataSource{
    
    if (!_dataSource) {
        
        _dataSource = [NSDictionary new];
    }
    return _dataSource;
}

-(UIButton *)oSettlementBtn{
    
    if (!_oSettlementBtn) {
        
        _oSettlementBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _oSettlementBtn.frame = CGRectMake(0, kHeight - 24.5*kScale, kWidth, 24.5*kScale);
        [_oSettlementBtn.titleLabel setFont:kFont(7)];
        [_oSettlementBtn setTitle:@"确认配送" forState:UIControlStateNormal];
        [_oSettlementBtn setTitleColor:UIColorFromRGBA(0xFFFFFF, 1.0) forState:UIControlStateNormal];
        _oSettlementBtn.backgroundColor = UIColorFromRGBA(0xFA6650, 1.0);
        [_oSettlementBtn addTarget:self action:@selector(settlementClick) forControlEvents:UIControlEventTouchUpInside];
        _oSettlementBtn.hidden = self.isFinished;
    }
    return _oSettlementBtn;
}


- (UIView *)createProCell:(NSIndexPath *)indexPath{
    
    SubmitOrderProModel *model = [SubmitOrderProModel mj_objectWithKeyValues:self.dataSource[@"orderGoods"][indexPath.row]];
    
    ProductionShowView *cell = [[ProductionShowView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 45 *kScale) AndModel:model];
    
    return cell;
}


#pragma mark NetWorks

- (void)sendHttpRequest{
    
    //获取订单详情
    NSMutableDictionary *parametes = [NSMutableDictionary new];
    parametes[kCurrentController] = self;
    parametes[@"lOrderId"] = self.orderId;
    
    [OutsourceNetWork onHttpCode:kOrderDetailTwoNetWork WithParameters:parametes];
    
}


- (void)deliveryGetDetail:(id)responseObj{
    
    if ([responseObj[@"resCode"] isEqualToString:@"0"] && responseObj[@"result"]) {
        
        self.dataSource = responseObj[@"result"];
        //收货人
        self.headerView.receveName.text = [NSString stringWithFormat:@"%@    %@",self.dataSource[@"strReceiptusername"],self.dataSource[@"strReceiptmobile"]];
        //地址
        self.headerView.receveAddress.text = [NSString stringWithFormat:@"%@%@",self.dataSource[@"strLocation"],self.dataSource[@"strDetailaddress"]];
        //订单创建时间
        self.headerView.subOrderTime.text = [CommonTools getTimeFromString:self.dataSource[@"dtCreatetime"]];
        //付款时间
        self.headerView.payOrderTime.text = [CommonTools getTimeFromString:self.dataSource[@"dtPaytime"]];
        //订单号
        self.headerView.orderNum.text = self.dataSource[@"strOrdernum"];

        //桶押金
        self.footerView.bucketPrice.text = [NSString stringWithFormat:@"%.2f",[self.dataSource[@"nBucketmoney"] floatValue]/100];
        //押桶个数
        self.footerView.bucketNum.text = [NSString stringWithFormat:@"x%@",self.dataSource[@"nBucketnum"]];
        //付款金额
        self.footerView.payMoney.text = [NSString stringWithFormat:@"%.2f",[self.dataSource[@"nFactPrice"] floatValue]/100];
        //优惠券金额
        self.footerView.ticketNum.text = [NSString stringWithFormat:@"%.2f",[self.dataSource[@"nCouponPrice"] floatValue]/100];
        
        [self.mainTableView reloadData];
        
    }else{
        
        [MBProgressHUDManager showTextHUDAddedTo:self.view WithText:responseObj[@"result"] afterDelay:1.0f];
    }
}



#pragma mark Target

- (void)settlementClick{
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[kCurrentController] = self;
    parameters[@"lOrderId"] = self.orderId;
    parameters[@"lDeliveryid"] = [UserTools userEmployeesId];
    parameters[@"strDeliveryname"] = [UserTools userEmployeesName];
    
    [OutsourceNetWork onHttpCode:kJustSendNetWork WithParameters:parameters];
    
}


- (void)actionToSendResult:(id)responseObject{
    
    if ([responseObject[@"resCode"] isEqualToString:@"0"]) {
        
        [MBProgressHUDManager showTextHUDAddedTo:self.view WithText:@"配送成功" afterDelay:1.5f];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(foreAction) userInfo:nil repeats:NO];
        
    }else{
        
        [MBProgressHUDManager showTextHUDAddedTo:self.view WithText:responseObject[@"result"] afterDelay:1.5f];
    }
    
    NSLog(@"%@",responseObject);
}



- (void)foreAction{
    
    [self.navigationController popViewControllerAnimated:YES];

}





#pragma mark TableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [self.dataSource[@"orderGoods"] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"UITableViewCell";
    OrderDetailListCell *cell = [[OrderDetailListCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setLeftView:nil RightView:nil others:[self createProCell:indexPath]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"%ld",indexPath.row);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30*kScale;
}


@end
