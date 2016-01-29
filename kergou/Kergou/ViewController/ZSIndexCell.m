//
//  ZSIndexCell.m
//  Kergou
//
//  Created by JiaPin on 15/9/16.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "ZSIndexCell.h"

@implementation ZSIndexCell


- (void)awakeFromNib
{
    self.backgroundColor = UIColorFromOXRGB(0xf4f4f4);
    
    [self initView];
    [self addTapGesture];
    
    
}
-(void)addTapGesture
{
    self.cellGoodsImageView1.userInteractionEnabled = YES;
    self.cellGoodsImageView2.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapImageView1:)];
    [self.cellGoodsImageView1 addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapImageView2:)];
    [self.cellGoodsImageView2 addGestureRecognizer:tap2];
    
    
}
-(void)initView
{
    
    [self.cellGoodsImageView1.layer setBorderWidth:0.5];
    [self.cellGoodsImageView1.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
    [self.cellGoodsImageView2.layer setBorderWidth:0.5];
    [self.cellGoodsImageView2.layer setBorderColor:[UIColor lightGrayColor].CGColor];

    self.lineHeight.constant = 0.5;
    self.lineHeight2.constant = 0.5;
    
    
    self.priceLab1.textColor = UIColorFromOXRGB(0xef7b49);
    self.priceLab2.textColor = UIColorFromOXRGB(0xef7b49);

    self.beforePriceLab1.textColor = UIColorFromOXRGB(0xb1b1b1);
    self.beforePriceLab2.textColor = UIColorFromOXRGB(0xb1b1b1);
    
    
    
}
-(void)configureCellWithDataModel:(IndexPageCategoryModel *)model withNumCell:(NSInteger)num
{
    if (num == 0)
    {
        self.describLab1.text = model.goods_name;
        
        self.priceLab1.text = [NSString stringWithFormat:@"￥%@",model.sale_price];
        self.priceLab1.textColor = UIColorFromOXRGB(0xef7b49);
        
        self.beforePriceLab1.text = [NSString stringWithFormat:@"￥%@",model.market_price];
        self.beforePriceLab1.textColor = UIColorFromOXRGB(0xb1b1b1);
        [self.goodsImageView1 setImageWithURL:[NSURL URLWithString:model.main_picture_230] placeholderImage:[UIImage imageNamed:@"loading.png"]];
    }
    else
    {
        self.describeLab2.text = model.goods_name;
        self.priceLab2.text = [NSString stringWithFormat:@"￥%@",model.sale_price];
        self.priceLab2.textColor = UIColorFromOXRGB(0xef7b49);
        
        self.beforePriceLab2.text = [NSString stringWithFormat:@"￥%@",model.market_price];
        self.beforePriceLab2.textColor = UIColorFromOXRGB(0xb1b1b1);
        [self.goodsImageView2 setImageWithURL:[NSURL URLWithString:model.main_picture_230] placeholderImage:[UIImage imageNamed:@"loading.png"]];
    }
    
    self.lineViewConstant1.constant = _beforePriceLab1.frame.size.width;
    self.lineViewConstant2.constant = _beforePriceLab2.frame.size.width;
    self.lineViewHeightConstant1.constant = 0.5;
    self.lineViewHeightConstant2.constant = 0.5;
    
    
//    
//    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(_beforePriceLab1.frame.origin.x+20,_beforePriceLab1.frame.origin.y+_beforePriceLab1.frame.size.height/2,_beforePriceLab1.frame.size.width, 0.5)];
//    lineView1.backgroundColor = [UIColor lightGrayColor];
//    
//    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(_beforePriceLab2.frame.origin.x+20,_beforePriceLab2.frame.origin.y+_beforePriceLab2.frame.size.height/2,_beforePriceLab2.frame.size.width, 0.5)];
//    
//    lineView2.backgroundColor = [UIColor lightGrayColor];
//    
//    [self.lineViewBgView addSubview:lineView1];
//    [self.lineViewBgView addSubview:lineView2];

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
