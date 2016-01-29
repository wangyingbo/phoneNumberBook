//
//  CheckOutCell.h
//  Kergou
//
//  Created by JiaPin on 15/9/28.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CheckOutCellDelegate<NSObject>

-(void)rightBtnPayClick;


@end
@interface CheckOutCell : UITableViewCell
@property (strong,nonatomic) UIButton *leftBtn;
@property (strong,nonatomic) UIButton *rightBtn;
@property (strong,nonatomic) NSString *stationStr;
@property (strong,nonatomic) UILabel  *goodsNumLab;
@property (strong,nonatomic) UILabel  *goodsPriceLab;
@property (assign,nonatomic) id<CheckOutCellDelegate>delegate;
-(void)configureViewWithBtnStatuesStr:(NSString *)stateStr;
@end
