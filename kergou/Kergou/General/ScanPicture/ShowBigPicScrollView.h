//
//  ShowBigPicScrollView.h
//  Kergou
//
//  Created by JiaPin on 15/9/2.
//  Copyright (c) 2015年 张帅. All rights reserved.
//
typedef  void (^doTransferMsg)(NSInteger);
#import <UIKit/UIKit.h>
//    代理方法实现设置点击大视图消失后的当前小视图的偏移量
//@protocol ShowBigPicScrollViewDelegate<NSObject>
//@optional
//-(void)changeTheSmallPicScroViewOffSet:(NSInteger)offSet;
//@end


@interface ShowBigPicScrollView : UIScrollView<UIScrollViewDelegate>

//block :为了把当前的scrollView的偏移量传递给上一个视图
@property (nonatomic,strong) doTransferMsg offSet;

//@property (nonatomic,assign) id <ShowBigPicScrollViewDelegate>TouchDelegate;

-(instancetype)initWithPicArr:(NSArray *)pics withContentOffSet:(NSInteger)picOffSet;
@end
