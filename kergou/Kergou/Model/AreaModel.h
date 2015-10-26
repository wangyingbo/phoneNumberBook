//
//  AreaModel.h
//  Kergou
//
//  Created by JiaPin on 15/10/19.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "BaseModel.h"

@interface AreaModel : BaseModel
@property (nonatomic,strong) NSString *province;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSString *district;
@end
