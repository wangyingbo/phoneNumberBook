//
//  AfterSalesModel.h
//  Kergou
//
//  Created by 王迎博 on 15/10/15.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YBAfterSalesModel : NSObject


@property (nonatomic,strong)NSString *goodsNumM;
@property (nonatomic,copy)NSString *statusLabelM;
@property (nonatomic,copy)NSArray *goodsImageUrlM;
@property (nonatomic,copy)NSString *goodsInfoM;
@property (nonatomic,copy)NSString *timeLabelM;

- (instancetype)initWithLabels:(NSDictionary *)model;

@end
