//
//  ZSIndexCell.h
//  Kergou
//
//  Created by JiaPin on 15/9/16.
//  Copyright (c) 2015年 张帅. All rights reserved.
//
#import "IndexPageCategoryModel.h"
#import <UIKit/UIKit.h>
@protocol ZSIndexCellDelegate <NSObject>
-(void)gotoGoodsDetailVC;
@end
@interface ZSIndexCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellGoodsImageView1;
@property (weak, nonatomic) IBOutlet UIView *cellBgView;
@property (weak, nonatomic) IBOutlet UIImageView *cellGoodsImageView2;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView1;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView2;
@property (weak, nonatomic) IBOutlet UILabel *describLab1;
@property (weak, nonatomic) IBOutlet UILabel *describeLab2;
@property (weak, nonatomic) IBOutlet UILabel *priceLab1;
@property (weak, nonatomic) IBOutlet UILabel *priceLab2;
@property (weak, nonatomic) IBOutlet UILabel *beforePriceLab1;
@property (weak, nonatomic) IBOutlet UILabel *beforePriceLab2;
@property (weak, nonatomic) IBOutlet UIView *lineView1;
@property (weak, nonatomic) IBOutlet UIView *lineView2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineViewConstant1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineViewConstant2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineViewHeightConstant1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineViewHeightConstant2;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHeight2;
@property (nonatomic,strong) id<ZSIndexCellDelegate>delegate;
-(void)configureCellWithDataModel:(IndexPageCategoryModel *)model withNumCell:(NSInteger)num;
@end













