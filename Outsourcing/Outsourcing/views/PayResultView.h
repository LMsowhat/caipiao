//
//  PayResultView.h
//  Eliveapp
//
//  Created by 李文华 on 2017/5/11.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"


@interface PayResultView : UIView

@property (nonatomic ,strong)UIButton *seeOrderBtn;
@property (nonatomic ,strong)UIButton *payAgainBtn;
@property (nonatomic ,strong)UIButton *goBackBtn;

-(instancetype)initSuccess:(BOOL)success WithModel:(OrderModel *)model;

@end
