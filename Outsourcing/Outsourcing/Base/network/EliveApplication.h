//
//  EliveApplication.h
//  Eliveapp
//
//  Created by 李文华 on 2017/4/20.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EliveApplication : NSObject

+ (EliveApplication *)shareStance;


- (void)onHttpCode:(int)httpCode WithParameters:(NSDictionary *)parms;


@end
