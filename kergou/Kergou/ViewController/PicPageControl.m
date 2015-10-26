//
//  PicPage.m
//  Kergou
//
//  Created by JiaPin on 15/9/6.
//  Copyright (c) 2015年 张帅. All rights reserved.
//
#import "ShowBigPicScrollView.h"
#import "PicPageControl.h"

@implementation PicPageControl
-(instancetype)initWithFrame:(CGRect)frame withPageCount:(NSInteger)PageCount withClass:(ShowSmallPicScrollView *)smallVC
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.frame = frame;
        self.numberOfPages = PageCount;
        self.pageIndicatorTintColor = [UIColor orangeColor];
        self.hidesForSinglePage = YES;
     
        smallVC.pageNum = ^(NSInteger num)
        {
            self.currentPage = num;
        };
    
        
    }
    return self;
}

@end
