//
//  GoodsDetailView.m
//  Kergou
//
//  Created by JiaPin on 15/10/12.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#define ADD_SHOP_CAR_URL @"/order/cartAdd"
#import "GoodsDetailView.h"


@implementation GoodsDetailView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _countNum = 0;
        self.backgroundColor = UIColorFromOXRGB(0xffffff);
        
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        rightBtn.titleLabel.font  = [UIFont fontWithName:nil size:14];
        [rightBtn setBackgroundColor:UIColorFromOXRGB(0xef703d)];
        rightBtn.frame = CGRectMake(IPHONE_WITH-123+13,8, 100, 35);
        [rightBtn setTintColor:[UIColor whiteColor]];
        [rightBtn setTitle:@"加入购物车" forState:UIControlStateNormal];

        
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [leftBtn setBackgroundColor:UIColorFromOXRGB(0x22c1ab)];
       
        leftBtn.frame = CGRectMake(IPHONE_WITH-244+13, 8, 100, 35);
        [leftBtn setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
        leftBtn.titleLabel.font  = [UIFont fontWithName:nil size:14];
        [leftBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        
        
        UIButton *carBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        carBtn.frame = CGRectMake(29, 12, 22, 22);
        [carBtn setBackgroundImage:[UIImage imageNamed:@"xiaogouwuche.png"] forState:UIControlStateNormal];
        
        [carBtn addTarget:self action:@selector(gotoShopCarVcClick:) forControlEvents:UIControlEventTouchUpInside];
       
        
        [self addSubview:carBtn];
        [self addSubview:rightBtn];
        [self addSubview:leftBtn];
        
    }
    return self;
}
-(void)configureBtmViewWithModel:(GoodsDetailStockModel *)model
{
    self.Model = model;
}
-(void)gotoShopCarVcClick:(UIButton *)sender
{
    if (_delegate&&[_delegate respondsToSelector:@selector(gotoShopCarVC)]) {
        [self.delegate   gotoShopCarVC];
    }

   
    
    
    
    NSMutableDictionary *postMDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    
    [postMDic setObject:_Model.id forKey:@"sku_id"];
    [postMDic setObject:_Model.goods_id forKey:@"goods_id"];
    [postMDic setObject:[NSString stringWithFormat:@"%d",_countNum] forKey:@"num"];
    [postMDic setObject:@"52" forKey:@"user_id"];
    [postMDic setObject:@"" forKey:@"session_id"];
    [postMDic setObject:@"0" forKey:@"one"];
    
    [NetWorkRequest PostDataViewController:self BaseUrl:BASEURL_GOODS Funtioname:ADD_SHOP_CAR_URL Parameter:postMDic Success:^(id responseObject)
    {
        
        
        
    } LoadFailed:^(NSError *error) {
        
    } haveNONetWork:^{
        
    }];
    
    
    
}
-(void)leftBtnClick:(UIButton *)sender
{
  
    if (_delegate&&[_delegate respondsToSelector:@selector(buyRightNow)]) {
        [self.delegate buyRightNow];
    }

}
-(void)rightBtnClick:(UIButton *)sender
{
    _countNum++;
    if (_delegate&&[_delegate respondsToSelector:@selector(addShopCarBtnClick)]) {
        [self.delegate addShopCarBtnClick];
    }
}


@end
