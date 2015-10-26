//
//  YBCollectionReusable.m
//  Kergou
//
//  Created by 王迎博 on 15/9/24.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "YBClassifyHeaderView.h"

@implementation YBClassifyHeaderView

- (void)setData:(YBSectionModel *)sectionModel
{
    
    self.sectionName.text = sectionModel.category_name;
}

@end
