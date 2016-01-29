//
//  ShopCarListModel.h
//  Kergou
//
//  Created by JiaPin on 15/10/25.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "BaseModel.h"

@interface ShopCarListModel : BaseModel
@property (nonatomic,assign)NSInteger  amount;
@property (nonatomic,strong)NSString  *cid;
@property (nonatomic,strong)NSString  *goods_color_id;
@property (nonatomic,strong)NSString  *goods_id;
@property (nonatomic,strong)NSString  *goods_name;
@property (nonatomic,strong)NSString  *goods_num;
@property (nonatomic,strong)NSString  *goods_price;
@property (nonatomic,strong)NSString  *goods_size_id;
@property (nonatomic,strong)NSString  *image;
@property (nonatomic,strong)NSString  *is_flash;
@property (nonatomic,strong)NSString  *is_global;
@property (nonatomic,strong)NSString  *shop_id;
@property (nonatomic,strong)NSString  *sku_id;
@property (nonatomic,strong)NSString  *total_price;
@end
