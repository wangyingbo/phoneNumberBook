
//
//  CheckOutView.m
//  Kergou
//
//  Created by JiaPin on 15/10/13.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "CheckOutView.h"

@implementation CheckOutView
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = UIColorFromOXRGB(0xf8f8f8);
        
        
        UILabel *shouldpayLab = [[UILabel alloc]initWithFrame:CGRectMake(8, 17, 124/2, 15)];
        shouldpayLab.text = @"应付总额:";
        shouldpayLab.font = [UIFont fontWithName:nil size:14];
        
        UILabel *moneyLab = [[UILabel alloc]initWithFrame:CGRectMake(8+124/2+2, 17, 124/2, 15)];
        moneyLab.text = @"¥119.0";
        moneyLab.textColor = UIColorFromOXRGB(0xef703d);
        
        
        [self addSubview:shouldpayLab];
        [self addSubview:moneyLab];
        
        
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        rightBtn.titleLabel.font  = [UIFont fontWithName:nil size:14];
        [rightBtn setBackgroundColor:UIColorFromOXRGB(0xef703d)];
        rightBtn.frame = CGRectMake(IPHONE_WITH-123+13,0, 110,50);
        [rightBtn setTintColor:[UIColor whiteColor]];
        [rightBtn setTitle:@"提交订单" forState:UIControlStateNormal];
        
        
        [self addSubview:rightBtn];
       
        
    }
    return self;
}

-(void)rightBtnClick:(UIButton *)sender
{
    if (_delegate&&[_delegate respondsToSelector:@selector(sendOrderBtnClick)]) {
        [self.delegate sendOrderBtnClick];
    }
   
   
}




@end
