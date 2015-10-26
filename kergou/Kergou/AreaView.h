//
//  AreaView.h
//  Kergou
//
//  Created by JiaPin on 15/10/9.
//  Copyright (c) 2015年 张帅. All rights reserved.
//
#import "AreaModel.h"
#import <UIKit/UIKit.h>
@protocol AreaViewDelegate<NSObject>

-(void)okBtnClickWithChoseArea:(AreaModel *)areaModel;
-(void)areaCancleBtnClick;

@end
@interface AreaView : UIView
@property (assign,nonatomic)id<AreaViewDelegate>delegate;
@end
