//
//  ProtocolViews.m
//  Eliveapp
//
//  Created by 李文华 on 2017/5/12.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "ProtocolViews.h"
#import "Masonry.h"

@implementation ProtocolViews

+ (UIView *)creatViewWithTitle:(NSString *)titel Detail:(NSArray *)textArr{

    UIView *mainView = [UIView new];

    UIView *numView = [UIView new];
    numView.backgroundColor = UIColorFromRGBA(0x44b336, 1.0);
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = titel;
    titleLabel.font = kFont(7.5);
    titleLabel.textColor = UIColorFromRGBA(0x44b336, 1.0);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    
    UIView *detailView = [UIView new];
    
    [mainView addSubview:numView];
    [mainView addSubview:titleLabel];
    [mainView addSubview:detailView];
    
    CGFloat tHeight = 15.0;
    for (int i = 0; i < textArr.count; i++) {
        
        NSMutableParagraphStyle *paragraphStyle  =[[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 20;
        paragraphStyle.alignment = NSTextAlignmentJustified;
        
        NSDictionary *attriDict = @{NSFontAttributeName:kFont(6.5),NSParagraphStyleAttributeName:paragraphStyle};

        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:textArr[i] attributes:attriDict];
        
        CGRect dRect = [attString boundingRectWithSize:CGSizeMake(kWidth - 30, 1000) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];

        
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, tHeight, kWidth - 30, dRect.size.height)];
        textLabel.numberOfLines = 0;
        textLabel.attributedText = attString;
        textLabel.textColor = UIColorFromRGBA(0x878c89, 1.0);
        
        [detailView addSubview:textLabel];
        
        tHeight += dRect.size.height + 15;

    }
    
    [numView makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.equalTo(CGSizeMake(5, 15));
        make.top.left.equalTo(mainView).offset(15);
        
    }];
    
    [titleLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(numView);
        make.left.equalTo(numView.mas_right).offset(5);
    }];
    
    [detailView makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.equalTo(CGSizeMake(kWidth, tHeight));
        make.centerX.equalTo(mainView);
        make.top.equalTo(titleLabel.mas_bottom);
        
    }];
    
    mainView.bounds = CGRectMake(0, 0, kWidth, tHeight + 30);
    
    return mainView;
}

@end
