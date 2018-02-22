//
//  NoResultView.m
//  Outsourcing
//
//  Created by 李文华 on 2017/9/13.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "NoResultView.h"
#import "Masonry.h"

@implementation NoResultView

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];

    if (self) {
        
        self.backgroundColor = kWhiteColor;
        self.placeHolder = [UILabel new];
        self.placeHolder.textColor = UIColorFromRGBA(0x8F9095, 1.0);
        self.placeHolder.font = [UIFont boldSystemFontOfSize:24];
        self.placeHolder.text = @"暂无数据";
        self.placeHolder.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.placeHolder];
        
        [self.placeHolder makeConstraints:^(MASConstraintMaker *make) {
            
            make.center.equalTo(self);
            
        }];
    }
    return self;
}



@end
