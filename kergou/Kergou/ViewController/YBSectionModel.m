//
//  testModel.m
//  Kergou
//
//  Created by 王迎博 on 15/10/20.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "YBSectionModel.h"

@implementation YBSectionModel
//防止数据为nil时 转化Model 失败  崩溃
+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end
