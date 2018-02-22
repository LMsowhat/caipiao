//
//  ProductionCollectionViewCell.h
//  Outsourcing
//
//  Created by 李文华 on 2017/6/14.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductionModel.h"


@interface ProductionCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *        icon;

@property (nonatomic,strong) UILabel  *        pName;

@property (nonatomic,strong) UILabel *        pStandard;

@property (nonatomic,strong) UILabel *        pPrice;

@property (nonatomic,strong) UILabel *        pSales;

@property (nonatomic,strong) UIButton *        shoppingCart;


-(void)fitDataWith:(ProductionModel *)model;



@end
