//
//  ShoppingCarCell.m
//  Kergou
//
//  Created by JiaPin on 15/9/22.
//  Copyright (c) 2015年 张帅. All rights reserved.
//
#import "ShopCarListModel.h"

#import "ShoppingCarCell.h"

#define JIAN_GOODS_URL @"/order/cartOperate"

@interface ShoppingCarCell()

{
    NSInteger goodsNum;
}
@property (nonatomic,strong)ShopCarListModel *Model;
@end
@implementation ShoppingCarCell

- (void)awakeFromNib
{
   
}
-(void)configureCellWithModel:(ShopCarListModel *)model
{
    self.Model = model;
    [self.numLab.layer  setBorderWidth:0.5];
    [self.numLab.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    goodsNum = model.amount;
    
    self.backgroundColor = UIColorFromOXRGB(0xf8f8f8);
    UIView *lineView = [PublicMethod getLineViewWithFrame:CGRectMake(10, 137.5, IPHONE_WITH, 0.5)];
    [self addSubview:lineView];
    
    self.loseFunBtn.userInteractionEnabled = NO;
    
    self.numLab.text = [NSString stringWithFormat:@"%d",model.amount];
    
    self.goodsDescribeLab.text = model.goods_name;
    
    self.goodsPriceLab.text = [NSString stringWithFormat:@"¥%@",model.goods_price];
    
    self.goodsImageIMV.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.image]]];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)jianBtnClick:(id)sender
{
    if (goodsNum==1)
    {
        [self.jianBtn setImage:[UIImage imageNamed:@"jianhaohui.png"] forState:UIControlStateNormal];
        self.jianBtn.userInteractionEnabled = NO;
    }
    else
    {
   
    goodsNum--;
    self.numLab.text = [NSString stringWithFormat:@"%d",goodsNum];
     
        NSMutableDictionary *postMDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        [postMDic setObject:_Model.sku_id forKey:@"sku_id"];
        [postMDic setObject:_Model.goods_id forKey:@"goods_id"];
        [postMDic setObject:[NSString stringWithFormat:@"%d",goodsNum] forKey:@"num"];
        [postMDic setObject:@"52" forKey:@"user_id"];
        [postMDic setObject:@"" forKey:@"session_id"];
        [postMDic setObject:@"del" forKey:@"operate"];
        
        
     [NetWorkRequest PostDataViewController:self BaseUrl:BASEURL_GOODS Funtioname:JIAN_GOODS_URL Parameter:postMDic Success:^(id responseObject) {
         
         
         
         
         
     } LoadFailed:^(NSError *error) {
         
     } haveNONetWork:^{
        
     }];
        
        
        
        
    }
    
}

- (IBAction)addBtnClick:(id)sender
{
    self.jianBtn.userInteractionEnabled = YES;
    goodsNum++;
    self.numLab.text = [NSString stringWithFormat:@"%d",goodsNum];
    [self.jianBtn setImage:[UIImage imageNamed:@"jianhaohei.png"] forState:UIControlStateNormal];

}
@end
