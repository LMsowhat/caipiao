//
//  MBProgressHUDManager.h
//  Eliveapp
//
//  Created by 李文华 on 2017/4/10.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"


@interface MBProgressHUDManager : NSObject

+(void)showHUDAddedTo:(UIView *)bView WithString:(NSString *)string;
+(void)showHUDAddedTo:(UIView *)bView;
+(void)hideHUDForView:(UIView *)bView;


+(void)showTextHUDAddedTo:(UIView *)bView WithText:(NSString *)text afterDelay:(CGFloat)time;

+(void)showActionFeedbackTo:(UIView *)bView WithImage:(NSString *)imageName Text:(NSString *)text;

@end
