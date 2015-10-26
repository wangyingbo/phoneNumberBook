//
//  testModel.h
//  Kergou
//
//  Created by 王迎博 on 15/10/20.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "JSONModel.h"
#import "YBCellModel.h"


@protocol YBCellModel;

@interface YBSectionModel : JSONModel

@property (nonatomic,strong)NSString *category_name;

@property (nonatomic, strong) NSArray<YBCellModel> *children;



@end
