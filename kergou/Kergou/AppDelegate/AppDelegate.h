//
//  AppDelegate.h
//  Kergou
//
//  Created by JiaPin on 15/8/18.
//  Copyright (c) 2015年 张帅. All rights reserved.
//
#import "GeTuiSdk.h"
#import "WXApi.h"
#import "WeiboSDK.h"
#import <UIKit/UIKit.h>




@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate,WBHttpRequestDelegate,WeiboSDKDelegate>

//个推的属性设置
@property (assign, nonatomic) int lastPayloadIndex;
@property (strong, nonatomic) NSString *clientId;

//you konw
@property (strong, nonatomic) UIWindow *window;

//检查是否有网络提示
-(void)showHaveNONetWorkAlert;

@end

