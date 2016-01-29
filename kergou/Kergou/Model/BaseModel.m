//
//  BaseModel.m
//  Kergou
//
//  Created by JiaPin on 15/10/19.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
-(id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"找不到对应的key调用此方法--key====%@",key);
}
@end
