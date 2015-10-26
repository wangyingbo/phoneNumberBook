//
//  AppDelegate.m
//  Kergou
//
//  Created by JiaPin on 15/8/18.
//  Copyright (c) 2015年 张帅. All rights reserved.
//
#import "IndexPageVC.h"
#import "ViewController.h"
#import "Appirater.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"


NSString* const NotificationCategoryIdent  = @"ACTIONABLE";
NSString* const NotificationActionOneIdent = @"ACTION_ONE";
NSString* const NotificationActionTwoIdent = @"ACTION_TWO";

@interface AppDelegate ()<GeTuiSdkDelegate>
{
    NSString *_deviceToken;      // 个推获取设备号
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    //    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    //    self.window.backgroundColor = [UIColor whiteColor];
    //    [self.window makeKeyAndVisible];
    
    
    // [1]:使用APPID/APPKEY/APPSECRENT创建个推实例
    [self startSdkWith:kAppId appKey:kAppKey appSecret:kAppSecret];
    
    
    
    // [2]:注册APNS
    [self registerRemoteNotification];
    
    
    
    //    个推SDK支持用户设置标签，标示一组标签用户，可以针对标签用户进行推送。
    NSArray *tagNames = [NSArray arrayWithObjects:@"tag1",@"tag2", nil];
    [GeTuiSdk setTags: tagNames];
    
    
    //    个推SDK支持绑定别名功能，对用户设置别名，可以针对具体别名进行推送。
    NSString *aAlias = @"张三";
    [GeTuiSdk bindAlias:aAlias];
    
    
    // [2-EXT]: 获取启动时收到的APN数据
    NSDictionary*message=[launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (message)
    {
        NSString*payloadMsg = [message objectForKey:@"payload"];
        NSString*record = [NSString stringWithFormat:@"[APN]%@,%@",[NSDate date],payloadMsg];
        JPLog(@"----ApNMessage = %@",record);
    }
    
    
    //    去apptore打分
    [self setAppirater];
    
    
    //    第三方分享的注册id
    [self registerShareID];
    
    
    //    先检测是否是登录状态和时间，然后设置一些基本的信息
    [[CurrentNetStatus current]autoLogin];
    
    
    //    设置启动图的时间
    //    [NSThread sleepForTimeInterval:2.0f];
    
    
    ////设置根视图
    //    ViewController *vi = [[ViewController alloc]init];
    //    self.window.rootViewController = vi;
    
    
    //    找到视图
//    //
        UITabBarController *tabBarContr = (UITabBarController *)self.window.rootViewController;
//       tabBarContr.tabBar.barStyle = UIBarStyleDefault;
//        tabBarContr.tabBar.barTintColor = UIColorFromOXRGB(0x21c1aa);
//     [tabBarContr.tabBarItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//       tabBarContr.tabBar.tintColor = UIColorFromOXRGB(0xffa073);
//    
//
//        UITabBarItem *selectItem = tabBarContr.tabBar.items[0];
//        selectItem.image=[[UIImage imageNamed:@"shouyebaise.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        UITabBarItem *selectItem1 = tabBarContr.tabBar.items[1];
//        selectItem1.image=[[UIImage imageNamed:@"temaibaise.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        UITabBarItem *selectItem2 = tabBarContr.tabBar.items[2];
//        selectItem2.image=[[UIImage imageNamed:@"fenleibaise.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        UITabBarItem *selectItem3 = tabBarContr.tabBar.items[3];
//        selectItem3.image=[[UIImage imageNamed:@"gouwuchebaise.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        UITabBarItem *selectItem4 = tabBarContr.tabBar.items[4];
//        selectItem4.image=[[UIImage imageNamed:@"wodebaise.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    
 
 


      
    

    
    return YES;
}

#pragma mark - GeTuiDelegateMethod

//收到个推消息，可以根据payloadMsg程序做相应的反应
-(void)GeTuiSdkDidReceivePayload:(NSString*)payloadId andTaskId:(NSString*)taskId andMessageId:(NSString *)aMsgId fromApplication:(NSString *)appId

{
    
    NSData *payload = [GeTuiSdk retrivePayloadById:payloadId]; //根据payloadId取回Payload
    NSString *payloadMsg = nil;
    if (payload)
    {
        payloadMsg = [[NSString alloc] initWithBytes:payload.bytes
                      
                                              length:payload.length
                      
                                            encoding:NSUTF8StringEncoding];
        
    }
    
    //    NSString *record = [NSString stringWithFormat:@"%d, %@, %@",++_lastPayloadIndex, [self formateTime:[NSDate date]], payloadMsg];
    
    
    //    做相应处理的例子
    if ([payloadMsg  isEqual: @"1"])
    {
        SHOW_ALTER(@"enheng?");
    }
    
}


- (void)GeTuiSdkDidSendMessage:(NSString *)messageId result:(int)result
{
    
    // [4-EXT]:发送上行消息结果反馈
    
    NSString *record = [NSString stringWithFormat:@"Received sendmessage:%@ result:%d", messageId, result];
    
    JPLog(@"----record = %@",record);
    
    
}


- (void)GeTuiSdkDidOccurError:(NSError *)error

{
    
    // [EXT]:个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
    NSString *str = [NSString stringWithFormat:@">>>[GexinSdk error]:%@",[error localizedDescription]];
    JPLog(@"----logMsg = %@",str);
    
    
}


//获取时间
-(NSString*) formateTime:(NSDate*) date {
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSString* dateTime = [formatter stringFromDate:date];
    
    return dateTime;
}


// [3]:向个推服务器注册deviceToken
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
    NSString *token = [[deviceToken description]
                       stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    _deviceToken = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    [GeTuiSdk registerDeviceToken:_deviceToken];
    
    
}


// [3-EXT]:如果APNS注册失败，通知个推服务器
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    [GeTuiSdk registerDeviceToken:@""];
}


// [4-EXT-1]: 个推SDK已注册，返回clientId
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId  // SDK 返回clientid

{
    
    if (_deviceToken)
    {
        [GeTuiSdk registerDeviceToken:_deviceToken];
    }
    
}


// 后台启动以后，恢复个推SDK运行
-(void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [GeTuiSdk resume];
    completionHandler(UIBackgroundFetchResultNewData);
    
}


//注册远程通知
-(void)registerRemoteNotification
{
    
#ifdef __IPHONE_8_0
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        //IOS8 新的通知机制category注册
        UIMutableUserNotificationAction *action1;
        action1 = [[UIMutableUserNotificationAction alloc] init];
        [action1 setActivationMode:UIUserNotificationActivationModeBackground];
        [action1 setTitle:@"取消"];
        [action1 setIdentifier:NotificationActionOneIdent];
        [action1 setDestructive:NO];
        [action1 setAuthenticationRequired:NO];
        
        UIMutableUserNotificationAction *action2;
        action2 = [[UIMutableUserNotificationAction alloc] init];
        [action2 setActivationMode:UIUserNotificationActivationModeBackground];
        [action2 setTitle:@"回复"];
        [action2 setIdentifier:NotificationActionTwoIdent];
        [action2 setDestructive:NO];
        [action2 setAuthenticationRequired:NO];
        
        UIMutableUserNotificationCategory *actionCategory;
        actionCategory = [[UIMutableUserNotificationCategory alloc] init];
        [actionCategory setIdentifier:NotificationCategoryIdent];
        [actionCategory setActions:@[action1, action2]
                        forContext:UIUserNotificationActionContextDefault];
        
        NSSet *categories = [NSSet setWithObject:actionCategory];
        UIUserNotificationType types = (UIUserNotificationTypeAlert|
                                        UIUserNotificationTypeSound|
                                        UIUserNotificationTypeBadge);
        
        UIUserNotificationSettings *settings;
        settings = [UIUserNotificationSettings settingsForTypes:types categories:categories];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
        
        
    } else
    {
        
    }
#else
    UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|
                                                                   UIRemoteNotificationTypeSound|
                                                                   UIRemoteNotificationTypeBadge);
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
#endif
    
}


//[1-1]:通过 AppId、appKey 、appSecret 启动SDK
- (void)startSdkWith:(NSString *)appID appKey:(NSString*)appKey appSecret:(NSString *)appSecret
{
    
    NSError *err =nil;
    [GeTuiSdk startSdkWithAppId:appID appKey:appKey appSecret:appSecret delegate:self error:&err];
    
    
    //[1-2]:设置是否后台运行开关
    [GeTuiSdk runBackgroundEnable:YES];
    
    
    //[1-3]:设置地理围栏功能，开启LBS定位服务和是否允许SDK 弹出用户定位请求，请求NSLocationAlwaysUsageDescription权限,如果UserVerify设置为NO，需第三方负责提示用户定位授权。
    //    可以根据用户的地理位置推送信息
    [GeTuiSdk lbsLocationEnable:YES andUserVerify:YES];
    
    
    NSString *errStr = [NSString stringWithFormat:@"%@", [err localizedDescription]];
    JPLog(@"----errStr = %@",errStr);
    
    
}


//提示没有网路
-(void)showHaveNONetWorkAlert
{
    MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:self.window.rootViewController.view];
    [self.window.rootViewController.view addSubview:HUD];
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText = @"当前没有网络！";
    [HUD show:YES];
    [HUD hide:YES afterDelay:2];
}


//判断是否有网络
-(void)detectionNetWorkWithShowAlert:(NSString *)showAlert
{
    if ([[CurrentNetStatus current] status]==NotReachable )
    {
        if ([showAlert isEqualToString:@"YES"])
        {
            [self performSelectorOnMainThread:@selector(showHaveNONetWorkAlert) withObject:nil waitUntilDone:NO];
        }
    }
}


//注册分享的一些ID
-(void)registerShareID
{
    
    [WXApi registerApp:@"wxcc0c9325f849a634"];
    [WeiboSDK enableDebugMode:NO];
    [WeiboSDK registerApp:@"1296986352"];
}


//去App Store打分
-(void)setAppirater
{
    [Appirater setAppId:APP_ID];
    [Appirater setDaysUntilPrompt:7];
    [Appirater setUsesUntilPrompt:5];
    [Appirater setSignificantEventsUntilPrompt:-1];
    [Appirater setTimeBeforeReminding:2];
    [Appirater setCustomAlertTitle:@"亲，给我们打个分呗！"];
    [Appirater setCustomAlertMessage:@"只需要花费您很少的时间，您的评分和反馈对我们非常重要，感谢您对我们的支持。"];
    [Appirater setDebug:NO];
    [Appirater appLaunched:YES];
}


//微信和微博的一些代理方法
#pragma mark -- WeiXin and WeiBo delegate
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
    
}


-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([sourceApplication isEqualToString:@"com.tencent.xin"]) {
        [WXApi handleOpenURL:url delegate:self];
    }
    else if([sourceApplication isEqualToString:@"com.sina.weibo"])
    {
        [WeiboSDK handleOpenURL:url delegate:self];
    }
    
    return YES;
}


-(void)onReq:(BaseReq *)req
{
    if ([req isKindOfClass:[GetMessageFromWXReq class]]) {
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App提供内容"];
        NSString *strMsg = @"微信请求App提供内容，App要调用sendResp:GetMessageFromWXResp返回给微信";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 1000;
        [alert show];
    } else if ([req isKindOfClass:[ShowMessageFromWXReq class]]){
        ShowMessageFromWXReq *temp = (ShowMessageFromWXReq *)req;
        WXMediaMessage *msg =temp.message;
        WXAppExtendObject *obj = msg.mediaObject;
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App显示内容"];
        NSString *strMsg   = [NSString stringWithFormat:@"标题：%@ \n内容：%@ \n附带信息：%@ \n缩略图:%lu bytes\n\n", msg.title, msg.description, obj.extInfo, (unsigned long)msg.thumbData.length];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        
    }
    else if ([req isKindOfClass:[LaunchFromWXReq class]])
    {
        //从微信启动App
        NSString *strTitle = [NSString stringWithFormat:@"从微信启动"];
        NSString *strMsg   = @"这是从微信启动的消息";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    
    
    
}


-(void)onResp:(BaseResp *)resp
{
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        NSString *strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
        NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}


-(void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:[WBSendMessageToWeiboResponse class]]) {
        NSString *message = [NSString stringWithFormat:@"响应状态: %d\n响应UserInfo数据: %@\n原请求UserInfo数据: %@",(int)response.statusCode, response.userInfo, response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Tips" message:message delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"ok", nil];
        [alert show];
        
    }
    else if ([response isKindOfClass:[WBAuthorizeResponse class]])
    {
        NSString *message = [NSString stringWithFormat:@"响应状态: %d\nresponse.userId: %@\nresponse.accessToken: %@\n响应UserInfo数据: %@\n原请求UserInfo数据: %@",(int)response.statusCode,[(WBAuthorizeResponse *)response userID], [(WBAuthorizeResponse *)response accessToken], response.userInfo, response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Tips" message:message delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"ok", nil];
        [alert show];
    }
}


-(void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}

#pragma mark -- SystemDelegate
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}


//进入后台的时候
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [GeTuiSdk enterBackground];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    //每次进入调用这个方法，然后去检测网络
    [self detectionNetWorkWithShowAlert:@"YES"];
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
