//
//  ShoppingCartController.h
//  Outsourcing
//
//  Created by 李文华 on 2017/8/31.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "BaseViewController.h"

@interface ShoppingCartController : BaseViewController

- (void)sendHttpRequest;


- (void)getShoppingDetail:(id)responsObject;


- (void)deleteProductionResult:(id)responstObject;


- (void)resultOfSubmitOrder:(id)responstObject;

@end
