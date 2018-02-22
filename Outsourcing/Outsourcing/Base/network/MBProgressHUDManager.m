//
//  MBProgressHUDManager.m
//  Eliveapp
//
//  Created by 李文华 on 2017/4/10.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "MBProgressHUDManager.h"

@implementation MBProgressHUDManager

+(void)showHUDAddedTo:(UIView *)bView WithString:(NSString *)string{

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:bView animated:YES];
//    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.labelText = string;
    
}
+(void)showHUDAddedTo:(UIView *)bView{

    [MBProgressHUD showHUDAddedTo:bView animated:YES];

}

+(void)hideHUDForView:(UIView *)bView{

    [MBProgressHUD hideHUDForView:bView animated:YES];

}

+(void)showTextHUDAddedTo:(UIView *)bView WithText:(NSString *)text afterDelay:(CGFloat)time{

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:bView animated:YES];

    hud.mode = MBProgressHUDModeText;
    
    hud.labelText = text;

    hud.labelFont = kFont(6.5);
    
    hud.labelColor = kWhiteColor;

    [hud hide:YES afterDelay:time];
}


+(void)showActionFeedbackTo:(UIView *)bView WithImage:(NSString *)imageName Text:(NSString *)text{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:bView animated:YES];
    
    // Set the custom view mode to show any view.
    hud.mode = MBProgressHUDModeCustomView;
    // Set an image view with a checkmark.
    UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

    hud.customView = [[UIImageView alloc] initWithImage:image];
    // Looks a bit nicer if we make it square.
    hud.square = YES;
    // Optional label text.
    hud.labelText = text;
//    hud.label.text = text;
    
    [hud hide:YES afterDelay:2.f];
}


@end
