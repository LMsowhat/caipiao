//
//  UserTools.h
//  Outsourcing
//
//  Created by 李文华 on 2017/7/13.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserTools : NSObject


//firstLoad
+(NSString *)firstTag;
+(void)setFirstTag:(NSString *)tag;

//inviteCode
+(void)setInvite:(NSString *)inviteCode;
+(NSString *)userInviteCode;

//userId
+ (void)setUserId:(NSString *)userId;
+(NSString *)userId;

//userAddress
+ (void)setUserAddress:(NSDictionary *)userAddress;
+(NSDictionary *)userAddress;

//employeeId
+ (void)setUserEmployees:(NSString *)employeeId;
+(NSString *)userEmployeesId;
//employeeName
+ (void)setUserEmployeeName:(NSString *)employeeName;
+(NSString *)userEmployeesName;

+(NSString *)getUserId;

+ (void)logOut;

+ (void) bindAccount;

+ (void) unbindAccount;


@end
