//
//  LowPriceCell.h
//  Kergou
//
//  Created by JiaPin on 15/10/14.
//  Copyright (c) 2015年 张帅. All rights reserved.
//
#import "BrandSaleModel.h"
#import <UIKit/UIKit.h>

@interface LowPriceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *brandSaleIMV;

@property (weak, nonatomic) IBOutlet UILabel *describeLab;

@property (weak, nonatomic) IBOutlet UILabel *endTimeLab;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic,strong)          NSString *endTimeStr;

@property (assign,nonatomic)   NSTimer *repeatTimer;
-(void)ConfigureCellWithModel:(BrandSaleModel *)model;
@end
