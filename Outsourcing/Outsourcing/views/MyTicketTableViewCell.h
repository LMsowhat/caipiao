//
//  MyTicketTableViewCell.h
//  Outsourcing
//
//  Created by 李文华 on 2017/8/17.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketModel.h"


@interface MyTicketTableViewCell : UITableViewCell

@property (nonatomic,strong) UILabel *        tTitle;

@property (nonatomic,strong) UILabel *        tDate;

@property (nonatomic,strong) UILabel *        tNumber;

- (void)fitDataWithModel:(TicketModel *)model;


@end
