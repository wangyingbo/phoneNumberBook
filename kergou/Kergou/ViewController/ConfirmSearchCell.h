//
//  ConfirmSearchCell.h
//  Kergou
//
//  Created by JiaPin on 15/9/21.
//  Copyright (c) 2015年 张帅. All rights reserved.
//
#import "SearchConfirmModel.h"
#import <UIKit/UIKit.h>
@protocol ConfirmSearchCellDelegate <NSObject>
-(void)gotoGoodsDetailVC;
@end
@interface ConfirmSearchCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cellBgImageView1;

@property (weak, nonatomic) IBOutlet UIImageView *cellBgImageView2;

@property (assign,nonatomic) id<ConfirmSearchCellDelegate>delegate;
-(void)configureCellWithModel:(SearchConfirmModel *)model;
@end
