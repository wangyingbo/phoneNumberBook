//
//  CheckOutTipsView.m
//  Kergou
//
//  Created by JiaPin on 15/10/19.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "CheckOutTipsView.h"

@implementation CheckOutTipsView
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
       
        _bgView = [[UIView alloc]initWithFrame:frame];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        
        [self addSubview:_bgView];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapToCancleView)];
        [_bgView addGestureRecognizer:tap];
        
        [self initViews];
        
    }
        return self;
}
-(void)initViews
{
    
    UIView *centerView = [[UIView alloc]init];
    centerView.frame = CGRectMake(0, 0, 592/2, 230);
    centerView.backgroundColor = [UIColor whiteColor];
    centerView.center = self.center;
    centerView.userInteractionEnabled = YES;
    
    UILabel *tipsLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 11, 592/2-20,34)];
    tipsLab.textAlignment = NSTextAlignmentLeft;
    tipsLab.lineBreakMode = NSLineBreakByTruncatingTail;
    tipsLab.numberOfLines = 2;
    tipsLab.font = FONT_SIZE(14);
    tipsLab.text = @"夜空中最亮的星，是否在意，是等太阳升起，还是意外先来临";
    [centerView addSubview:tipsLab];
    
    UIView *lineView1 = [PublicMethod getLineViewWithFrame:CGRectMake(10, 102/2, 592/2-20, 0.5)];
    [centerView addSubview:lineView1];
    
    
    
    self.headerBtn = [PublicMethod buttonAddsuperview_superView:centerView _subViewFrame:CGRectMake(26/2, lineView1.frame.origin.y+15, 35/2, 35/2) _tag:self _action:@selector(changeHeaderImageBtnClick:) _string:nil _imageName:nil];
    [self.headerBtn setBackgroundImage:[UIImage imageNamed:@"nidaye.png"] forState:UIControlStateNormal];
    [self.headerBtn setBackgroundImage:[UIImage imageNamed:@"weixuanzhonggouwuche.png"] forState:UIControlStateSelected];
    
    
    
    [PublicMethod lableViewAddsuperview_superView:centerView _subViewFrame:CGRectMake(40,  lineView1.frame.origin.y+15, 150/2, 14) _string:@"海外购商品" _lableFont:FONT_SIZE(14) _lableTxtColor:nil _textAlignment:NSTextAlignmentLeft];
    
    [PublicMethod lableViewAddsuperview_superView:centerView _subViewFrame:CGRectMake(40,  lineView1.frame.origin.y+33, 60/2, 14) _string:@"1件" _lableFont:FONT_SIZE(12) _lableTxtColor:[UIColor lightGrayColor] _textAlignment:NSTextAlignmentLeft];
    
    
    
    
    UIView *lineView2 = [PublicMethod getLineViewWithFrame:CGRectMake(10, 214/2, 592/2-20, 0.5)];
    [centerView addSubview:lineView2];
    
    
    
    
    self.headerBtn2 = [PublicMethod buttonAddsuperview_superView:centerView _subViewFrame:CGRectMake(26/2, lineView2.frame.origin.y+14, 35/2, 35/2) _tag:self _action:@selector(changeHeaderImageBtnClick2:) _string:nil _imageName:nil];
    [self.headerBtn2 setBackgroundImage:[UIImage imageNamed:@"weixuanzhonggouwuche.png"] forState:UIControlStateNormal];
    [self.headerBtn2 setBackgroundImage:[UIImage imageNamed:@"nidaye.png"] forState:UIControlStateSelected];
    
    
    
    
    [PublicMethod lableViewAddsuperview_superView:centerView _subViewFrame:CGRectMake(40,  lineView2.frame.origin.y+15, 136/2, 14) _string:@"其他商品" _lableFont:FONT_SIZE(14) _lableTxtColor:nil _textAlignment:NSTextAlignmentLeft];
    [PublicMethod lableViewAddsuperview_superView:centerView _subViewFrame:CGRectMake(40,  lineView2.frame.origin.y+35,60/2, 14) _string:@"3件" _lableFont:FONT_SIZE(12) _lableTxtColor:[UIColor lightGrayColor] _textAlignment:NSTextAlignmentLeft];
    
    
    
    UIButton *backShopCarBtn = [PublicMethod buttonAddsuperview_superView:centerView _subViewFrame:CGRectMake(30, 338/2, 210/2, 35) _tag:self _action:@selector(backShopCarBtnClick:) _string:nil _imageName:nil];
    [backShopCarBtn.layer setMasksToBounds:YES];
    [backShopCarBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [backShopCarBtn.layer setCornerRadius:2];
    [backShopCarBtn setBackgroundImage:[UIImage imageNamed:@"jiaru.png"] forState:UIControlStateNormal];
    backShopCarBtn.titleLabel.font = FONT_SIZE(14);
    [backShopCarBtn.layer setBorderWidth:1];
    [backShopCarBtn.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
    
    
    UIButton *checkOutBtn = [PublicMethod buttonAddsuperview_superView:centerView _subViewFrame:CGRectMake(centerView.frame.size.width-210/2-60/2, 338/2, 210/2, 35) _tag:self _action:@selector(checkOutBtnClick:) _string:nil _imageName:nil];
    [checkOutBtn setBackgroundColor:[UIColor cyanColor]];
    
    [checkOutBtn setBackgroundImage:[UIImage imageNamed:@"jiesuanxiaozi.png"] forState:UIControlStateNormal];
    
    
    [_bgView addSubview:centerView];

}
-(void)changeHeaderImageBtnClick:(UIButton *)sender
{
    self.headerBtn.selected = NO;
    self.headerBtn2.selected = NO;
}
-(void)changeHeaderImageBtnClick2:(UIButton *)sender
{
    self.headerBtn.selected = YES;
    self.headerBtn2.selected = YES;
    
}
-(void)backShopCarBtnClick:(UIButton *)sender
{
    if (_delegate&&[_delegate respondsToSelector:@selector(backShopCar)])
    {
        [self.delegate backShopCar];
    }

}
-(void)checkOutBtnClick:(UIButton *)sender
{
    if (_delegate&&[_delegate respondsToSelector:@selector(gotoCheckOut)])
    {
        [self.delegate gotoCheckOut];
    }
}
-(void)TapToCancleView
{
    if (_delegate&&[_delegate respondsToSelector:@selector(TapClickToCancleView)])
    {
        [self.delegate TapClickToCancleView];
    }
}
@end
