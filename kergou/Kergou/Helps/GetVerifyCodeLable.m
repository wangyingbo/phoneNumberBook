//
//  danliTest.m
//  Kergou
//
//  Created by JiaPin on 15/9/6.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "GetVerifyCodeLable.h"

static GetVerifyCodeLable  *_danli= nil;
@implementation GetVerifyCodeLable

+(id)CreatVerifyCodeLableWithFrame:(CGRect)frame
{
    @synchronized (self)
    {
        if (_danli==nil)
        {
            _danli = [[GetVerifyCodeLable alloc]initWithFrame:frame];
            
        }
    }
    [_danli initLable];
    return _danli;
}
-(void)initLable
{
    
    for (UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
    // @{
    // @name 生成背景色
    float red = arc4random() % 100 / 100.0;
    float green = arc4random() % 100 / 100.0;
    float blue = arc4random() % 100 / 100.0;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:0.1];
    [self setBackgroundColor:color];
    // @} end 生成背景色
    
    // @{
    // @name 生成文字
    const int count = 4;
    char data[count];
    for (int x = 0; x < count; x++)
    {
        int j = '0' + (arc4random_uniform(75));
        if((j >= 58 && j <= 64) || (j >= 91 && j <= 96))
        {
            --x;
        }
        else
        {
            data[x] = (char)j;
        }
    }
    NSString *text = [[NSString alloc] initWithBytes:data
                                              length:count encoding:NSUTF8StringEncoding];
    //    self.code = text;
    // @} end 生成文字
    
    CGSize cSize = [@"S" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    int width = self.frame.size.width / text.length - cSize.width;
    int height = self.frame.size.height - cSize.height-5;
    CGPoint point;
    float pX, pY;
    for (int i = 0, count = text.length; i < count; i++)
    {
        pX = arc4random() % width + self.frame.size.width / text.length * i - 1;
        pY = arc4random() % height;
        point = CGPointMake(pX, pY);
        unichar c = [text characterAtIndex:i];
        UILabel *tempLabel = [[UILabel alloc]
                              initWithFrame:CGRectMake(pX, pY,
                                                       self.frame.size.width / 4,
                                                       self.frame.size.height)];
        tempLabel.backgroundColor = [UIColor clearColor];
        
        // 字体颜色
        float red = arc4random() % 100 / 100.0;
        float green = arc4random() % 100 / 100.0;
        float blue = arc4random() % 100 / 100.0;
        UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
        
        NSString *textC = [NSString stringWithFormat:@"%C", c];
        tempLabel.textColor = color;
        tempLabel.text = textC;
        [self addSubview:tempLabel];
    }
    
    
    
}

@end
