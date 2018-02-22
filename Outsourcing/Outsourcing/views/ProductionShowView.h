//
//  ProductionShowView.h
//  Outsourcing
//
//  Created by 李文华 on 2017/6/28.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubmitOrderProModel.h"

@interface ProductionShowView : UIView

@property (nonatomic ,strong)UIView *proShowView;

//
@property (nonatomic ,strong)UIImageView *pIcon;
@property (nonatomic ,strong)UILabel *pName;
@property (nonatomic ,strong)UILabel *pNum;
@property (nonatomic ,strong)UILabel *barrelPrice;
@property (nonatomic ,strong)UILabel *pPrice;

-(instancetype)initWithFrame:(CGRect)frame AndModel:(SubmitOrderProModel *)model;


@end
