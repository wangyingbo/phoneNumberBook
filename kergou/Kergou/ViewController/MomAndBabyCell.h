//
//  MomAndBabyCell.h
//  Kergou
//
//  Created by JiaPin on 15/10/14.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MomAndBabyCellDelegate <NSObject>
-(void)gotoGoodsDetailVC;
@end
@interface MomAndBabyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellBgImageView1;
@property (weak, nonatomic) IBOutlet UIImageView *cellBgImageVeiw2;
@property (assign,nonatomic) id<MomAndBabyCellDelegate>delegate;
@end
