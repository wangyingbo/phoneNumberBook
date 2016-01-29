//
//  model.h
//  Kergou
//
//  Created by 王迎博 on 15/10/21.
//  Copyright (c) 2015年 张帅. All rights reserved.
//


#import "JSONModel.h"
@interface YBCellModel : JSONModel

//第二级数据里的category_name，先写一个字段吧。。
@property (nonatomic,strong)NSString *category_name;
@property (nonatomic, copy) NSString *icon;
@end
