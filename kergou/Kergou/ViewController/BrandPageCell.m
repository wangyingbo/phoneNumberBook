//
//  BrandPageCell.m
//  Kergou
//
//  Created by JiaPin on 15/10/14.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "BrandPageCell.h"

@implementation BrandPageCell

- (void)awakeFromNib
{
    self.backgroundColor = UIColorFromOXRGB(0xf8f8f8);
    [self.cellBgImageView1.layer setBorderWidth:0.5];
    [self.cellBgImageView1.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.cellBgImageView2.layer setBorderWidth:0.5];
    [self.cellBgImageView2.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
    
    
    [self addTapGesture];
    
    
}
-(void)addTapGesture
{
    self.cellBgImageView1.userInteractionEnabled = YES;
    self.cellBgImageView2.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapImageView1:)];
    [self.cellBgImageView1 addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapImageView2:)];
    [self.cellBgImageView2 addGestureRecognizer:tap2];
}
-(void)TapImageView1:(UITapGestureRecognizer *)tap
{
    if (_delegate && [_delegate respondsToSelector:@selector(gotoGoodsDetailVC)] )
    {
        [self.delegate gotoGoodsDetailVC];
    }
    
    
    
    
}
-(void)TapImageView2:(UITapGestureRecognizer *)tap
{
    if (_delegate && [_delegate respondsToSelector:@selector(gotoGoodsDetailVC)] )
    {
        [self.delegate gotoGoodsDetailVC];
    }
    
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
