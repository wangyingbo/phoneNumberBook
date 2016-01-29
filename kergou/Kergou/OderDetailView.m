//
//  OderDetailView.m
//  Kergou
//
//  Created by JiaPin on 15/9/28.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "OderDetailView.h"

@implementation OderDetailView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        self.backgroundColor = [UIColor whiteColor];
        UIView *vi1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WITH, 110)];
        vi1.backgroundColor = UIColorFromOXRGB(0xc7f3ed);
        
        
        NSArray *arr = @[@"订单状态：待收货",@"订单号：9958863941",@"下单时间：2015-08-31 14:20",@"支付方式：支付宝"];
        
        
        for (int i = 0; i<arr.count; i++)
        {
            
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 6*(i+1)+20*i, 250, 18)];
           
            lab.textAlignment = NSTextAlignmentLeft;
            lab.text = arr[i];
            if (i==0)
            {
                lab.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:16];
            }
            else
            {
            lab.font = [UIFont fontWithName:nil size:14];
            }
            [vi1 addSubview:lab];
            
        }
        
        UIView *vi2 =[[UIView alloc]initWithFrame:CGRectMake(0, 113, IPHONE_WITH, 60)];
        vi2.backgroundColor = UIColorFromOXRGB(0xfffacd);

        
        UILabel *tellab = [[UILabel alloc]initWithFrame:CGRectMake(15, 12, 250, 20)];
        tellab.text = @"你会不会忽然的出现，在街角的咖啡店";
        tellab.font = [UIFont fontWithName:nil size:14];
        tellab.textColor = UIColorFromOXRGB(0xff542d);
        tellab.textAlignment = NSTextAlignmentLeft;
        [vi2 addSubview:tellab];
        
        UILabel *Adresslab = [[UILabel alloc]initWithFrame:CGRectMake(15,32, 250, 20)];
        Adresslab.text = @"你会不会忽然的出现，在街角的咖啡店";
        Adresslab.font = [UIFont fontWithName:nil size:14];
//        Adresslab.textColor = UIColorFromOXRGB(0xff542d);
        Adresslab.textAlignment = NSTextAlignmentLeft;
        [vi2 addSubview:Adresslab];
        
        [self addSubview:vi1];
        [self addSubview:vi2];
        
        
        
        UILabel *goodsLab = [[UILabel alloc]initWithFrame:CGRectMake(15,186, 250, 20)];
        
        goodsLab.text = @"商品信息";
        goodsLab.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:15];
        goodsLab.textAlignment = NSTextAlignmentLeft;
        [self addSubview:goodsLab];


        
        
    }
    return self;
}

@end
