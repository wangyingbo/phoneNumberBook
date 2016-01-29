//
//  ShowBigPicScrollView.m
//  Kergou
//
//  Created by JiaPin on 15/9/2.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "ShowBigPicScrollView.h"

@implementation ShowBigPicScrollView

-(instancetype)initWithPicArr:(NSArray *)pics withContentOffSet:(NSInteger)picOffSet
{
    self = [super init];
    if (self)
    {
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = CGRectMake(0, 0, IPHONE_WITH, IPHONE_HEIGHT);
        }];
        
        self.backgroundColor = [UIColor blackColor];
        self.delegate = self;
        self.pagingEnabled = YES;
        self.contentSize = CGSizeMake(pics.count*IPHONE_WITH, IPHONE_HEIGHT);
        
      //根据传过来的图片数组的个数，来初始化scrollView的个数
        
        for (int i = 0; i<pics.count; i++)
        {
            
            UIScrollView *smallScr = [[UIScrollView alloc]initWithFrame:CGRectMake(i*IPHONE_WITH, 0, IPHONE_WITH, IPHONE_HEIGHT)];
            smallScr.contentSize = CGSizeMake(IPHONE_WITH, IPHONE_HEIGHT);
            smallScr.delegate = self;
            smallScr.showsHorizontalScrollIndicator = NO;
            smallScr.showsVerticalScrollIndicator = NO;
            smallScr.minimumZoomScale = 1.0f;  //缩小的倍数设置
            smallScr.maximumZoomScale = 2.0f; //放大的倍数设置
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WITH, IPHONE_HEIGHT)];
            imageView.image = pics[i];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeImageViewWithTap:)];
            [smallScr addGestureRecognizer:tap];
            
            [smallScr addSubview:imageView];
            [self addSubview:smallScr];
        }
        
//        根据小视图的偏移量设置大视图的偏移量
        self.contentOffset = CGPointMake(picOffSet*IPHONE_WITH, 0);
        
    }
    return self;
}
-(void)removeImageViewWithTap:(UITapGestureRecognizer *)sender
{
   

//    block回传
    _offSet(self.contentOffset.x/IPHONE_WITH);
    
    
//    另外的方法之代理实现回传值
//    if (_TouchDelegate!=nil&&[_TouchDelegate respondsToSelector:@selector(changeTheSmallPicScroViewOffSet:)])
//    {
//        [_TouchDelegate changeTheSmallPicScroViewOffSet:self.contentOffset.x/IPHONE_WITH];
//    }
//    
    
//    动画设置大视图消失
    
    [UIView animateWithDuration:0.1 animations:^{
        self.transform = CGAffineTransformMakeScale(0.01, 0.1);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    
    
    
}

//实现放大缩小的代理方法
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    for (UIView *vi in scrollView.subviews)
    {
        return vi;
    }
    return nil;
    
}
//当滑动的时候，设置原来放大图片缩小为原来的尺寸

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if (scrollView ==self)
    {
        for (UIScrollView *s in scrollView.subviews)
        {
            if ([s isKindOfClass:[UIScrollView class]])
            {
                [s setZoomScale:1.0f];
//                UIImageView *imgView = [[s subviews]objectAtIndex:0];
//                imgView.frame = CGRectMake(0, 0, IPHONE_WITH, IPHONE_HEIGHT);
                
            }
            
        }
    }
    
}

@end














