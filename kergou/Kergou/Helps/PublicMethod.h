//
//  PublicMethod.h
//  Kergou
//
//  Created by JiaPin on 15/9/1.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PublicMethod : NSObject



//核对是否为手机号
+(BOOL)checkTelNum:(NSString *)str;


//根据appid跳转到苹果的评论中心
+(NSURL *)appCommentUrlWithID:(NSString *)appID;

//根据字符串返回字符串所占的尺寸

//根据iPhone尺寸de变化，来确定图片视图的高度
+(CGFloat)PictureViewAdaptHeight:(CGFloat)currentHeight;

+(CGFloat)PictureViewAdaptHeightChange:(CGFloat)currentWidth;

+(UITabBarController *)getTabBarController;

+(UIViewController *)getVCByStoryboardID:(NSString *)idstr andWithSBName:(NSString *)sbName;

+(UIView *)getLineViewWithFrame:(CGRect)frame;

+(NSMutableAttributedString *)getColourfulLableWithColor:(UIColor *)color withString:(NSString *)str withRange:(NSRange )range;
+(UILabel *)lableViewAddsuperview_superView:(UIView *)superview _subViewFrame:(CGRect)rect _string:(NSString *)string _lableFont:(UIFont *)font _lableTxtColor:(UIColor *)color _textAlignment:(NSTextAlignment)alignment;
+(UIButton *)buttonAddsuperview_superView:(UIView *)superview _subViewFrame:(CGRect)rect _tag:(id)viewcontroller _action:(SEL)action _string:(NSString *)string _imageName:(NSString *)image;
+(UIImageView *)imageviewAddsuperview_superView:(UIView *)superview _subViewFrame:(CGRect)rect _imageName:(NSString *)image _backgroundColor:(UIColor *)color;

@end
