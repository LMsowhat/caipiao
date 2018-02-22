//
//  ProductionDetail.m
//  Outsourcing
//
//  Created by 李文华 on 2017/6/19.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "ProductionDetail.h"

@implementation ProductionDetail

-(instancetype)initWithArraies:(NSArray *)images{

    self = [super init];

    if (self) {
        
        UIScrollView *mainScroll = [UIScrollView new];
        mainScroll.frame = self.frame;
        
        
        for (int i = 0; i < images.count; i++) {
            
            UIImageView *imageV = [UIImageView new];
            
            imageV.image = [UIImage imageWithContentsOfFile:images[i]];
            imageV.frame = CGRectMake(20, 200 * i, kWidth - 40, 200);
            
            [self addSubview:imageV];
        }
        
    }

    return self;
}



@end
