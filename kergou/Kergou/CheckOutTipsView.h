//
//  CheckOutTipsView.h
//  Kergou
//
//  Created by JiaPin on 15/10/19.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CheckOutTipsViewDelegate <NSObject>

-(void)gotoCheckOut;

-(void)backShopCar;

-(void)TapClickToCancleView;

@end
@interface CheckOutTipsView : UIView
@property (nonatomic,strong)UIButton *headerBtn;
@property (nonatomic,strong)UIButton *headerBtn2;
@property (nonatomic,strong)UIView *bgView;
@property (assign,nonatomic)id<CheckOutTipsViewDelegate>delegate;
@end
