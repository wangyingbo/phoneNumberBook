//
//  ShowSmallPicScrollView.m
//  Kergou
//
//  Created by JiaPin on 15/9/2.
//  Copyright (c) 2015年 张帅. All rights reserved.
//



#import "ShowBigPicScrollView.h"
#import "ShowSmallPicScrollView.h"


@interface ShowSmallPicScrollView()<UIScrollViewDelegate>


@property (nonatomic,strong)  NSArray *PictureArr;


@end
@implementation ShowSmallPicScrollView

-(instancetype)initWithFrame:(CGRect)frame withPicArr:(NSArray *)pics
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.PictureArr = pics;
        self.frame = frame;
//        根据传过来的数组的image个数，创建对应的UIImageview，并添加到UISCrollView上
        for (int i = 0; i<pics.count; i++)
        {
            
            
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(IPHONE_WITH*i,0, IPHONE_WITH, frame.size.height)];
            imageView.image = pics[i];
            imageView.tag = 2000+i;
           [self addSubview:imageView];
            
            
           
        }
        self.showsHorizontalScrollIndicator = NO;
        self.contentSize = CGSizeMake(pics.count*IPHONE_WITH, frame.size.height);
        self.delegate = self;
        self.bounces = NO;
        self.pagingEnabled = YES;
        
       
      
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigScrollView:)];
        [self addGestureRecognizer:tap];

        
    }
    return self;
}
-(void)showBigScrollView:(UIGestureRecognizer *)tap
{
    
//    当前scrollView的偏移量
    NSInteger offSet = self.contentOffset.x/IPHONE_WITH;
    
    ShowBigPicScrollView *bigScroll = [[ShowBigPicScrollView alloc]initWithPicArr:_PictureArr withContentOffSet:offSet];
    
//    block函数设置点击大视图消失后的当前小视图的偏移量
    bigScroll.offSet = ^void(NSInteger index)
    {
        self.contentOffset = CGPointMake(index*IPHONE_WITH, 0);
        
        self.pageNum(index);
        
    };

//    代理方法实现设置点击大视图消失后的当前小视图的偏移量
//    bigScroll.TouchDelegate = self;
    if (_delegat&&[_delegat respondsToSelector:@selector(returnScrollView:)]) {
        [self.delegat returnScrollView:bigScroll];
    }
//    [self.superview addSubview:bigScroll];

}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
   NSInteger pageCount = self.contentOffset.x/IPHONE_WITH;
    self.pageNum(pageCount);
    
    
     JPLog(@"----offset = %ld",(long)pageCount);
//    _page.currentPage = pageCount;
//    
//    _page.frame =CGRectMake(pageCount*IPHONE_WITH,self.frame.size.height-20, IPHONE_WITH, 20);
//
    
    
}
//    代理方法实现设置点击大视图消失后的当前小视图的偏移量
//-(void)changeTheSmallPicScroViewOffSet:(NSInteger)offSet
//{
//    self.contentOffset = CGPointMake(offSet*IPHONE_WITH, 0);
//}

@end
