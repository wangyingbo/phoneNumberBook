//
//  YBAftersalesCellVC.h
//  Kergou
//
//  Created by 王迎博 on 15/10/10.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YBAfterSalesModel;

@interface YBAftersalesCellVC : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *returnGoodsNum;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *goodInfo;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

- (void)setModel:(YBAfterSalesModel *)afterSalesModel;

@end
