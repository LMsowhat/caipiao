//
//  OrderDetailListCell.m
//  Outsourcing
//
//  Created by 李文华 on 2017/6/26.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "OrderDetailListCell.h"
#import "Masonry.h"


@implementation OrderDetailListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {
        
        self.left_label = [UILabel new];
        self.left_label.font = kFont(7);
        self.left_label.textColor = UIColorFromRGBA(0x333338, 1.0);
        
        self.right_icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        self.right_icon.image = [UIImage imageNamed:@"more"];
        
        [self addSubview:self.left_label];
        [self addSubview:self.right_icon];
        
        
        [self.right_icon makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(-10*kScale);
            
        }];
        
        [self.left_label makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(10*kScale);
            make.right.equalTo(self.right_icon).offset(-5);
        }];
        
        
    }

    return self;
}

- (void)setLeftView:(id)leftLabel RightView:(id)rightView others:(id)bgView{

    if (leftLabel) {
        
        [self.left_label removeFromSuperview];
        
        [self addSubview:leftLabel];
        
        [leftLabel makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(10);
            
        }];
        
    }
    
    if (rightView) {
        
        [self.right_icon removeFromSuperview];
        
        [self addSubview:rightView];
        
        [rightView makeConstraints:^(MASConstraintMaker *make) {
            
            if ([rightView isKindOfClass:[UIButton class]]) {
                
                UIButton *btn = rightView;
                CGSize bSize = CGSizeMake(btn.frame.size.width, btn.frame.size.height);
                
                make.size.equalTo(bSize);
            }
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(-15);
            
        }];
        
    }
    
    if (bgView) {
        
        [self.left_label removeFromSuperview];
        [self.right_icon removeFromSuperview];

        [self addSubview:bgView];
        
        [bgView makeConstraints:^(MASConstraintMaker *make) {
            
            make.center.equalTo(self);
            make.size.equalTo(self);
            
        }];
    }
    
    
}


@end
