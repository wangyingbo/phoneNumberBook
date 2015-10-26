//
//  cancleOrderView.m
//  Kergou
//
//  Created by JiaPin on 15/9/28.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "cancleOrderView.h"

@implementation cancleOrderView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor orangeColor];
        [self initBottomView];
        
    }
    return self;
}
-(void)initBottomView
{
   
    NSArray *resonBtnTitleArr = @[@"不想要了",@"支付不成功",@"价格较贵",@"拍错了",@"订单信息填写错误",@"其他"];
    UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0,0, IPHONE_WITH,325)];
    
    for (int i=0; i<resonBtnTitleArr.count; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 54*i, IPHONE_WITH, 54);
        [btn setTitle:resonBtnTitleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.selected = YES;
        btn.tag = 2000+i;
        btn.titleLabel.font = [UIFont fontWithName:nil size:14];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [vi addSubview:btn];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0,53*i , IPHONE_WITH,0.3)];
        lineView.backgroundColor = UIColorFromOXRGB(0xdddddd);
        [vi addSubview:lineView];
        
    }
    
    [self addSubview:vi];
    
    UIView *btmVi = [[UIView alloc]initWithFrame:CGRectMake(0,325, IPHONE_WITH, 65)];
    btmVi.backgroundColor = [UIColor whiteColor];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn.layer setMasksToBounds:YES];
    [closeBtn.layer setCornerRadius:5.0];
    [closeBtn.layer setBorderWidth:1.0];
    [closeBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.layer.borderColor = UIColorFromOXRGB(0x27e0c6).CGColor;
    closeBtn.frame = CGRectMake([PublicMethod PictureViewAdaptHeight:60], 16, 101, 33);
    [closeBtn setTitleColor: UIColorFromOXRGB(0x27e0c6) forState:UIControlStateNormal];
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    
    UIButton *finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [finishBtn.layer setMasksToBounds:YES];
    [finishBtn.layer setCornerRadius:5.0];
    [finishBtn addTarget:self action:@selector(finishBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [finishBtn setBackgroundColor:UIColorFromOXRGB(0x27e0c6)];
    finishBtn.frame = CGRectMake(IPHONE_WITH-101-[PublicMethod PictureViewAdaptHeight:60], 16, 101, 33);
    [finishBtn setTintColor:[UIColor whiteColor]];
    [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    
    [btmVi addSubview:closeBtn];
    [btmVi addSubview:finishBtn];
    [self addSubview:btmVi];
    
    
}
-(void)btnClick:(UIButton *)sender
{
    
}
-(void)closeBtnClick:(UIButton *)sender
{
    
}
-(void)finishBtnClick:(UIButton *)sender
{
    
}
@end
