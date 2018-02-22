//
//  HomeViewController.m
//  Outsourcing
//
//  Created by 李文华 on 2017/6/14.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "HomeViewController.h"
#import "SDCycleScrollView.h"
#import "EliveApplication.h"
#import "MJExtension.h"
#import "MJRefresh.h"

#import "ProductionCollectionViewCell.h"
#import "ProductionModel.h"
#import "HeaderCycleScrollView.h"
#import "ProductionDetailViewController.h"
#import "MBProgressHUDManager.h"
#import "ActivityViewController.h"


#define headerHeight 180
@interface HomeViewController ()
<UIScrollViewDelegate,
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
SDCycleScrollViewDelegate,
UIGestureRecognizerDelegate
>

@property (nonatomic ,strong)UICollectionView *mainCollection;
@property (nonatomic ,strong)NSMutableArray *dataSource;
@property (nonatomic ,strong)SDCycleScrollView *headerSDCycle;
@property (nonatomic ,strong)NSMutableArray *cycSource;


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self sendHttpRequest];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"首页";
}

#pragma mark - Initial Methods

/** 视图初始化 */
- (void)setupUI {
    
    [self.view addSubview:self.headerSDCycle];
    [self.view addSubview:self.mainCollection];
    
}

/** 加载数据 */
- (void)sendHttpRequest {
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    parameters[kCurrentController] = self;
    parameters[@"nPage"] = [NSString stringWithFormat:@"%ld",self.currentPage ? self.currentPage : 1];
    parameters[@"nMaxNum"] = @"6";
    
    [OutsourceNetWork onHttpCode:kHomePageProductionListNetWork WithParameters:parameters];
    
    if (!self.currentPage || self.currentPage == 1) {
        
        [OutsourceNetWork onHttpCode:kHomePageCirclesNetWork WithParameters:parameters];
    }
    
}
#pragma mark - Setter & Getter
static NSString *kcellIdentifier = @"collectionCellID";
static NSString *kheaderIdentifier = @"headerIdentifier";
-(UICollectionView *)mainCollection{

    if (!_mainCollection) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 5;
        layout.minimumLineSpacing = 5;
        
        _mainCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kTopBarHeight, kWidth, kHeight - kTabBarHeight - kTopBarHeight) collectionViewLayout:layout];
        _mainCollection.backgroundColor = kWhiteColor;
        _mainCollection.delegate = self;
        _mainCollection.dataSource = self;
//        _mainCollection.showsVerticalScrollIndicator = NO;
        _mainCollection.showsHorizontalScrollIndicator = NO;
        
        _mainCollection.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
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
        
        _mainCollection.mj_footer = footer;
        
        //注册Cell
        [_mainCollection registerClass:[ProductionCollectionViewCell class] forCellWithReuseIdentifier:kcellIdentifier];
        //注册Header
        [_mainCollection registerClass:[HeaderCycleScrollView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier];
        
    }

    return _mainCollection;
}
-(UICollectionView *)mainCosfsfsllection{
    
    if (!_mainCollection) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 5;
        layout.minimumLineSpacing = 5;
        
        _mainCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kTopBarHeight, kWidth, kHeight - kTabBarHeight - kTopBarHeight) collectionViewLayout:layout];
        _mainCollection.backgroundColor = kWhiteColor;
        _mainCollection.delegate = self;
        _mainCollection.dataSource = self;
        //        _mainCollection.showsVerticalScrollIndicator = NO;
        _mainCollection.showsHorizontalScrollIndicator = NO;
        
        _mainCollection.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
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
        
        _mainCollection.mj_footer = footer;
        
        //注册Cell
        [_mainCollection registerClass:[ProductionCollectionViewCell class] forCellWithReuseIdentifier:kcellIdentifier];
        //注册Header
        [_mainCollection registerClass:[HeaderCycleScrollView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier];
        
    }
    
    return _mainCollection;
}
-(SDCycleScrollView *)headerSDCycle{

    if (!_headerSDCycle) {
        
        _headerSDCycle = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kWidth, headerHeight) delegate:self placeholderImage:[UIImage imageNamed:@"icon_outsouring_default.jpg"]];
        _headerSDCycle.delegate = self;
        _headerSDCycle.autoScrollTimeInterval = 2;
        _headerSDCycle.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;

    }
    return _headerSDCycle;
}
-(UICollectionView *)mainCosfsdf3wewsfsllection{
    
    if (!_mainCollection) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 5;
        layout.minimumLineSpacing = 5;
        
        _mainCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kTopBarHeight, kWidth, kHeight - kTabBarHeight - kTopBarHeight) collectionViewLayout:layout];
        _mainCollection.backgroundColor = kWhiteColor;
        _mainCollection.delegate = self;
        _mainCollection.dataSource = self;
        //        _mainCollection.showsVerticalScrollIndicator = NO;
        _mainCollection.showsHorizontalScrollIndicator = NO;
        
        _mainCollection.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
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
        
        _mainCollection.mj_footer = footer;
        
        //注册Cell
        [_mainCollection registerClass:[ProductionCollectionViewCell class] forCellWithReuseIdentifier:kcellIdentifier];
        //注册Header
        [_mainCollection registerClass:[HeaderCycleScrollView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier];
        
    }
    
    return _mainCollection;
}
-(NSMutableArray *)dataSource{
    
    if (!_dataSource) {
        
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

#pragma mark - NetWork Responses

- (void)circlesGetData:(id)responseObject{

    NSLog(@"%@",responseObject);
    
    if ([responseObject[@"resCode"] isEqualToString:@"0"]) {
        
        
        if (!self.cycSource) {
            
            self.cycSource = [NSMutableArray new];
        }
        self.cycSource = [NSMutableArray arrayWithArray:responseObject[@"result"][@"dataList"]];
        
        if (self.cycSource.count > 0) {
            
            NSMutableArray *images = [NSMutableArray new];
            
            for (NSInteger i = 0; i < self.cycSource.count; i++) {
                
                if (self.cycSource[i][@"lId"]) {
                    
                    NSString *imageUrl = [NSString stringWithFormat:@"%@/common/getImg/1/%@",URLHOST,self.cycSource[i][@"lId"]];
                    
                    [images addObject:imageUrl];
                }
            }
            self.headerSDCycle.imageURLStringsGroup = images;
            [self.mainCollection reloadData];
        }
    }
}
-(UICollectionView *)mainCosfsfsdsdfsdsfsllection{
    
    if (!_mainCollection) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 5;
        layout.minimumLineSpacing = 5;
        
        _mainCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kTopBarHeight, kWidth, kHeight - kTabBarHeight - kTopBarHeight) collectionViewLayout:layout];
        _mainCollection.backgroundColor = kWhiteColor;
        _mainCollection.delegate = self;
        _mainCollection.dataSource = self;
        //        _mainCollection.showsVerticalScrollIndicator = NO;
        _mainCollection.showsHorizontalScrollIndicator = NO;
        
        _mainCollection.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
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
        
        _mainCollection.mj_footer = footer;
        
        //注册Cell
        [_mainCollection registerClass:[ProductionCollectionViewCell class] forCellWithReuseIdentifier:kcellIdentifier];
        //注册Header
        [_mainCollection registerClass:[HeaderCycleScrollView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier];
        
    }
    
    return _mainCollection;
}
- (void)productionListGetData:(id)responseObject{

    [self.mainCollection.mj_header endRefreshing];
    [self.mainCollection.mj_footer endRefreshing];
    //responseObject[@"result"][@"dataList"]
    if ([responseObject[@"resCode"] isEqualToString:@"0"]) {
        
        if ([responseObject[@"result"][@"dataList"] count] < 6) {
            
            [self.mainCollection.mj_footer endRefreshingWithNoMoreData];
        }
        if (!self.currentPage || self.currentPage == 1) {
            
            self.dataSource = [NSMutableArray arrayWithArray:responseObject[@"result"][@"dataList"]];
        }else{
        
            for (NSDictionary *temp in responseObject[@"result"][@"dataList"]) {
                
                [self.dataSource addObject:temp];
            }
        }
    }
    
    [self.mainCollection reloadData];
    NSLog(@"%@",responseObject);

}


#pragma mark - UICollectionView Delegate &Datasource
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    ActivityViewController *activity = [ActivityViewController new];
    activity.navigationItem.title = self.cycSource[index][@"strActivityName"];
    activity.infoDict = self.cycSource[index];
    
    [self.navigationController pushViewController:activity animated:YES];
    //    NSLog(@"index has clicked----%ld",(long)index);
    
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
    //    NSLog(@"index has rolled-----%ld",(long)index);
    
}


#pragma mark- CollectionViewDelegate

//section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.dataSource.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    ProductionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kcellIdentifier forIndexPath:indexPath];
    
    cell.shoppingCart.tag = indexPath.row;
    [cell.shoppingCart addTarget:self action:@selector(addShopCart:) forControlEvents:UIControlEventTouchUpInside];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:self.dataSource[indexPath.row]];
    
    ProductionModel *model = [ProductionModel mj_objectWithKeyValues:dict];
    
    [cell fitDataWith:model];
    
    return cell;
    
}
- (UICollectionViewCell *)collectionViewsdfsafas:(UICollectionView *)collectionView cellForsfasfItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    ProductionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kcellIdentifier forIndexPath:indexPath];
    
    cell.shoppingCart.tag = indexPath.row;
    [cell.shoppingCart addTarget:self action:@selector(addShopCart:) forControlEvents:UIControlEventTouchUpInside];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:self.dataSource[indexPath.row]];
    
    ProductionModel *model = [ProductionModel mj_objectWithKeyValues:dict];
    
    [cell fitDataWith:model];
    
    return cell;
    
}
- (void)addShopCart:(UIButton *)sender{

    if ([UserTools getUserId]) {
        
        NSDictionary *dic = self.dataSource[sender.tag];
        NSMutableDictionary *parameters = [NSMutableDictionary new];
        parameters[kCurrentController] = self;
        parameters[@"strUserName"] = @"李文华";
        parameters[@"lUserId"] = [UserTools getUserId];
        parameters[@"nPrice"] = dic[@"nPrice"];
        parameters[@"lGoodsId"] = dic[@"lId"];
        parameters[@"strGoodsname"] = dic[@"strGoodsname"];
        parameters[@"strGoodsimgurl"] = dic[@"strGoodsimgurl"];
        parameters[@"strStandard"] = dic[@"strStandard"];
        
        [OutsourceNetWork onHttpCode:kAddShopCartNetWork WithParameters:parameters];
    }else{
    
        [[NSNotificationCenter defaultCenter] postNotificationName:NEEDLOGIN object:nil];
    }
    
}

- (void)userAddShopCart:(id)responseObject{

    if ([responseObject[@"resCode"] isEqualToString:@"0"]) {
        
        [MBProgressHUDManager showTextHUDAddedTo:self.view WithText:@"添加购物车成功" afterDelay:1.0f];
    }

}


// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    HeaderCycleScrollView *cycleScrollView = nil;
    if ([kind isEqualToString: UICollectionElementKindSectionHeader]){
        
        cycleScrollView = [collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:kheaderIdentifier   forIndexPath:indexPath];
    
        [collectionView addSubview:self.headerSDCycle];
        
        
    }
    return cycleScrollView;

}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kWidth - 50)/2, 250);
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    NSLog(@"section ==== %ld",section);
    
    return UIEdgeInsetsMake(20, 20, 0, 20);//分别为上、左、下、右
}

//返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(kWidth, 180);
}

//每个section中不同的行之间的行间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    
//    return 20;
//}

//两个cell之间的间距（同一行的cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    ProductionDetailViewController *detail = [ProductionDetailViewController new];
    detail.goodsLid = self.dataSource[indexPath.row][@"lId"];
    
    [self.navigationController pushViewController:detail animated:YES];
    
}
//取消选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
}
#pragma mark TableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1    ;
}


#pragma mark TableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier =@"TableViewCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//-(HomeScrollViewCell *)configCell{
//
//    HomeScrollViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"HomeScrollViewCell" owner:nil options:nil].lastObject;
//    //圆角
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.layerView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = cell.layerView.bounds;
//    maskLayer.path = maskPath.CGPath;
//    cell.layerView.layer.mask = maskLayer;
//    cell.layerView.layer.mask = maskLayer;
//
//    return cell;
//}
//-(HomeScrollViewCell *)configCell{
//
//    HomeScrollViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"HomeScrollViewCell" owner:nil options:nil].lastObject;
//    //圆角
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.layerView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = cell.layerView.bounds;
//    maskLayer.path = maskPath.CGPath;
//    cell.layerView.layer.mask = maskLayer;
//    cell.layerView.layer.mask = maskLayer;
//
//    return cell;
//}
//-(HomeScrollViewCell *)configCell{
//
//    HomeScrollViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"HomeScrollViewCell" owner:nil options:nil].lastObject;
//    //圆角
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.layerView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = cell.layerView.bounds;
//    maskLayer.path = maskPath.CGPath;
//    cell.layerView.layer.mask = maskLayer;
//    cell.layerView.layer.mask = maskLayer;
//
//    return cell;
//}
//-(HomeScrollViewCell *)configCell{
//
//    HomeScrollViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"HomeScrollViewCell" owner:nil options:nil].lastObject;
//    //圆角
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.layerView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = cell.layerView.bounds;
//    maskLayer.path = maskPath.CGPath;
//    cell.layerView.layer.mask = maskLayer;
//    cell.layerView.layer.mask = maskLayer;
//
//    return cell;
//}
//-(HomeScrollViewCell *)configCell{
//
//    HomeScrollViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"HomeScrollViewCell" owner:nil options:nil].lastObject;
//    //圆角
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.layerView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = cell.layerView.bounds;
//    maskLayer.path = maskPath.CGPath;
//    cell.layerView.layer.mask = maskLayer;
//    cell.layerView.layer.mask = maskLayer;
//
//    return cell;
//}
//-(HomeScrollViewCell *)configCell{
//
//    HomeScrollViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"HomeScrollViewCell" owner:nil options:nil].lastObject;
//    //圆角
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.layerView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = cell.layerView.bounds;
//    maskLayer.path = maskPath.CGPath;
//    cell.layerView.layer.mask = maskLayer;
//    cell.layerView.layer.mask = maskLayer;
//
//    return cell;
//}
//-(HomeScrollViewCell *)configCell{
//
//    HomeScrollViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"HomeScrollViewCell" owner:nil options:nil].lastObject;
//    //圆角
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.layerView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = cell.layerView.bounds;
//    maskLayer.path = maskPath.CGPath;
//    cell.layerView.layer.mask = maskLayer;
//    cell.layerView.layer.mask = maskLayer;
//
//    return cell;
//}
//-(HomeScrollViewCell *)configCell{
//
//    HomeScrollViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"HomeScrollViewCell" owner:nil options:nil].lastObject;
//    //圆角
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.layerView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = cell.layerView.bounds;
//    maskLayer.path = maskPath.CGPath;
//    cell.layerView.layer.mask = maskLayer;
//    cell.layerView.layer.mask = maskLayer;
//
//    return cell;
//}
//-(HomeScrollViewCell *)configCell{
//
//    HomeScrollViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"HomeScrollViewCell" owner:nil options:nil].lastObject;
//    //圆角
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.layerView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = cell.layerView.bounds;
//    maskLayer.path = maskPath.CGPath;
//    cell.layerView.layer.mask = maskLayer;
//    cell.layerView.layer.mask = maskLayer;
//
//    return cell;
//}
//-(HomeScrollViewCell *)configCell{
//
//    HomeScrollViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"HomeScrollViewCell" owner:nil options:nil].lastObject;
//    //圆角
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.layerView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = cell.layerView.bounds;
//    maskLayer.path = maskPath.CGPath;
//    cell.layerView.layer.mask = maskLayer;
//    cell.layerView.layer.mask = maskLayer;
//
//    return cell;
//}


@end
