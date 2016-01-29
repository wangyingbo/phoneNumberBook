//
//  BrandPageCell.h
//  Kergou
//
//  Created by JiaPin on 15/10/14.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BrandPageCellDelegate <NSObject>
-(void)gotoGoodsDetailVC;
@end
@interface BrandPageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellBgImageView1;

@property (weak, nonatomic) IBOutlet UIImageView *cellBgImageView2;


@property (assign,nonatomic) id<BrandPageCellDelegate>delegate;
@end
