//
//  ShoppingCartController.m
//  Outsourcing
//
//  Created by 李文华 on 2017/8/31.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "ShoppingCartController.h"
#import "EliveApplication.h"
#import "MJExtension.h"
#import "MBProgressHUDManager.h"


#import "ShoppingChartCell.h"
#import "ShoppingBottomView.h"
#import "ShoppingChartModel.h"
#import "OrderCreateController.h"
#import "NoResultView.h"


@interface ShoppingCartController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic ,strong)UITableView *mainTableView;
@property (nonatomic ,strong)NSMutableArray *dataSource;

@property (nonatomic ,strong)ShoppingBottomView *bottomView;

@property (nonatomic ,assign)NSInteger totalPrice;
//
@property (nonatomic ,strong)NSMutableArray *submitDataSource;

@property (nonatomic ,strong)NoResultView *noDataSource;

@end

@implementation ShoppingCartController

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];

    if (![UserTools getUserId]) {
        
        self.noDataSource.hidden = NO;
    }else{
    
        if (self.submitDataSource) {
            
            [self.submitDataSource removeAllObjects];
        }
        [self sendHttpRequest];
    }
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"购物车";
    
    [self.view addSubview:self.mainTableView];
    
    [self.view addSubview:self.bottomView];
    
    [self.view addSubview:self.noDataSource];
    // Do any additional setup after loading the view.
}


#pragma mark Setter && Getter

-(UITableView *)mainTableView{

    if (!_mainTableView) {
        
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopBarHeight, kWidth, kHeight - kTopBarHeight - kTabBarHeight - 40) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.tableFooterView = [UIView new];
    }

    return _mainTableView;
}

-(NSMutableArray *)dataSource{

    if (!_dataSource) {
        
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

-(NSMutableArray *)submitDataSource{
    
    if (!_submitDataSource) {
        
        _submitDataSource = [NSMutableArray new];
    }
    return _submitDataSource;
}
- (ShoppingBottomView *)botsfstomView{
    
    if (!_bottomView) {
        
        _bottomView = [[NSBundle mainBundle] loadNibNamed:@"ShoppingBottomView" owner:nil options:nil].lastObject;
        _bottomView.frame = CGRectMake(0, kHeight - kTopBarHeight - 40, kWidth, 40);
        [_bottomView.allSelectButton addTarget:self action:@selector(allSelectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_bottomView.submitButton addTarget:self action:@selector(submitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomView;
}
- (ShoppingBottomView *)bottomView{

    if (!_bottomView) {
        
        _bottomView = [[NSBundle mainBundle] loadNibNamed:@"ShoppingBottomView" owner:nil options:nil].lastObject;
        _bottomView.frame = CGRectMake(0, kHeight - kTopBarHeight - 40, kWidth, 40);
        [_bottomView.allSelectButton addTarget:self action:@selector(allSelectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_bottomView.submitButton addTarget:self action:@selector(submitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomView;
}

-(NoResultView *)noDataSource{

    if (!_noDataSource) {
        
        _noDataSource = [[NoResultView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
        _noDataSource.placeHolder.text = @"暂无商品";
        _noDataSource.hidden = YES;
        
    }
    return _noDataSource;
}

#pragma mark NetWorks

- (void)sendHttpRequest{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[kCurrentController] = self;
    parameters[@"lUserId"] = [UserTools getUserId];
    
    [OutsourceNetWork onHttpCode:kUserGetChartListNetWork WithParameters:parameters];

}

- (void)submitSendHttp{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[kCurrentController] = self;
    parameters[@"lBuyerid"] = [UserTools getUserId];
    parameters[@"strBuyername"] = @"姓名";
    parameters[@"nTotalprice"] = [NSString stringWithFormat:@"%ld",self.totalPrice];
    parameters[@"orderGoods"] = self.submitDataSource;
    parameters[@"nAddOrderType"] = @"1";
    
    [OutsourceNetWork onHttpCode:kSubmitOrderNetWork WithParameters:parameters];
}

- (void)deleteSendHttp:(NSString *)chartId{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[kCurrentController] = self;
    parameters[@"lId"] = chartId;
    
    [OutsourceNetWork onHttpCode:kUserDeleteFromChartNetWork WithParameters:parameters];
}

- (void)getShoppingDetail:(id)responsObject{

    if ([responsObject[@"resCode"] isEqualToString:@"0"]) {
        
        self.noDataSource.hidden = YES;
        if ([[responsObject[@"result"] allKeys] containsObject:@"dataList"]) {
            
            self.dataSource = [NSMutableArray arrayWithArray:responsObject[@"result"][@"dataList"]];
            
            [self dealTheTotalPrice];
            [self.mainTableView reloadData];
        }
        
    }else{
    
        self.noDataSource.hidden = NO;
//        [MBProgressHUDManager showTextHUDAddedTo:self.view WithText:responsObject[@"result"] afterDelay:1.0f];
    }
    
    NSLog(@"%@",responsObject);

}


- (void)deleteProductionResult:(id)responstObject{

    [self sendHttpRequest];
    NSLog(@"%@",responstObject);
}

- (void)resultOfSubmitOrder:(id)responstObject{

    [MBProgressHUDManager hideHUDForView:self.view];
    
    if ([responstObject[@"resCode"] isEqualToString:@"0"]) {
        
        OrderCreateController *create = [OrderCreateController new];
        create.orderId = responstObject[@"result"];
        
        [self.navigationController pushViewController:create animated:YES];
        
    }else{
        
        [MBProgressHUDManager showTextHUDAddedTo:self.view WithText:responstObject[@"result"] afterDelay:1.0f];
    }
    
    NSLog(@"%@",responstObject);
}

- (void)ssresultOfSubmitOrder:(id)responstObject{
    
    [MBProgressHUDManager hideHUDForView:self.view];
    
    if ([responstObject[@"resCode"] isEqualToString:@"0"]) {
        
        OrderCreateController *create = [OrderCreateController new];
        create.orderId = responstObject[@"result"];
        
        [self.navigationController pushViewController:create animated:YES];
        
    }else{
        
        [MBProgressHUDManager showTextHUDAddedTo:self.view WithText:responstObject[@"result"] afterDelay:1.0f];
    }
    
    NSLog(@"%@",responstObject);
}



- (void)dealTheTotalPrice{

    self.totalPrice = 0;
    NSArray *temArr = [NSArray arrayWithArray:self.submitDataSource];
    for (NSDictionary *temp in temArr) {
        
        NSInteger price = [temp[@"nPrice"] integerValue];
        
        NSInteger nCount = [temp[@"nCount"] integerValue];
        
        self.totalPrice += price * nCount;
    }
    self.bottomView.totalPrice.text = [NSString stringWithFormat:@"%.2f",self.totalPrice > 0 ? (float)self.totalPrice/100 : 0.00];
}



#pragma mark ClickMethod

- (void)substractButtonClick:(UIButton *)sender{
    
    [self dealDataScoutceIndex:sender.tag Add:NO];
}

- (void)addButtonClick:(UIButton *)sender{

    [self dealDataScoutceIndex:sender.tag Add:YES];
}

- (void)selectButtonClick:(UIButton *)sender{

    sender.selected = !sender.selected;
    //确定是否已经有此条数据
    BOOL has = NO;
    //直接操作数组会报错
    NSDictionary *dArr = self.dataSource[sender.tag];
    NSArray *tempArr = [NSArray arrayWithArray:self.submitDataSource];
    for (NSDictionary *temp in tempArr) {
        
        if ([[temp[@"lGoodsid"] stringValue] isEqualToString:[dArr[@"lGoodsId"] stringValue]]) {
            
            has = YES;
            if (!sender.selected && has) {//如果已经存在，切取消选中，删除此条数据
                
                [self.submitDataSource removeObject:temp];
            }
        }
    }
    if (sender.selected && !has) {//选中，且没有此条数据，添加此条数据
        //转换成提交订单的数据
        NSMutableDictionary *sub = [NSMutableDictionary new];
        sub[@"lGoodsid"] = dArr[@"lGoodsId"];
        sub[@"strGoodsname"] = dArr[@"strGoodsname"];
        sub[@"nPrice"] = dArr[@"nPrice"];
        sub[@"nGoodsTotalPrice"] = dArr[@"nPrice"];
        sub[@"nCount"] = dArr[@"nGoodsCount"];
        sub[@"strGoodsimgurl"] = @"url";
        
        [self.submitDataSource addObject:sub];
    }
    [self dealTheTotalPrice];

}
- (void)selectBddduttonClick:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    //确定是否已经有此条数据
    BOOL has = NO;
    //直接操作数组会报错
    NSDictionary *dArr = self.dataSource[sender.tag];
    NSArray *tempArr = [NSArray arrayWithArray:self.submitDataSource];
    for (NSDictionary *temp in tempArr) {
        
        if ([[temp[@"lGoodsid"] stringValue] isEqualToString:[dArr[@"lGoodsId"] stringValue]]) {
            
            has = YES;
            if (!sender.selected && has) {//如果已经存在，切取消选中，删除此条数据
                
                [self.submitDataSource removeObject:temp];
            }
        }
    }
    if (sender.selected && !has) {//选中，且没有此条数据，添加此条数据
        //转换成提交订单的数据
        NSMutableDictionary *sub = [NSMutableDictionary new];
        sub[@"lGoodsid"] = dArr[@"lGoodsId"];
        sub[@"strGoodsname"] = dArr[@"strGoodsname"];
        sub[@"nPrice"] = dArr[@"nPrice"];
        sub[@"nGoodsTotalPrice"] = dArr[@"nPrice"];
        sub[@"nCount"] = dArr[@"nGoodsCount"];
        sub[@"strGoodsimgurl"] = @"url";
        
        [self.submitDataSource addObject:sub];
    }
    [self dealTheTotalPrice];
    
}
- (void)deleteButtonClick:(UIButton *)sender{

    WeakSelf(weakSelf);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确认删除此商品？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        NSDictionary *dict = self.dataSource[sender.tag];
        
        if (dict) {
            
            [weakSelf deleteSendHttp:dict[@"lId"]];
        }
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        return ;
    }]];
    
    [weakSelf presentViewController:alertController animated:YES completion:nil];
}

- (void)allSelecddddtButtonClick:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        
        NSMutableArray *muArr = [NSMutableArray new];
        for (NSDictionary *temp in self.dataSource) {
            //转换成提交订单的数据
            NSMutableDictionary *sub = [NSMutableDictionary new];
            sub[@"lGoodsid"] = temp[@"lGoodsId"];
            sub[@"strGoodsname"] = temp[@"strGoodsname"];
            sub[@"nPrice"] = temp[@"nPrice"];
            sub[@"nGoodsTotalPrice"] = temp[@"nPrice"];
            sub[@"nCount"] = temp[@"nGoodsCount"];
            sub[@"strGoodsimgurl"] = @"url";
            
            [muArr addObject:sub];
        }
        self.submitDataSource = muArr;
    }else{
        
        if (self.submitDataSource) {
            
            [self.submitDataSource removeAllObjects];
        }
        
    }
    [self dealTheTotalPrice];
    
    [self.mainTableView reloadData];
}
- (void)allSelectButtonClick:(UIButton *)sender{

    sender.selected = !sender.selected;
    
    if (sender.selected) {
        
        NSMutableArray *muArr = [NSMutableArray new];
        for (NSDictionary *temp in self.dataSource) {
            //转换成提交订单的数据
            NSMutableDictionary *sub = [NSMutableDictionary new];
            sub[@"lGoodsid"] = temp[@"lGoodsId"];
            sub[@"strGoodsname"] = temp[@"strGoodsname"];
            sub[@"nPrice"] = temp[@"nPrice"];
            sub[@"nGoodsTotalPrice"] = temp[@"nPrice"];
            sub[@"nCount"] = temp[@"nGoodsCount"];
            sub[@"strGoodsimgurl"] = @"url";

            [muArr addObject:sub];
        }
        self.submitDataSource = muArr;
    }else{
    
        if (self.submitDataSource) {
            
            [self.submitDataSource removeAllObjects];
        }

    }
    [self dealTheTotalPrice];
    
    [self.mainTableView reloadData];
}

- (void)submitButtonClick:(UIButton *)sender{

    [self submitSendHttp];
}

//增加，减少产品数量
- (void)dealDataScoutceIndex:(NSInteger)index Add:(BOOL)isAdd{
    //找到数据源，修改数据源
    NSMutableArray *mutableTemp = self.dataSource;
    NSMutableDictionary *temp = [NSMutableDictionary dictionaryWithDictionary:mutableTemp[index]];
    NSInteger nCount = [temp[@"nGoodsCount"] integerValue];
    if (isAdd) {
        
        nCount ++;
    }else{
        if (nCount != 1) {
            
            nCount --;
        }
    }
    temp[@"nGoodsCount"] = [NSString stringWithFormat:@"%ld",nCount];
    
    //替换原来数据源
    [mutableTemp replaceObjectAtIndex:index withObject:temp];
    
    //重新给定数据源
    self.dataSource = mutableTemp;
    
    //查找是否已经选中此条数据，选中，修改数量
    NSDictionary *dArr = self.dataSource[index];
    NSArray *tempArr = [NSArray arrayWithArray:self.submitDataSource];
    for (NSDictionary *tem in tempArr) {
        
        if ([[tem[@"lGoodsid"] stringValue] isEqualToString:[dArr[@"lGoodsId"] stringValue]]) {
            
            NSMutableDictionary *mTemp = [NSMutableDictionary dictionaryWithDictionary:tem];
            
            [self.submitDataSource removeObject:tem];
            
            mTemp[@"nCount"] = temp[@"nGoodsCount"];
            
            [self.submitDataSource addObject:mTemp];
        }
    }
    
    [self dealTheTotalPrice];
    
    [self.mainTableView reloadData];
}


#pragma mark TableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataSource.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"UITableViewCell";
    ShoppingChartCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ShoppingChartCell" owner:nil options:nil].lastObject ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    cell.substractButton.tag = indexPath.row;
    cell.addButton.tag = indexPath.row;
    cell.selectButton.tag = indexPath.row;
    cell.deleteButton.tag = indexPath.row;
    
    BOOL has = NO;
    if (self.submitDataSource) {
        
        NSDictionary *tem = self.dataSource[indexPath.row];
        
        NSArray *temArr = [NSArray arrayWithArray:self.submitDataSource];
        
        for (NSDictionary *dict in temArr) {

            if ([[dict[@"lGoodsid"] stringValue] isEqualToString:[tem[@"lGoodsId"] stringValue]]) {
                
                has = YES;
            }
        }
    }
    
    if (self.bottomView.allSelectButton.selected || has) {
        
        cell.selectButton.selected = YES;
    }
    [cell.substractButton addTarget:self action:@selector(substractButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.selectButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    ShoppingChartModel *model = [ShoppingChartModel mj_objectWithKeyValues:self.dataSource[indexPath.row]];
    
    [cell fitDataWithModel:model];
    
    return cell;
}
-(UITableViewCell *)tabslsseView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"UITableViewCell";
    ShoppingChartCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ShoppingChartCell" owner:nil options:nil].lastObject ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.substractButton.tag = indexPath.row;
    cell.addButton.tag = indexPath.row;
    cell.selectButton.tag = indexPath.row;
    cell.deleteButton.tag = indexPath.row;
    
    BOOL has = NO;
    if (self.submitDataSource) {
        
        NSDictionary *tem = self.dataSource[indexPath.row];
        
        NSArray *temArr = [NSArray arrayWithArray:self.submitDataSource];
        
        for (NSDictionary *dict in temArr) {
            
            if ([[dict[@"lGoodsid"] stringValue] isEqualToString:[tem[@"lGoodsId"] stringValue]]) {
                
                has = YES;
            }
        }
    }
    
    if (self.bottomView.allSelectButton.selected || has) {
        
        cell.selectButton.selected = YES;
    }
    [cell.substractButton addTarget:self action:@selector(substractButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.selectButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    ShoppingChartModel *model = [ShoppingChartModel mj_objectWithKeyValues:self.dataSource[indexPath.row]];
    
    [cell fitDataWithModel:model];
    
    return cell;
}
-(UITableViewCell *)tablsseView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"UITableViewCell";
    ShoppingChartCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ShoppingChartCell" owner:nil options:nil].lastObject ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.substractButton.tag = indexPath.row;
    cell.addButton.tag = indexPath.row;
    cell.selectButton.tag = indexPath.row;
    cell.deleteButton.tag = indexPath.row;
    
    BOOL has = NO;
    if (self.submitDataSource) {
        
        NSDictionary *tem = self.dataSource[indexPath.row];
        
        NSArray *temArr = [NSArray arrayWithArray:self.submitDataSource];
        
        for (NSDictionary *dict in temArr) {
            
            if ([[dict[@"lGoodsid"] stringValue] isEqualToString:[tem[@"lGoodsId"] stringValue]]) {
                
                has = YES;
            }
        }
    }
    
    if (self.bottomView.allSelectButton.selected || has) {
        
        cell.selectButton.selected = YES;
    }
    [cell.substractButton addTarget:self action:@selector(substractButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.selectButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    ShoppingChartModel *model = [ShoppingChartModel mj_objectWithKeyValues:self.dataSource[indexPath.row]];
    
    [cell fitDataWithModel:model];
    
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
