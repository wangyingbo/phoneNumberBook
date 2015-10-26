//
//  CheckOutCell.m
//  Kergou
//
//  Created by JiaPin on 15/9/28.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "CheckOutCell.h"

@implementation CheckOutCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
       
       
    }
    return self;
}
-(void)configureViewWithBtnStatuesStr:(NSString *)stateStr
{
    self.stationStr = stateStr;
    
    [self initViews];
    [self wanShanView];
    [self initButtonView];
}
-(void)initViews
{
    self.goodsNumLab = [PublicMethod lableViewAddsuperview_superView:self _subViewFrame:CGRectMake(IPHONE_WITH-213, 15, 90, 18) _string:nil _lableFont:FONT_SIZE(14) _lableTxtColor:nil _textAlignment:NSTextAlignmentLeft];
    self.goodsPriceLab = [PublicMethod lableViewAddsuperview_superView:self _subViewFrame:CGRectMake(IPHONE_WITH-210/2, 15, 185/2, 18) _string:nil _lableFont:FONT_SIZE(14) _lableTxtColor:nil _textAlignment:NSTextAlignmentLeft];

    
}
-(void)initButtonView
{
    
    self.leftBtn  = [PublicMethod buttonAddsuperview_superView:self _subViewFrame:CGRectMake(IPHONE_WITH-236, 45, 100, 32) _tag:self _action:@selector(leftBtnClick:) _string:@"取消订单" _imageName:nil];
    self.leftBtn.titleLabel.font = FONT_SIZE(14);
    
    
    [self.leftBtn.layer setMasksToBounds:YES];
    [self.leftBtn.layer setCornerRadius:4];
    [self.leftBtn.layer setBorderWidth:2];
    [self.leftBtn.layer setBorderColor:UIColorFromOXRGB(0xff542d).CGColor];
    [self.leftBtn setTitleColor:UIColorFromOXRGB(0xff542d) forState:UIControlStateNormal];
    [self.leftBtn setBackgroundColor:[UIColor clearColor]];
    
    
    self.rightBtn = [PublicMethod buttonAddsuperview_superView:self _subViewFrame:CGRectMake(IPHONE_WITH-235/2, 45, 100, 32) _tag:self _action:@selector(rightBtnClick:) _string:@"再次购买" _imageName:nil];
    self.rightBtn.titleLabel.font = FONT_SIZE(14);
    
    [self.rightBtn.layer setMasksToBounds:YES];
    [self.rightBtn.layer setCornerRadius:4];
    [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.rightBtn setBackgroundColor:UIColorFromOXRGB(0x27e0c6)];
    

    if ([_stationStr isEqualToString:@"1"])
    {
        self.leftBtn.hidden = YES;
    
    }
    
    if ([_stationStr isEqualToString:@"2"])
    {
      
        [self.rightBtn setBackgroundColor:UIColorFromOXRGB(0xff542d)];
        [self.rightBtn setTitle:@"立即支付" forState:UIControlStateNormal];
        self.leftBtn.hidden = NO;
        
        
        
    }
    
    
    
}
-(void)wanShanView
{
    UIView *lineView = [PublicMethod getLineViewWithFrame:CGRectMake(0, 90.5, IPHONE_WITH, 0.5)];
    [self addSubview:lineView];
    
    NSMutableAttributedString *goodsNumStr = [PublicMethod getColourfulLableWithColor:UIColorFromOXRGB(0xff542d) withString:@"共1件商品" withRange:NSMakeRange(1,1)];
    
    NSMutableAttributedString * goodsPriceStr = [PublicMethod getColourfulLableWithColor:UIColorFromOXRGB(0xff542d) withString:@"合计:¥90.0" withRange:NSMakeRange(3,5)];
    
    self.goodsNumLab.attributedText = goodsNumStr;
    self.goodsPriceLab.attributedText = goodsPriceStr;
}
-(void)leftBtnClick:(UIButton *)sender
{
    
}
-(void)rightBtnClick:(UIButton *)sender
{
    if (_delegate&&[_delegate respondsToSelector:@selector(rightBtnPayClick)])
    {
        [_delegate rightBtnPayClick];
    }
  
}
@end
