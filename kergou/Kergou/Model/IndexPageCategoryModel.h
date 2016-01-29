//
//  IndexPageCategoryModel.h
//  Kergou
//
//  Created by JiaPin on 15/10/20.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "BaseModel.h"

@interface IndexPageCategoryModel : BaseModel
@property (nonatomic,strong)     NSString *goods_id;
@property (nonatomic,strong)     NSString *goods_name;
@property (nonatomic,strong)     NSString *sale_price;
@property (nonatomic,strong)     NSString *market_price;
@property (nonatomic,strong)     NSString *main_picture_230;
@property (nonatomic,strong)     NSString *main_picture_450;

@end
