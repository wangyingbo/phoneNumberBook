//
//  GoodsDetailHeaderModel.h
//  Kergou
//
//  Created by JiaPin on 15/10/21.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "BaseModel.h"

@interface GoodsDetailHeaderModel : BaseModel
@property (nonatomic,strong)    NSString *goods_id;
@property (nonatomic,strong)    NSString *goods_pic;
@property (nonatomic,strong)    NSString *goods_pic_230;
@property (nonatomic,strong)    NSString *goods_pic_450;
@property (nonatomic,strong)    NSString *goods_pic_75;
//@property (nonatomic,strong)    NSString *id;
@property (nonatomic,strong)    NSString *pic_status;

@end

@interface GoodsDetailMiddleModel : BaseModel
@property (nonatomic,strong)   NSString *desc;
@property (nonatomic,strong)   NSString *goods_name;
@property (nonatomic,strong)   NSString *main_picture_75;
@property (nonatomic,strong)   NSString *brand_id;
@property (nonatomic,strong)   NSString *check_status;
@property (nonatomic,strong)   NSString *main_picture_230;
@property (nonatomic,strong)   NSString *main_picture_450;
@property (nonatomic,strong)   NSString *market_price;
@property (nonatomic,strong)   NSString *question_img;
@property (nonatomic,strong)   NSString *sale_price;


@end

@interface GoodsDetailStockModel : BaseModel
@property (nonatomic,strong)   NSString *add_time;
@property (nonatomic,strong)   NSString *goods_color_id;
@property (nonatomic,strong)   NSString *goods_num;
@property (nonatomic,strong)   NSString *goods_id;

@property (nonatomic,strong)   NSString *goods_price;
@property (nonatomic,strong)   NSString *goods_size_id;
@property (nonatomic,strong)   NSString *id;



@end

