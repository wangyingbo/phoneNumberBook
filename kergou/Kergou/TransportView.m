//
//  TransportView.m
//  Kergou
//
//  Created by JiaPin on 15/9/29.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "TransportView.h"

@implementation TransportView
-(id)initWithFrame:(CGRect)frame andWithArr:(NSArray *)arr
{
   self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        [self initSomeView];
        
        self.lableArr = arr;
        
    }
    return self;
}
-(void)initSomeView
{
    UILabel *footerlab = [[UILabel alloc]initWithFrame:CGRectMake(13, 14, 60, 20)];
    footerlab.text = @"物流跟踪";
    footerlab.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:15];
    [self addSubview:footerlab];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(13, 0.5f, IPHONE_WITH, 0.5f)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    
    [self addSubview:lineView];
}
- (void)drawRect:(CGRect)rect
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
 

    
    
    /*画线及孤线*/
    //画线
    CGContextSetRGBStrokeColor(context,193/255.0,193/255.0,193/255.0,1.0);//画笔线的颜色
    CGContextSetLineWidth(context, 1.0);//线的宽度
    CGPoint aPoints[2];//坐标点
    aPoints[0] =CGPointMake(28, 47);//坐标1
    aPoints[1] =CGPointMake(28, (_lableArr.count)*47);//坐标2
    //CGContextAddLines(CGContextRef c, const CGPoint points[],size_t count)
    //points[]坐标数组，和count大小
    CGContextAddLines(context, aPoints, 2);//添加线
    CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径
    
    for (int i = 0; i<_lableArr.count; i++)
    {
        
        
        UILabel *infoLab = [[UILabel alloc]initWithFrame:CGRectMake(40, 47*(i+1)-8, 250, 18)];
        infoLab.font = [UIFont fontWithName:nil size:14];
        infoLab.text = _lableArr[i];
        
        UILabel *timeLab = [[UILabel alloc]initWithFrame:CGRectMake(40, 47*(i+1)+8, 250, 18)];
        timeLab.font = [UIFont fontWithName:nil size:14];
        timeLab.text = _lableArr[i];
        timeLab.textColor = UIColorFromOXRGB(0x999999);
       
        
        //画大圆并填充颜
        UIColor *aColor ;
        
        if (i!=0)
        {
            aColor = [UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:1.0];
        }
        else
        {
            aColor = [UIColor colorWithRed:52/255.0 green:182/255.0 blue:153/255.0 alpha:1.0];
            infoLab.textColor = UIColorFromOXRGB(0x22c1ab);
            
        }
        CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
        CGContextSetLineWidth(context, 0);//线的宽度
        CGContextAddArc(context, 28, 47*(i+1),6, 0, 2*M_PI, 0); //添加一个圆
        //kCGPathFill填充非零绕数规则,kCGPathEOFill表示用奇偶规则,kCGPathStroke路径,kCGPathFillStroke路径填充,kCGPathEOFillStroke表示描线，不是填充
        CGContextDrawPath(context, kCGPathFillStroke); //绘制路径加填充
        
        [self addSubview:infoLab];
        [self addSubview:timeLab];
        
        
        
        
        
        
        
        
    }

    
    
  
}


@end
