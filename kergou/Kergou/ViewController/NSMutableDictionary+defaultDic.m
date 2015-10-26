//
//  NSMutableDictionary+defaultDic.m
//  Kergou
//
//  Created by 王迎博 on 15/10/13.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "NSMutableDictionary+defaultDic.h"

@implementation NSMutableDictionary (defaultDic)


+ (NSMutableDictionary *)defaultDicWithAdr:(NSString *)adr
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:@"iosapp" forKey:@"c"];
    [dic setObject:@"a" forKey:adr];
    return dic;
}

@end
