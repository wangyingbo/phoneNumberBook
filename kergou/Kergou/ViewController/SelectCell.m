//
//  SelectCell.m
//  Kergou
//
//  Created by JiaPin on 15/10/19.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "SelectCell.h"

@implementation SelectCell

- (void)awakeFromNib
{
    UIView *lineView = [PublicMethod getLineViewWithFrame:CGRectMake(16, 114.7, IPHONE_WITH, 0.5)];
    [self addSubview:lineView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
