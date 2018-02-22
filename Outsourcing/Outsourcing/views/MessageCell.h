//
//  MessageCell.h
//  Outsourcing
//
//  Created by 李文华 on 2017/9/23.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *mTitle;

@property (weak, nonatomic) IBOutlet UILabel *mTime;


@property (weak, nonatomic) IBOutlet UILabel *mDetail;


- (void)fitDataWithDict:(NSDictionary *)model;

@end
