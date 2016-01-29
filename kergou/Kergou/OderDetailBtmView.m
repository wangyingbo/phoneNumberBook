//
//  OderDetailBtmView.m
//  Kergou
//
//  Created by JiaPin on 15/9/28.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "OderDetailBtmView.h"

@implementation OderDetailBtmView

-(id)initWithFrame:(CGRect)frame withStateNum:(NSInteger)stateNum
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        UIView *lineView  =  [PublicMethod getLineViewWithFrame:CGRectMake(0, 0.5, IPHONE_WITH, 0.5)];
        [self addSubview:lineView];
      
        
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftBtn.layer setMasksToBounds:YES];
        [leftBtn.layer setCornerRadius:5.0];
        [leftBtn.layer setBorderWidth:2.0];
        [leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        leftBtn.layer.borderColor = UIColorFromOXRGB(0x27e0c6).CGColor;
        leftBtn.frame = CGRectMake([PublicMethod PictureViewAdaptHeight:60], 16, 101, 33);
        [leftBtn setTitleColor: UIColorFromOXRGB(0x27e0c6) forState:UIControlStateNormal];
        leftBtn.titleLabel.font  = [UIFont fontWithName:nil size:14];
        [leftBtn setTitle:@"查看物流" forState:UIControlStateNormal];
        
     
        
        
        
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightBtn.layer setMasksToBounds:YES];
        [rightBtn.layer setCornerRadius:5.0];
         [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
         rightBtn.titleLabel.font  = [UIFont fontWithName:nil size:14];
        [rightBtn setBackgroundColor:UIColorFromOXRGB(0x27e0c6)];
        rightBtn.frame = CGRectMake(IPHONE_WITH-101-[PublicMethod PictureViewAdaptHeight:60], 16, 101, 33);
        [rightBtn setTintColor:[UIColor whiteColor]];
        [rightBtn setTitle:@"再次购买" forState:UIControlStateNormal];
        if (stateNum == 20000)
        {
            [leftBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            [leftBtn setTitleColor: UIColorFromOXRGB(0xff542d) forState:UIControlStateNormal];
            leftBtn.layer.borderColor = UIColorFromOXRGB(0xff542d).CGColor;
            [rightBtn setTitle:@"立即支付" forState:UIControlStateNormal];
            [rightBtn setBackgroundColor:UIColorFromOXRGB(0xff542d)];
            
        }
        if (stateNum ==20002)
        {
            leftBtn.hidden = YES;
            rightBtn.frame = CGRectMake((IPHONE_WITH-101)/2, 16, 101, 33);
            
        }
        
        [self addSubview:rightBtn];
        [self addSubview:leftBtn];
       
    }
    return self;
}
-(void)leftBtnClick:(UIButton *)sender
{
    if (_delegate&&[_delegate respondsToSelector:@selector(checkTransportInfoBtnClick)]) {
        [self.delegate checkTransportInfoBtnClick];
    }

    
}
-(void)rightBtnClick:(UIButton *)sender
{
    if (_delegate&&[_delegate respondsToSelector:@selector(checkTransportInfoBtnClick)]) {
        [self.delegate oneMoreTimeBuy];
    }

}
@end
