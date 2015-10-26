//
//  GoodInfoPublicCell.m
//  Kergou
//
//  Created by JiaPin on 15/9/28.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "GoodInfoPublicCell.h"

@implementation GoodInfoPublicCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
   self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self initViews];

    }
    return self;
    
}

-(void)initViews
{
    UIImageView *goodsIMV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"2.png"]];
    
    goodsIMV.frame = CGRectMake(16, 13, 91, 91);
    
    float x = goodsIMV.frame.origin.x;
    float y = goodsIMV.frame.origin.y;
    float width = goodsIMV.frame.size.width;
    UILabel *detailLab = [PublicMethod lableViewAddsuperview_superView:self _subViewFrame:CGRectMake(x+width+15, y, IPHONE_WITH -width-x-30, 28) _string:@"如果有明天祝福你，亲爱的你把爱情给了谁，有没有后悔为你伤悲为你累。" _lableFont:[UIFont fontWithName:nil size:12] _lableTxtColor:nil _textAlignment:NSTextAlignmentLeft];
    detailLab.lineBreakMode = NSLineBreakByTruncatingTail;
    detailLab.numberOfLines = 2;
    
    [PublicMethod lableViewAddsuperview_superView:self _subViewFrame:CGRectMake(x+width+15, 83, 100, 14) _string:@"数量：1" _lableFont:FONT_SIZE(12) _lableTxtColor:nil _textAlignment:NSTextAlignmentLeft];
    
    [PublicMethod lableViewAddsuperview_superView:self _subViewFrame:CGRectMake(IPHONE_WITH-60, 83,46, 14) _string:@"¥90.0" _lableFont:FONT_SIZE(12) _lableTxtColor:UIColorFromOXRGB(0xff542d) _textAlignment:NSTextAlignmentLeft];
    
    
    
    
    
    
    
    
    
    [self addSubview:goodsIMV];
    
    
    
    
}

@end
