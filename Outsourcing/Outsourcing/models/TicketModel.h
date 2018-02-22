//
//  TicketModel.h
//  Outsourcing
//
//  Created by 李文华 on 2017/8/22.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TicketModel : NSObject


@property (nonatomic,strong) NSString *        dExpire;

@property (nonatomic,strong) NSString *        lId;

@property (nonatomic,strong) NSString *        nMonthCount;

@property (nonatomic,strong) NSString *        nOldPrice;

@property (nonatomic,strong) NSString *        nPrice;

@property (nonatomic,strong) NSString *        lGoodsid;

@property (nonatomic,strong) NSString *        strGoodsName;

@property (nonatomic,strong) NSString *        strGoodsimgurl;

@property (nonatomic,strong) NSString *        strRemarks;

@property (nonatomic,strong) NSString *        ticketcontents;

//

@property (nonatomic,strong) NSString *        strExpire;
@property (nonatomic,strong) NSString *        nRemainingCount;
@property (nonatomic,strong) NSString *        strTicketName;




@end


@interface ContentTicketModel : NSObject

@property (nonatomic,strong) NSString *        lId;

@property (nonatomic,strong) NSString *        nCount;

@property (nonatomic,strong) NSString *        nPrice;

@property (nonatomic,strong) NSString *        strRemarks;


@end
