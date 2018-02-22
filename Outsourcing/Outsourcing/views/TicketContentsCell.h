//
//  TicketContentsCell.h
//  Outsourcing
//
//  Created by 李文华 on 2017/8/23.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketModel.h"

@interface TicketContentsCell : UITableViewCell

@property (nonatomic,strong) UIButton *        selectBtn;

@property (nonatomic,strong) UILabel *        cName;
@property (nonatomic,strong) UILabel *        cDescription;
@property (nonatomic,strong) UILabel *        cPrice;

- (void)fitDataWithModel:(ContentTicketModel *)model;

@end
