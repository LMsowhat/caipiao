//
//  OrderInputView.h
//  Outsourcing
//
//  Created by 李文华 on 2017/9/17.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderInputView : UIView

@property (nonatomic,assign) NSInteger          isRemark;

@property (weak, nonatomic) IBOutlet UITextView *myTextView;

@property (weak, nonatomic) IBOutlet UIButton *saveButon;


@end
