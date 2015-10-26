//
//  AfterSalesModel.m
//  Kergou
//
//  Created by 王迎博 on 15/10/15.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "YBAfterSalesModel.h"

@implementation YBAfterSalesModel

- (instancetype)initWithLabels:(NSDictionary *)model
{
    if (self = [super init])
    {
        //model里传入的是各个字段参数，这里是。
        self.goodsNumM = model[@"num"];
        self.statusLabelM = model[@"status"];
        self.goodsImageUrlM = model[@"image"];
        self.goodsInfoM = model[@"goodsInfo"];
        self.timeLabelM = model[@"time"];
        
        
    }
    return self;
}

@end
