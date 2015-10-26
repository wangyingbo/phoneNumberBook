//
//  PicPage.h
//  Kergou
//
//  Created by JiaPin on 15/9/6.
//  Copyright (c) 2015年 张帅. All rights reserved.
//
#import "ShowSmallPicScrollView.h"
#import <UIKit/UIKit.h>

@interface PicPageControl : UIPageControl
-(instancetype)initWithFrame:(CGRect)frame withPageCount:(NSInteger)PageCount withClass:(ShowSmallPicScrollView *)smallVC;
@end
