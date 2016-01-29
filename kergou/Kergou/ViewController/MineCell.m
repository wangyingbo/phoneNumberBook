//
//  MineCell.m
//  Kergou
//
//  Created by JiaPin on 15/10/9.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "MineCell.h"




@implementation MineCell



- (void)awakeFromNib
{
    [self  initViews];
    
}
-(void)initViews
{
    float y = self.normalImView.frame.origin.y+self.normalImView.frame.size.height;
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, y+14, IPHONE_WITH, 0.3)];
    lineView.backgroundColor = UIColorFromOXRGB(0xdddddd);
    [self addSubview:lineView];
    
    float k = (IPHONE_WITH - 33*4)/5;

    for (int i = 0; i<4; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(k*(i+1)+33*i,y+23 , 33, 42);
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",1000+i]] forState:UIControlStateNormal];
        btn.tag = 20000+i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        
        
        UIButton *littleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        littleBtn.frame = CGRectMake(k*(i+1)+33*i+30,y+23-3 ,12, 12);
        [littleBtn.layer setMasksToBounds:YES];
        [littleBtn.layer setCornerRadius:6];
        littleBtn.titleLabel.font = [UIFont fontWithName:nil size:10];
        [littleBtn setTitle:@"2" forState:UIControlStateNormal];
        [littleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        littleBtn.backgroundColor = UIColorFromOXRGB(0xef703c);
        
        
       
        [self addSubview:btn];
        [self addSubview:littleBtn];
        
    }

}
-(void)btnClick:(UIButton *)sender
{
    if (_delegate&&[_delegate respondsToSelector:@selector(oderDetailBtnClick:)])
    {
        [self.delegate oderDetailBtnClick:sender.tag];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
