//
//  UserTools.m
//  Outsourcing
//
//  Created by 李文华 on 2017/7/13.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "UserTools.h"
#import <CloudPushSDK/CloudPushSDK.h>



@implementation UserTools


+(NSString *)firstTag{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    return [userDefault objectForKey:@"isFirst"];
}

+(void)setFirstTag:(NSString *)tag{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    [userDefault setObject:tag forKey:@"isFirst"];
    [userDefault synchronize];
    
}



+ (void)setInvite:(NSString *)inviteCode{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    [userDefault setObject:inviteCode forKey:@"invite"];
    [userDefault synchronize];
    
}

+ (NSString *)userInviteCode{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    NSString *invite = [userDefault objectForKey:@"invite"];
    return invite;
}


+ (void)setUserId:(NSString *)userId{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    [userDefault setObject:userId forKey:@"clientId"];
    [userDefault synchronize];
    
}


+(NSString *)userId{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    NSString *userId = [userDefault objectForKey:@"clientId"];
    return userId;
}


+(NSString *)getUserId{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    NSString *userId = [userDefault objectForKey:@"clientId"] ? [userDefault objectForKey:@"clientId"] : [userDefault objectForKey:@"employeeId"];
    
    return userId;
}



+ (void)setUserAddress:(NSDictionary *)userAddress{

    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    [userDefault setObject:userAddress forKey:@"address"];
    [userDefault synchronize];
}

+(NSDictionary *)userAddress{

    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *userAddress = [userDefault objectForKey:@"address"];
    return userAddress;
}

+ (void)setUserEmployees:(NSString *)employeeId{

    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    [userDefault setObject:employeeId forKey:@"employeeId"];
    
    [userDefault synchronize];
}

+(NSString *)userEmployeesId{

    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    NSString *employeeId = [userDefault objectForKey:@"employeeId"];
    return employeeId;
}

+ (void)setUserEmployeeName:(NSString *)employeeName{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    [userDefault setObject:employeeName forKey:@"employeeName"];
    
    [userDefault synchronize];
}

+(NSString *)userEmployeesName{

    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    NSString *employeeName = [userDefault objectForKey:@"employeeName"];
    return employeeName;
}


+ (void)logOut{
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"clientId"];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"address"];

    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"employeeId"];

    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"employeeName"];

}


+ (void)setNetRules:(NSString *)rules ForKey:(NSString *)key{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    [userDefault setObject:rules forKey:key];
    [userDefault synchronize];
    
}


+(BOOL)netRules:(NSString *)key{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    NSString *rule = [userDefault objectForKey:key];
    
    return [rule boolValue];
    
}



+ (void) bindAccount
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    NSString *userId = [userDefault objectForKey:@"clientId"] ? [userDefault objectForKey:@"clientId"] : [userDefault objectForKey:@"employeeId"];
    
    if (!userId || userId.length == 0) return;
    //
    [CloudPushSDK bindAccount:userId withCallback:^(CloudPushCallbackResult *res) {
        
    }];
}

+ (void) unbindAccount
{
    [CloudPushSDK unbindAccount:^(CloudPushCallbackResult *res) {
        
    }];
}


@end
