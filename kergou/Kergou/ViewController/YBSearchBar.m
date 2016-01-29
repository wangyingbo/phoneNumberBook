//
//  YBSearchBar.m
//  Kergou
//
//  Created by 王迎博 on 15/9/18.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "YBSearchBar.h"

@implementation YBSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:13];
        
        //self.backgroundColor = [UIColor yellowColor];
        
        //设置左边的view
        UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sousuoxibing"]];
        imageV.contentMode = UIViewContentModeCenter;
        //搜索框左边的view
        self.leftView = imageV;
        //输入框中是否有个叉号
        self.clearButtonMode = UITextFieldViewModeAlways;
        self.borderStyle = UITextBorderStyleRoundedRect;
        
        //设置左边视图
        self.leftViewMode = UITextFieldViewModeAlways;
        
    }
    return self;
}


@end
