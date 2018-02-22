//
//  OrderDetailViewController.m
//  Outsourcing
//
//  Created by 李文华 on 2017/9/16.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "Masonry.h"
#import "EliveApplication.h"
#import "MBProgressHUDManager.h"
#import "MJExtension.h"



#import "OrderDetailListCell.h"
#import "ProductionShowView.h"
#import "PaymentViewController.h"
#import "SubmitOrderProModel.h"
#import "OrderModel.h"
#import "OrderHeaderView.h"

@interface OrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource>


//水票
@property (nonatomic ,strong)UILabel *oWTicket;

//提交订单按钮
@property (nonatomic ,strong)UIButton *oSettlementBtn;

//订单商品列表
@property (nonatomic ,strong)UITableView *mainTableView;

@property (nonatomic ,strong)NSDictionary *dataSource;

//地址UILabel *
@property (nonatomic ,strong)UIView *addressView;

@property (nonatomic ,strong)UILabel *receiveName;
@property (nonatomic ,strong)UILabel *receiveAddress;
//商品头部展示

@property (nonatomic ,strong)OrderHeaderView *headerView;
//商品底部展示
@property (nonatomic ,strong)UIView *proBottomView;

@property (nonatomic ,strong)UILabel *nBucketPrice;

@property (nonatomic ,strong)UILabel *oTotalPrice;

//是否使用全部水票支付
@property (nonatomic ,assign)BOOL isTicketPayOff;
@property (nonatomic ,strong)OrderModel *model;

@end

@implementation OrderDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"订单详情";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 22, 17);
    [btn setImage:[UIImage imageNamed:@"naviBack"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(foreAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.mainTableView];
    [self.view addSubview:self.oSettlementBtn];
    
    [self sendHttpRequest];
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
        
    }
    return _mainTableView;
}

-(NSDictionary *)dataSource{
    
    if (!_dataSource) {
        
        _dataSource = [NSDictionary new];
    }
    return _dataSource;
}

- (UILabel *)oWTicket{
    
    if (!_oWTicket) {
        
        _oWTicket = [UILabel new];
        _oWTicket.font = kFont(7);
        _oWTicket.textColor = UIColorFromRGBA(0x8F9095, 1.0);
        //        _oWTicket.text = @"本次使用水票0张";
    }
    return _oWTicket;
}

-(UIButton *)oSettlementBtn{
    
    if (!_oSettlementBtn) {
        
        _oSettlementBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _oSettlementBtn.frame = CGRectMake(0, kHeight - 24.5*kScale, kWidth, 24.5*kScale);
        [_oSettlementBtn.titleLabel setFont:kFont(7)];
        [_oSettlementBtn setTitle:@"去付款" forState:UIControlStateNormal];
        [_oSettlementBtn setTitleColor:UIColorFromRGBA(0xFFFFFF, 1.0) forState:UIControlStateNormal];
        _oSettlementBtn.backgroundColor = UIColorFromRGBA(0xFA6650, 1.0);
        [_oSettlementBtn addTarget:self action:@selector(settlementClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _oSettlementBtn;
}

-(OrderHeaderView *)headerView{

    if (!_headerView) {
        
        _headerView = [[NSBundle mainBundle] loadNibNamed:@"OrderHeaderView" owner:nil options:nil].lastObject;
    }

    return _headerView;
}

-(UIView *)addressView{
    
    if (!_addressView) {
        
        _addressView = [UIView new];
        
        self.receiveName = [UILabel new];
        self.receiveName.font = kFont(6);
        self.receiveName.textColor = UIColorFromRGBA(0x8F9095, 1.0);
        //        self.receiveName.text = @"李文华  15011075120";
        
        self.receiveAddress = [UILabel new];
        self.receiveAddress.font = kFont(6);
        self.receiveAddress.textColor = UIColorFromRGBA(0x8F9095, 1.0);
        //        self.receiveAddress.text = @"北京市海淀区知春路113号银网中心A座808";
        
        self.receiveName.text = [NSString stringWithFormat:@"%@   %@",self.dataSource[@"strReceiptusername"],self.dataSource[@"strReceiptmobile"]];
        self.receiveAddress.text = [NSString stringWithFormat:@"%@%@",self.dataSource[@"strLocation"],self.dataSource[@"strDetailaddress"]];
        
        [_addressView addSubview:self.receiveName];
        [_addressView addSubview:self.receiveAddress];
        
        [self.receiveName makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_addressView).offset(10 *kScale);
            
            make.top.equalTo(_addressView).offset(3 *kScale);
        }];
        
        [self.receiveAddress makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_addressView).offset(10 *kScale);
            
            make.top.equalTo(self.receiveName.mas_bottom).offset(2 *kScale);
        }];
    }
    return _addressView;
}


-(UIView *)proBottomView{
    
    if (!_proBottomView) {
        
        _proBottomView = [UIView new];
        
        self.nBucketPrice = [UILabel new];
        self.nBucketPrice = [UILabel new];
        self.nBucketPrice.font = kFont(6);
        self.nBucketPrice.textColor = UIColorFromRGBA(0x8F9095, 1.0);
        
        UILabel *oTotalTitle = [UILabel new];
        oTotalTitle = [UILabel new];
        oTotalTitle.font = kFont(7);
        oTotalTitle.textColor = UIColorFromRGBA(0x333338, 1.0);
        oTotalTitle.text = @"商品总价：";
        
        self.oTotalPrice = [UILabel new];
        self.oTotalPrice = [UILabel new];
        self.oTotalPrice.font = kFont(7);
        self.oTotalPrice.textColor = UIColorFromRGBA(0x333338, 1.0);
        
        UIView *line = [UIView new];
        line.backgroundColor = UIColorFromRGBA(0xDDDDDD, 1.0);
        
        [_proBottomView addSubview:self.nBucketPrice];
        [_proBottomView addSubview:oTotalTitle];
        [_proBottomView addSubview:self.oTotalPrice];
        [_proBottomView addSubview:line];
        
        [self.nBucketPrice makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(_proBottomView);
            
            make.left.equalTo(_proBottomView).offset(10 *kScale);
        }];
        
        [self.oTotalPrice makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(_proBottomView);
            
            make.right.equalTo(_proBottomView).offset(-10 *kScale);
        }];
        
        [oTotalTitle makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(_proBottomView);
            
            make.right.equalTo(self.oTotalPrice.mas_left).offset(-2 *kScale);
        }];
        
        [line makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.equalTo(CGSizeMake(kWidth - 10 *kScale, 1));
            
            make.centerX.equalTo(_proBottomView);
            
            make.bottom.equalTo(_proBottomView).offset(-1);
        }];
    }
    return _proBottomView;
}


- (UIView *)createProCell:(NSIndexPath *)indexPath{
    
    SubmitOrderProModel *model = [SubmitOrderProModel mj_objectWithKeyValues:self.dataSource[@"orderGoods"][indexPath.row - 3]];
    
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

- (void)setPayNstateHttpRequest{

    //修改订单为成功
    NSMutableDictionary *parametes = [NSMutableDictionary new];
    parametes[kCurrentController] = self;
    parametes[@"lOrderId"] = self.orderId;
    parametes[@"nState"] = @"3";
    
    [OutsourceNetWork onHttpCode:kTicketallPayNetWork WithParameters:parametes];
}

- (void)setPayNstateResult:(id)responseObject{

    PaymentViewController *payMent = [PaymentViewController new];
    payMent.factTotalPrice = [self.dataSource[@"nFactPrice"] floatValue];
    payMent.orderId = self.orderId;
    payMent.orderModel = self.model;
    payMent.nOrderType = @"0";
    payMent.isTicketPay = self.isTicketPayOff;
    
    [self.navigationController pushViewController:payMent animated:YES];
    NSLog(@"%@",responseObject);
}



- (void)orderGetDetail:(id)responseObj{

    if ([responseObj[@"resCode"] isEqualToString:@"0"] && responseObj[@"result"]) {
        
        self.dataSource = responseObj[@"result"];
        
        self.model = [OrderModel mj_objectWithKeyValues:self.dataSource];
        
        NSInteger nBucketmoney = [self.dataSource[@"nBucketmoney"] integerValue];
        NSInteger ticketNum = 0;
        for (NSDictionary *temp in self.dataSource[@"orderGoods"]) {
            
            NSInteger num = [temp[@"nWatertickets"] integerValue];
            
            ticketNum += num;
        }
        //订单时间和订单号
        self.headerView.creatTime.text = [NSString stringWithFormat:@"下单时间：%@",[CommonTools getTimeFromString:self.dataSource[@"dtCreatetime"]]];
        self.headerView.orderNumber.text = [NSString stringWithFormat:@"订单号：%@",self.dataSource[@"strOrdernum"]];
        
        //收获地址
        self.receiveName.text = [NSString stringWithFormat:@"%@   %@",self.dataSource[@"strReceiptusername"],self.dataSource[@"strReceiptmobile"]];
        self.receiveAddress.text = [NSString stringWithFormat:@"%@%@",self.dataSource[@"strLocation"],self.dataSource[@"strDetailaddress"]];
        //使用水票情况
        self.oWTicket.text = [NSString stringWithFormat:@"本次使用水票%ld张",ticketNum];
        //桶押金
        self.nBucketPrice.text = [NSString stringWithFormat:@"桶押金 ￥%.2f (x %ld)",[self.dataSource[@"nBucketnum"] floatValue] * nBucketmoney/100,[self.dataSource[@"nBucketnum"] integerValue]];
        //订单总价
        self.oTotalPrice.text = [NSString stringWithFormat:@"￥%.2f",[self.dataSource[@"nTotalprice"] floatValue]/100];
        
        //判断是否全部使用水票支付
        if ([self.dataSource[@"nFactPrice"] integerValue] == 0 && ticketNum != 0) {
            
            self.isTicketPayOff = YES;
        }
        [self.mainTableView reloadData];
        
    }else{
        
        [MBProgressHUDManager showTextHUDAddedTo:self.view WithText:responseObj[@"result"] afterDelay:1.0f];
    }
}



#pragma mark Target

- (void)settlementClick{
    
    if (self.isTicketPayOff) {
        WeakSelf(weakSelf);
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否使用水票支付？" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [self setPayNstateHttpRequest];
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            return ;
        }]];
        
        [weakSelf presentViewController:alertController animated:YES completion:nil];
        
    }else{
        PaymentViewController *payMent = [PaymentViewController new];
        payMent.factTotalPrice = [self.dataSource[@"nFactPrice"] floatValue];
        payMent.orderId = self.orderId;
        payMent.orderModel = self.model;
        payMent.nOrderType = @"0";
        
        [self.navigationController pushViewController:payMent animated:YES];
    }
    
}


- (void)foreAction{
    
    WeakSelf(weakSelf);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否放弃付款？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        return ;
    }]];
    
    [weakSelf presentViewController:alertController animated:YES completion:nil];
    
}





#pragma mark TableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 9;
        return 7 + [self.dataSource[@"orderGoods"] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"UITableViewCell";
    OrderDetailListCell *cell = [[OrderDetailListCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    
    NSInteger dCount = [self.dataSource[@"orderGoods"] count];
    if (indexPath.row == 0) {
        
        cell.left_label.text = @"收货信息:";
    }
    if (indexPath.row == 1) {
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setLeftView:nil RightView:nil others:self.addressView];
    }
    if (indexPath.row == 2) {
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setLeftView:nil RightView:nil others:self.headerView];
    }
    if (indexPath.row > 2 && indexPath.row < dCount +3) {
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setLeftView:nil RightView:nil others:[self createProCell:indexPath]];
        
    }
    if (indexPath.row == dCount +3) {
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setLeftView:nil RightView:nil others:self.proBottomView];
    }

    if (indexPath.row == dCount +4) {
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.left_label.text = @"使用水票";
        [cell setLeftView:nil RightView:self.oWTicket others:nil];
    }
    if (indexPath.row == dCount +5) {
        
        NSString *testStr = [NSString stringWithFormat:@"优惠（-￥%ld）",self.dataSource[@"nCouponPrice"] ? [self.dataSource[@"nCouponPrice"] integerValue]/100 : 0];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:testStr];
        [str addAttribute:NSForegroundColorAttributeName value:UIColorFromRGBA(0xFA6650, 1.0) range:NSMakeRange(3,testStr.length - 4)];
        cell.left_label.attributedText = str;
        [cell setLeftView:nil RightView:[UILabel new] others:nil];
    }
    if (indexPath.row == dCount +6) {
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSString *testStr = [NSString stringWithFormat:@"共￥%.2f",[self.dataSource[@"nFactPrice"] floatValue]/100];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:testStr];
        [str addAttributes:@{NSForegroundColorAttributeName:UIColorFromRGBA(0xFA6650, 1.0),NSFontAttributeName:kFont(9)} range:NSMakeRange(1,testStr.length - 1)];
        cell.left_label.attributedText = str;
        [cell setLeftView:nil RightView:[UILabel new] others:nil];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"%ld",indexPath.row);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        
        return 25*kScale;
    }
    if (indexPath.row == 2) {
        
        return 30*kScale;
    }
    if (indexPath.row > 1 && indexPath.row < [self.dataSource[@"orderGoods"] count] +3) {
        
        return 30 *kScale;
    }
    
    if (indexPath.row == [self.dataSource[@"orderGoods"] count] + 3) {
        
        return 25 *kScale;
    }
    
    return 20*kScale;
}



@end
