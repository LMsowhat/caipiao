//
//  InputTextView.m
//  Outsourcing
//
//  Created by 李文华 on 2017/9/3.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "InputTextView.h"

#import "Masonry.h"

@implementation InputTextView

- (id)initWithFrame:(CGRect)frame Text:(NSString *)placeholder{

    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        UIView *areaView = [UIView new];
        
        self.inputText = [UITextView new];
        self.inputText.text = @"您的意见是我们前进的最大动力，谢谢！";
        // 设置文本字体
        self.inputText.font = kFont(7);
        // 设置文本颜色
        self.inputText.textColor = UIColorFromRGBA(0x333338, 1.0);
        // 设置文本框背景颜色
        self.inputText.backgroundColor = kWhiteColor;
        // 设置文本对齐方式
        self.inputText.textAlignment = NSTextAlignmentLeft;
        // 设置自动纠错方式
        self.inputText.autocorrectionType = UITextAutocorrectionTypeNo;
        
        self.saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.saveButton.titleLabel setFont:kFont(7)];
        [self.saveButton setTitle:@"保存" forState:UIControlStateNormal];
        [self.saveButton setTitleColor:UIColorFromRGBA(0xFFFFFF, 1.0) forState:UIControlStateNormal];
        self.saveButton.backgroundColor = UIColorFromRGBA(0xFA6650, 1.0);
        
        [areaView addSubview:self.inputText];
        [areaView addSubview:self.saveButton];
        
        [self addSubview:areaView];
       
        [areaView makeConstraints:^(MASConstraintMaker *make) {
            
            make.center.equalTo(self);
            
            make.height.equalTo(self.frame.size.height/2);
            
            make.width.equalTo(self);
        }];
        
        [self.inputText makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.left.right.equalTo(self);
            
            make.bottom.equalTo(areaView).offset(-24.5 *kScale);
        }];
        
        [self.saveButton makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.equalTo(CGSizeMake(kWidth, 24.5 *kScale));
            
            make.bottom.equalTo(self);
        }];
        
    }
    
    return self;

}



@end
