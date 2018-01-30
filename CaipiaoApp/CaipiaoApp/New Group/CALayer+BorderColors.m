//
//  CALayer+BorderColors.m
//  CaipiaoApp
//
//  Created by liwenhua on 2018/1/30.
//  Copyright © 2018年 李文华. All rights reserved.
//

#import "CALayer+BorderColors.h"
#import <UIKit/UIKit.h>

@implementation CALayer (BorderColors)



- (void)setBorderColorWithUIColor:(UIColor *)color
{
    
    self.borderColor = color.CGColor;
}

@end
