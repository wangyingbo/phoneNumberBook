//
//  SearchConfirmView.m
//  Kergou
//
//  Created by JiaPin on 15/10/13.
//  Copyright (c) 2015年 张帅. All rights reserved.
//
#import "SearchConfirmModel.h"
#import "SearchConfirmView.h"

@implementation SearchConfirmView
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.btnMArr = [[NSMutableArray alloc]initWithCapacity:0];
        self.IMVMArr = [[NSMutableArray alloc]initWithCapacity:0];
        self.countryNameArr = [[NSMutableArray alloc]initWithCapacity:0];
        self.countryIDArr = [[NSMutableArray alloc]initWithCapacity:0];
       
        
        
    }
    return self;
}
-(void)configureDataWithArr:(NSArray *)arr

{
    for (NSDictionary *dic in arr)
    {
         JPLog(@"----name   ==== %@  ",[dic objectForKey:@"country"]);
        
        JPLog(@"----id   ==== %@  ",[dic objectForKey:@"country_id"]);
        
        
        [self.countryNameArr addObject:[dic objectForKey:@"country"]];
        [self.countryIDArr addObject:[dic objectForKey:@"country_id"]];
    }
 
     [self initViews];
}
-(void)initViews
{
    
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, -10,IPHONE_WITH, 35*_countryNameArr.count-10)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    
    for (int i = 0; i<_countryNameArr.count; i++)
    {
        NSInteger k = (35*_countryNameArr.count -_countryNameArr.count*15)/(_countryNameArr.count+1);
        UIButton *nationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [nationBtn setTitle:_countryNameArr[i] forState:UIControlStateNormal];
        [nationBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [nationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [nationBtn addTarget:self action:@selector(choseNationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        nationBtn.tag = i+10086;
        nationBtn.frame = CGRectMake([PublicMethod PictureViewAdaptHeight:39],k*(i+1)+15*i,IPHONE_WITH-20, 15);
        nationBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        nationBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        nationBtn.titleLabel.font = [UIFont fontWithName:nil size:13];
        
        if (i!=_countryNameArr.count-1)
        {
            UIView *lineView = [PublicMethod getLineViewWithFrame:CGRectMake([PublicMethod PictureViewAdaptHeight:39],k*(i+1)+15*i+20, IPHONE_WITH, 0.5)];
            [headerView addSubview:lineView];
        }
        
        [self.btnMArr addObject:nationBtn];
        
        [headerView addSubview:nationBtn];
        
        UIImageView *rightIMV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"gou.png"]];
        rightIMV.frame = CGRectMake(IPHONE_WITH-20,k*(i+1)+15*i, 11, 10);
        rightIMV.hidden = YES;
        if (i==0)
        {
            nationBtn.selected = YES;
            rightIMV.hidden = NO;
        }
        [self.IMVMArr addObject:rightIMV];
        [headerView addSubview:rightIMV];
    }
    
    UIView *btmVi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WITH, IPHONE_HEIGHT)];
    btmVi.backgroundColor = [UIColor blackColor];
    
    btmVi.alpha = 0.3;
    [self addSubview:btmVi];
    
    
    [self addSubview:headerView];
    

}
-(void)choseNationBtnClick:(UIButton *)sender
{
    for (UIImageView *imageView in _IMVMArr)
    {
        imageView.hidden = YES;
    }
    
    UIImageView *IMV = (UIImageView *)_IMVMArr[sender.tag-10086];
    IMV.hidden = NO;
    for (UIButton *btn in _btnMArr)
    {
        btn.selected = NO;
    }
    sender.selected = YES;
 
    
    if (_delegate&&[_delegate respondsToSelector:@selector(ChoseNationBtnClick:)])
    {
        [self.delegate ChoseNationBtnClick:[_countryIDArr objectAtIndex:sender.tag - 10086]];
    }
    
}



@end
