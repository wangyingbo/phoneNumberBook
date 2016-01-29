//
//  PublicMethod.m
// Kergou
//
//  Created by JiaPin on 15/9/1.
//  Copyright (c) 2015年 张帅. All rights reserved.
//
#define NSLocalizedString(key, comment) \
[[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:nil]
#import "PublicMethod.h"
@interface PublicMethod()
@property (nonatomic,strong) UILabel  *checkCodeNumberLabel;
@end
@implementation PublicMethod

+(BOOL)checkTelNum:(NSString *)str
{
    
    
    
    
    if ([str length] == 0)
    {
        SHOW_ALTER(@"手机号不能为空");
        return NO;
    }
    //1[0-9]{10}
    //^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$
    //    NSString *regex = @"[0-9]{11}";
    NSString *regex = @"1[0-9]{10}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    if (!isMatch) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    else
    {
        //SHOW_ALTER(@"👋");
        return YES;
    }
    
}

//根据iPhone尺寸de变化，来确定图片视图的高度
+(CGFloat)PictureViewAdaptHeight:(CGFloat)currentHeight
{
    return currentHeight*IPHONE_WITH/375;
}

//根据iPhone尺寸de变化，来确定图片视图的高度
+(CGFloat)PictureViewAdaptHeightChange:(CGFloat)currentWidth
{
    return currentWidth*IPHONE_HEIGHT/667;
}

+(NSURL *)appCommentUrlWithID:(NSString *)appID
{
    NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",appID];
    return [NSURL URLWithString:str];
}


+(UITabBarController *)getTabBarController
{
    UIWindow *win = [UIApplication sharedApplication].windows[0];
    UITabBarController *tabBarControl= (UITabBarController *)win.rootViewController;
    return tabBarControl;

}

+(UIViewController *)getVCByStoryboardID:(NSString *)idstr andWithSBName:(NSString *)sbName
{
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:sbName bundle:nil];
    UIViewController *vc = [mainStoryBoard instantiateViewControllerWithIdentifier:idstr];
    return vc;
}
+(UIView *)getLineViewWithFrame:(CGRect)frame
{
    UIView *lineView = [[UIView alloc]initWithFrame:frame];
    lineView.backgroundColor = [UIColor lightGrayColor];
    
    return lineView;
}

+(NSMutableAttributedString *)getColourfulLableWithColor:(UIColor *)color withString:(NSString *)str withRange:(NSRange )range
{
    NSMutableAttributedString * ColorStr = [[NSMutableAttributedString alloc]initWithString:str];
    
   
    [ColorStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    
    return ColorStr;
}

+(UILabel *)lableViewAddsuperview_superView:(UIView *)superview _subViewFrame:(CGRect)rect _string:(NSString *)string _lableFont:(UIFont *)font _lableTxtColor:(UIColor *)color _textAlignment:(NSTextAlignment)alignment
{
    UILabel *lable = [[UILabel alloc]initWithFrame:rect];
    lable.backgroundColor = [UIColor clearColor];
    lable.text = string;
    lable.font = font;
    lable.textColor = color;
    lable.textAlignment = alignment;
    [superview addSubview:lable];
    
    return lable;
}
+(UIButton *)buttonAddsuperview_superView:(UIView *)superview _subViewFrame:(CGRect)rect _tag:(id)viewcontroller _action:(SEL)action _string:(NSString *)string _imageName:(NSString *)image 
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = rect;
    if(image != nil && image.length>0){
        NSArray *array = [image componentsSeparatedByString:@"."];
        [button setBackgroundImage:Image_pathWithName([array objectAtIndex:0]) forState:UIControlStateNormal];
    }
    
    [button setTitle:string forState:UIControlStateNormal];
    if(viewcontroller != nil)
        [button addTarget:viewcontroller action:action forControlEvents:UIControlEventTouchUpInside];
    [superview addSubview:button];
    
    return button;
}

+(UIImageView *)imageviewAddsuperview_superView:(UIView *)superview _subViewFrame:(CGRect)rect _imageName:(NSString *)image _backgroundColor:(UIColor *)color
{
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:rect];
    if(image != nil && image.length>0){
        NSArray *array = [image componentsSeparatedByString:@"."];
        imageview.image = Image_pathWithName([array objectAtIndex:0]);
        
    }else if(color != nil)
        imageview.backgroundColor = color;
    [superview addSubview:imageview];
    
    return imageview;
}

@end
