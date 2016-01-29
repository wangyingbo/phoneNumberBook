//
//  MineCell.h
//  Kergou
//
//  Created by JiaPin on 15/10/9.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MineCellDelegate <NSObject>

-(void)oderDetailBtnClick:(NSInteger)btnTag;

@end
@interface MineCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *normalImView;
@property (assign,nonatomic) id<MineCellDelegate>delegate;
@end
