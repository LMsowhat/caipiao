//
//  TicketListTableViewCell.h
//  Outsourcing
//
//  Created by 李文华 on 2017/7/10.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketModel.h"

@interface TicketListTableViewCell : UITableViewCell

@property (nonatomic,strong) UIView *        bgView;

@property (nonatomic,strong) UIImageView *        pIcon;//产品图片
@property (nonatomic,strong) UILabel *        pName;//产品名称
@property (nonatomic,strong) UILabel *        pSales;//
@property (nonatomic,strong) UILabel *        pActivity;//
@property (nonatomic,strong) UILabel *        pCurrent_Price;//
@property (nonatomic,strong) UILabel *        pBefore_Prices;//

@property (nonatomic,strong) UIButton *        buyBtn;


@property (nonatomic,strong) UILabel *        payTime;
@property (nonatomic,strong) UILabel *        tNumber;



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;


- (void)buyTicketFitData:(TicketModel *)model;

- (void)myTicketFitData:(TicketModel *)model;



@end
