//
//  PastTableViewCell.h
//  CaipiaoApp
//
//  Created by liwenhua on 2018/1/30.
//  Copyright © 2018年 李文华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PastTableViewCell : UITableViewCell

// strong
/** 注释 */
@property (strong, nonatomic) NSDictionary * model;

@property (weak, nonatomic) IBOutlet UILabel *label1;

@property (weak, nonatomic) IBOutlet UILabel *label2;

@property (weak, nonatomic) IBOutlet UILabel *label3;

@property (weak, nonatomic) IBOutlet UILabel *label4;

@property (weak, nonatomic) IBOutlet UILabel *label5;

@property (weak, nonatomic) IBOutlet UILabel *label6;

@property (weak, nonatomic) IBOutlet UILabel *label7;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;




@end
