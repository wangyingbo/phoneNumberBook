//
//  NormalKeyMacro.h
//  Kergou
//
//  Created by JiaPin on 15/9/1.
//  Copyright (c) 2015年 张帅. All rights reserved.
//


//  此类为一些Key的宏定义

#ifndef Kergou_NormalKeyMacro_h
#define Kergou_NormalKeyMacro_h

//临时文件的名字，客户端数据缓存JPDataCache
#define JP_DATA_FILE_NAME @"/PrivateAccount_info_cache.plist"

//加密的AES_Key此处的key为任意值
#define AES_KEY @"thi5ha32ah2aha12"

#define AUTO_LOGIN_KEY @"autologin"    //the info about autoLogin
#define USER_LOGIN_INFO @"login"       //the info about Login

//APP_ID 此处为佳品的，新项目需要更改一下
#define APP_ID @"921425465"
//设置请求结束是否隐藏waitingView的Key,不需要隐藏Value设置为字符串NO，其他情况不需要设置
#define NET_WROK_HIDDEN_WAITINGVIEW_KEY @"hideWiatingView"

//设置缓存的KEY值
#define CACHE_KEY @"cacheKey"


//个推中的一些Key以及宏定义
#define kAppId           @"g1Fepkfiuy5fFDe5Uwhhx"
#define kAppKey          @"zL0oKUcMVv8CI2FXAIHak"
#define kAppSecret       @"AkSB55EhaQ9268UTjDa0v"
#define NotifyActionKey "NotifyAction"


#endif
