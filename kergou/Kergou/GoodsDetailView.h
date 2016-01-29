//
//  GoodsDetailView.h
//  Kergou
//
//  Created by JiaPin on 15/10/12.
//  Copyright (c) 2015年 张帅. All rights reserved.
//
#import "GoodsDetailHeaderModel.h"
#import <UIKit/UIKit.h>
@protocol GoodsDetailViewDelegate<NSObject>
-(void)addShopCarBtnClick;
-(void)buyRightNow;
-(void)gotoShopCarVC;
@end
@interface GoodsDetailView : UIView
{
    NSInteger _countNum;
}
@property (assign,nonatomic)id <GoodsDetailViewDelegate>delegate;
@property (nonatomic,strong) GoodsDetailStockModel *Model;

-(void)configureBtmViewWithModel:(GoodsDetailStockModel *)model;
@end
