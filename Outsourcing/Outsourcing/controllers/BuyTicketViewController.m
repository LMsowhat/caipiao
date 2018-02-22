//
//  BuyTicketViewController.m
//  Outsourcing
//
//  Created by 李文华 on 2017/8/11.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "BuyTicketViewController.h"
#import "Masonry.h"
#import "EliveApplication.h"
#import "MJExtension.h"
#import "MBProgressHUDManager.h"
#import <SDWebImage/UIImageView+WebCache.h>

#import "TicketModel.h"
#import "TicketContentsCell.h"
#import "CouponsViewController.h"
#import "PaymentViewController.h"

@interface BuyTicketViewController ()<UITableViewDelegate ,UITableViewDataSource>

@property (nonatomic ,strong)UITableView *mainTableView;
@property (nonatomic ,strong)NSMutableArray *dataSource;

@property (nonatomic ,strong)UIButton *settlementBtn;

@property (nonatomic ,strong)TicketModel *tModel;

@property (nonatomic ,strong)UILabel *couponLabel;
@property (nonatomic ,copy)NSDictionary *couponDict;

@property (nonatomic ,strong)UILabel *totalLabel;
@property (nonatomic ,copy)NSString *totalPrice;


@property (nonatomic ,strong)UIButton *selectTagButton;


@end

@implementation BuyTicketViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.navigationItem.title = @"购买水票";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 22, 17);
    [btn setImage:[UIImage imageNamed:@"naviBack"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(foreAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self sendHttpRequest];
    
    [self.view addSubview:self.mainTableView];
    
    [self.view addSubview:self.settlementBtn];
    
    // Do any additional setup after loading the view.
}

#pragma mark Private Method

- (UIView *)createHeaderView{

    UIView *header = [UIView new];
    header.frame = CGRectMake(0, 0, kWidth, 131*kScale);
    header.backgroundColor = UIColorFromRGBA(0xF7F7F7, 1.0);
    
    UIImageView *productionIcon = [UIImageView new];
    [productionIcon sd_setImageWithURL:kGetImageUrl(URLHOST, @"0", self.tModel.lGoodsid) placeholderImage:[UIImage imageNamed:@"icon_outsouring_default.jpg"]];
    
    UIView *titleView = [UIView new];
    titleView.backgroundColor = UIColorFromRGBA(0xFFFFFF, 1.0);
    
    UILabel *title = [UILabel new];
    title.font = kFont(7);
    title.textColor = UIColorFromRGBA(0x333338, 1.0);
    title.text = self.tModel.strGoodsName;
    
    UILabel *price = [UILabel new];
    price.font = kFont(9);
    price.textColor = UIColorFromRGBA(0x333338, 1.0);
    price.text = [NSString stringWithFormat:@"￥%.2f",[self.tModel.nPrice floatValue]/100];
    price.textAlignment = NSTextAlignmentRight;

    [titleView addSubview:title];
    [titleView addSubview:price];
    [header addSubview:productionIcon];
    [header addSubview:titleView];
    
    [productionIcon makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.equalTo(CGSizeMake(kWidth, 94 *kScale));
        
        make.centerX.equalTo(header);
        
        make.top.equalTo(header);
    }];
    
    [titleView makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.equalTo(CGSizeMake(kWidth, 32 *kScale));
        
        make.centerX.equalTo(productionIcon);
        
        make.top.equalTo(productionIcon.mas_bottom);
    }];
    
    [title makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(titleView);
        
        make.left.equalTo(titleView).offset(10 *kScale);
    }];
    
    [price makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(titleView);
        
        make.right.equalTo(titleView).offset(-10 *kScale);
    }];
    
    return header;
}

- (UIView *)createFooterView{
    
    UIView *footer = [UIView new];
    footer.frame = CGRectMake(0, 0, kWidth, 60*kScale);

    self.couponLabel = [UILabel new];
    self.couponLabel.font = kFont(7);
    self.couponLabel.textColor = UIColorFromRGBA(0x002A20, 1.0);
    
    NSString *testStr = @"优惠：-¥0.00";
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:testStr];
    [str addAttributes:@{NSForegroundColorAttributeName:UIColorFromRGBA(0xFA6650, 1.0),NSFontAttributeName:kFont(7)} range:NSMakeRange(3,testStr.length - 3)];
    self.couponLabel.attributedText = str;
    
    self.totalLabel = [UILabel new];
    self.totalLabel.font = kFont(7);
    self.totalLabel.textColor = UIColorFromRGBA(0x333338, 1.0);
    
    NSString *testStr1 = [NSString stringWithFormat:@"共：¥%.2f",self.totalPrice ? [self.totalPrice floatValue]/100 : 0];
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:testStr1];
    [str1 addAttributes:@{NSForegroundColorAttributeName:UIColorFromRGBA(0xFA6650, 1.0),NSFontAttributeName:kFont(9)} range:NSMakeRange(2,testStr1.length - 2)];
    self.totalLabel.attributedText = str1;
    
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"more"];
    
    UIButton *selectCoupon = [UIButton buttonWithType:UIButtonTypeCustom];
    selectCoupon.backgroundColor = kClearColor;
    [selectCoupon setTitle:@"" forState:UIControlStateNormal];
    [selectCoupon addTarget:self action:@selector(selectCouponClick) forControlEvents:UIControlEventTouchUpInside];
    
    [footer addSubview:self.couponLabel];
    [footer addSubview:self.totalLabel];
    [footer addSubview:imageView];
    [footer addSubview:selectCoupon];
    
    [self.couponLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.equalTo(footer).offset(10 *kScale);
    }];

    [imageView makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.couponLabel);
        
        make.right.equalTo(footer).offset(-10 *kScale);
    }];
    
    [selectCoupon makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@(kWidth));
        
        make.centerY.equalTo(self.couponLabel);
        
        make.top.bottom.equalTo(self.couponLabel);
    }];
    
    [self.totalLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.couponLabel.mas_bottom).offset(10 *kScale);
        
        make.left.equalTo(footer).offset(10 *kScale);
    }];
    
    return footer;
}

- (void)selectCouponClick{

    CouponsViewController *coupon = [CouponsViewController new];
    coupon.isSelectedCoupons = YES;
    coupon.nFullPrice = self.totalPrice;
    coupon.passCoupons = ^(NSDictionary *couponDict) {
        //处理优惠券
        self.couponDict = couponDict;
        NSString *testStr = [NSString stringWithFormat:@"优惠：-¥%.2f",self.couponDict ? [self.couponDict[@"nPrice"] floatValue]/100 : 0];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:testStr];
        [str addAttributes:@{NSForegroundColorAttributeName:UIColorFromRGBA(0xFA6650, 1.0),NSFontAttributeName:kFont(7)} range:NSMakeRange(3,testStr.length - 3)];
        self.couponLabel.attributedText = str;
        
        //处理订单总价
        NSInteger total = [self.totalPrice integerValue] - [self.couponDict[@"nPrice"] integerValue];
        self.totalPrice = [NSString stringWithFormat:@"%ld",total > 0 ? total : 0];
        NSString *testStr1 = [NSString stringWithFormat:@"共：¥%.2f",self.totalPrice ? [self.totalPrice floatValue]/100 : 0];
        NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:testStr1];
        [str1 addAttributes:@{NSForegroundColorAttributeName:UIColorFromRGBA(0xFA6650, 1.0),NSFontAttributeName:kFont(9)} range:NSMakeRange(2,testStr1.length - 2)];
        self.totalLabel.attributedText = str1;
    };
    [self.navigationController pushViewController:coupon animated:YES];
    NSLog(@"ddfsafasfa");
}

- (void)selectClik:(UIButton *)sender{

    sender.selected = !sender.selected;

    //处理选中记录
    if (self.selectTagButton && self.settlementBtn.selected == YES) {
        
        self.selectTagButton.selected = NO;
    }
    self.selectTagButton = sender;
    
    //处理UI
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    
    TicketContentsCell *cell = [self.mainTableView cellForRowAtIndexPath:indexPath];
    

    if (sender.selected) {
        
        cell.cPrice.textColor = UIColorFromRGBA(0xFA6650, 1.0);
    }else{

        cell.cPrice.textColor = UIColorFromRGBA(0x333338, 1.0);
    }

    //处理数据
    
    NSInteger selectPrice = [self.dataSource[sender.tag][@"nPrice"] integerValue];
    
    NSInteger total = [self.totalPrice integerValue];
    
    self.totalPrice = [NSString stringWithFormat:@"%ld",sender.selected ? (total + selectPrice) : (total - selectPrice)];
    
    NSString *testStr1 = [NSString stringWithFormat:@"共：¥%.2f",self.totalPrice ? [self.totalPrice floatValue]/100 : 0];
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:testStr1];
    [str1 addAttributes:@{NSForegroundColorAttributeName:UIColorFromRGBA(0xFA6650, 1.0),NSFontAttributeName:kFont(9)} range:NSMakeRange(2,testStr1.length - 2)];
    self.totalLabel.attributedText = str1;
    
}



- (void)settlementClick{
    
    if ([UserTools getUserId]) {
        
        NSMutableDictionary *parametes = [NSMutableDictionary new];
        parametes[kCurrentController] = self;
        parametes[@"lUserid"] = [UserTools getUserId];//用户id
        parametes[@"lTicketConId"] = self.dataSource[self.selectTagButton.tag][@"lId"];//水票id
        parametes[@"nFactPrice"] = self.totalPrice;//实际支付价格
        parametes[@"nCount"] = self.dataSource[self.selectTagButton.tag][@"nCount"];//水票数量
        parametes[@"lMyCouponId"] = self.couponDict[@"lLd"];//优惠券id
        
        [OutsourceNetWork onHttpCode:kProductionTicketPayNetWork WithParameters:parametes];
        
    }else{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NEEDLOGIN object:nil];
    }
    
}

- (void)foreAction{

    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark NetWorks

- (void)sendHttpRequest{
    
    //获取水票详情
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[kCurrentController] = self;
    parameters[@"lTicketId"] = self.ticketId;
    
    [OutsourceNetWork onHttpCode:kProductionTicketDetailNetWork WithParameters:parameters];
    
    [MBProgressHUDManager showHUDAddedTo:self.view];
}

- (void)getTicketDetail:(id)responseObj{

    [MBProgressHUDManager hideHUDForView:self.view];

    if ([responseObj[@"resCode"] isEqualToString:@"0"]) {
        
        self.tModel = [TicketModel mj_objectWithKeyValues:responseObj[@"result"]];
        
        self.dataSource = responseObj[@"result"][@"ticketcontents"];
        
        UIView *headerView = [self createHeaderView];
        
        UIView *footerView = [self createFooterView];
        
        self.mainTableView.tableHeaderView = headerView;
        self.mainTableView.tableFooterView = footerView;
        
        [self.mainTableView reloadData];
        NSLog(@"%@",responseObj);
    }
    
}

- (void)payForTicketResult:(id)responseObject{

    if (responseObject[@"resCode"]) {
        
        PaymentViewController *pay = [PaymentViewController new];
        pay.orderId = responseObject[@"result"];
        pay.nOrderType = @"1";
        pay.factTotalPrice = [self.totalPrice floatValue];
        
        [self.navigationController pushViewController:pay animated:YES];
        
    }else{
    
        [MBProgressHUDManager showTextHUDAddedTo:self.view WithText:responseObject[@"result"] afterDelay:1.0f];
    }
    NSLog(@"%@",responseObject);
}

#pragma mark Setter && Getter

-(UITableView *)mainTableView{

    if (!_mainTableView) {
        
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopBarHeight, kWidth, kHeight - kTopBarHeight -24.5 *kScale) style:UITableViewStylePlain];
        
        _mainTableView.delegate = self;
        
        _mainTableView.dataSource = self;
        
    }

    return _mainTableView;
}

-(UIButton *)settlementBtn{

    if (!_settlementBtn) {
        
        _settlementBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _settlementBtn.frame = CGRectMake(0, kHeight - 24.5*kScale, kWidth, 24.5*kScale);
        [_settlementBtn.titleLabel setFont:kFont(7)];
        [_settlementBtn setTitle:@"去结算" forState:UIControlStateNormal];
        [_settlementBtn setTitleColor:UIColorFromRGBA(0xFFFFFF, 1.0) forState:UIControlStateNormal];
        _settlementBtn.backgroundColor = UIColorFromRGBA(0xFA6650, 1.0);
        [_settlementBtn addTarget:self action:@selector(settlementClick) forControlEvents:UIControlEventTouchUpInside];
        
    }

    return _settlementBtn;
}


#pragma mark TableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"TicketDetailTableViewCell";
    TicketContentsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil)
    {
        cell = [[TicketContentsCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    ContentTicketModel *model = [ContentTicketModel mj_objectWithKeyValues:self.dataSource[indexPath.row]];
    
    [cell fitDataWithModel:model];
    
    cell.selectBtn.tag = indexPath.row;
    [cell.selectBtn addTarget:self action:@selector(selectClik:) forControlEvents:UIControlEventTouchUpInside];
    
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
