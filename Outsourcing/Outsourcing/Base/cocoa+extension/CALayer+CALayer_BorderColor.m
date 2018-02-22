//
//  CALayer+CALayer_BorderColor.m
//  Outsourcing
//
//  Created by 李文华 on 2017/9/12.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "CALayer+CALayer_BorderColor.h"
#import <UIKit/UIKit.h>


@implementation CALayer (CALayer_BorderColor)

- (void)setBorderColorWithUIColor:(UIColor *)color{
    
    self.borderColor = color.CGColor;
}

@end
