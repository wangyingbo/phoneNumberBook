//
//  GoodsDetailCell.h
//  Kergou
//
//  Created by JiaPin on 15/10/23.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsDetailCell : UITableViewCell
-(void)configureCellWithImgArr:(NSArray *)imgArr;
-(void)configureCellWithBrandInfo:(NSString *)brandStr withCellHeight:(float)height;
-(void)configureCellWithNormalQuestion:(UIImage *)image;

@end
