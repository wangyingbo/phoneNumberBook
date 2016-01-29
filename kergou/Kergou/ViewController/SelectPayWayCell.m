//
//  SelectPayWayCell.m
//  Kergou
//
//  Created by JiaPin on 15/10/13.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "SelectPayWayCell.h"

@implementation SelectPayWayCell

- (void)awakeFromNib {
    [self.payWayImgView.layer setMasksToBounds:YES];
    [self.payWayImgView.layer setCornerRadius:4];
    self.backgroundColor = [UIColor whiteColor];
    UIView *lineView = [PublicMethod getLineViewWithFrame:CGRectMake(12, 41.5, IPHONE_WITH, 0.5)];
    [self addSubview:lineView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
