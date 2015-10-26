//
//  OderDetailBtmView.h
//  Kergou
//
//  Created by JiaPin on 15/9/28.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol OderDetailBtmViewDelegate<NSObject>

-(void)checkTransportInfoBtnClick;
-(void)oneMoreTimeBuy;
@end
@interface OderDetailBtmView : UIView
-(id)initWithFrame:(CGRect)frame withStateNum:(NSInteger)stateNum;
@property (assign,nonatomic)id <OderDetailBtmViewDelegate>delegate;
@end
