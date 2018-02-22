//
//  InputTextView.h
//  Outsourcing
//
//  Created by 李文华 on 2017/9/3.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputTextView : UIView

@property (nonatomic,strong) UITextView *        inputText;

@property (nonatomic,strong) UIButton *        saveButton;

- (id)initWithFrame:(CGRect)frame Text:(NSString *)placeholder;

@end
