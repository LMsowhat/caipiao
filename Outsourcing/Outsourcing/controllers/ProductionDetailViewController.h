//
//  ProductionDetailViewController.h
//  Outsourcing
//
//  Created by 李文华 on 2017/6/15.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "BaseViewController.h"

@interface ProductionDetailViewController : BaseViewController

@property (nonatomic,strong) NSString *        goodsLid;

- (void)getProductionDetail:(id)responseObj;

- (void)resultOfSubmitOrder:(id)responseObj;

@end
