//
//  NormalMacro.h
//  Kergou
//
//  Created by JiaPin on 15/8/18.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

//  此类为一些普通的宏定义
#import <Foundation/Foundation.h>
#ifndef Kergou_NormalMacro_h
#define Kergou_NormalMacro_h

//网络状态
typedef enum : NSInteger {
    NotReachable = 0,
    ReachableViaWiFi,
    ReachableViaWWAN
} NetworkStatus;


//调试状态才打印NSLog，否则不打印
#ifdef DEBUG
#define JPLog(...) NSLog(__VA_ARGS__)
#else
#define JPLog(...)
#endif
#define Image_pathWithName(name)\
[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:name ofType:@"png"]]

#define FONT_SIZE(s) [UIFont fontWithName:nil size:s]

//iPhone 的宽度
#define   IPHONE_WITH  [UIScreen mainScreen].bounds.size.width

//iPhone 的高度
#define IPHONE_HEIGHT  [UIScreen mainScreen].bounds.size.height

#define DEVICE_ID [[[UIDevice currentDevice] identifierForVendor] UUIDString]
//警告
#define   SHOW_ALTER(str)  [[[UIAlertView alloc]initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show]

//返回的颜色ByRGB
#define COLOR_RGB(R,G,B)  [UIColor colorWithRed:(R/255.0) green:(G/255.0) blue:(B/255.0) alpha:1]

//十六进制
#define UIColorFromOXRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//获取当前设备的系统版本
#define SYSTEM_VERSION  [UIDevice currentDevice].systemVersion

//获取应用版本号

#define APP_VERSION [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleVersion"]

//获取应用名称

#define APP_NAME [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleName"]

//获取临时文件的路径
#define PATH_HOME_CACHE  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]



#endif
