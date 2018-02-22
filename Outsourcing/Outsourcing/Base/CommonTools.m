//
//  CommonTools.m
//  Outsourcing
//
//  Created by 李文华 on 2017/9/12.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "CommonTools.h"

@implementation CommonTools

+ (NSString *)getTimeFromString:(NSString *)timeString{
 
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSTimeInterval interval    = [timeString doubleValue] / 1000.0;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    NSString *dateString       = [formatter stringFromDate: date];

    return dateString;
}



@end
