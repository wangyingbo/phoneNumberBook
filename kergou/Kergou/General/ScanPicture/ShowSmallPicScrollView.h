//
//  ShowSmallPicScrollView.h
//  Kergou
//
//  Created by JiaPin on 15/9/2.
//  Copyright (c) 2015年 张帅. All rights reserved.
//
typedef void(^CurrentPageNum)(NSInteger);

#import <UIKit/UIKit.h>
@protocol ShowSmallPicScrollViewDelegate <NSObject>

-(void)returnScrollView:(UIScrollView *)scr;

@end
@interface ShowSmallPicScrollView : UIScrollView
@property (nonatomic,strong)  CurrentPageNum pageNum;
@property (nonatomic,assign)  id<ShowSmallPicScrollViewDelegate>delegat;
//-(void)returnText:(CurrentPageNum)block;
-(instancetype)initWithFrame:(CGRect)frame withPicArr:(NSArray *)pics;
@end
