//
//  SingleData.m
//  Kergou
//
//  Created by JiaPin on 15/8/18.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "SingleData.h"
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)
static SingleData *_single= nil;
@implementation SingleData

//sinle define ,in order to create twice !
+(SingleData *)single
{
    @synchronized(self)
    {
        if (_single ==nil) {
            _single = [[SingleData alloc]init];
        }
    }
    return _single;
}

//
// 异步操作防止阻塞主线程
-(void)getTimeWithFinishSel:(SEL)select Target:(id)target
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://api.jiapin.com/mobile/servertime"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *timeDic = [data objectFromJSONData];
            if ([timeDic objectForKey:@"time"]) {
                [self setTime:[timeDic objectForKey:@"time"]];
            }
            else
            {
                [self setTime:@""];
            }
            
            //它可以消除警告
            SuppressPerformSelectorLeakWarning([target performSelector:select withObject:nil]);
            
        });
        
        
        
        
    });
}

//从服务器获取现在登录的时间
-(void)getTimeToSetLoginStatu
{
    NSURL  *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/servertime",BASE_LOGIN]];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSData *reciveData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:reciveData encoding:NSUTF8StringEncoding];
    NSDictionary *timeDic = [dataStr objectFromJSONString];
    if ([timeDic objectForKey:@"time"]) {
        [_single setTime:[timeDic objectForKey:@"time"]];
    }else{
        [_single setTime:@""];
    }

}

-(void)comparaTimeTopListTime
{
//    获取登陆用户的信息
    NSMutableDictionary *caheDic = [[JPDataCache sharedInstance]objectForKey:USER_LOGIN_INFO];
    if (caheDic)
    {
//        比较现在的时间和原来登陆时间的间隔
        NSInteger time = [_single.time integerValue] - [[caheDic objectForKey:@"logintime"]integerValue];
//        如果时间间隔大雨、于2个星期设置登录状态为No；
        if (time>2*7*24*60*60) {
            _single.isLogin = NO;
        }
//        否则配置一些原有用户的一些基本信息
        else
        {
            
            _single.isLogin = YES;
            _single.time = [caheDic objectForKey:@"loginTime"];
            _single.username = [[caheDic objectForKey:@"userInfo"]objectForKey:@"member_name"];
            _single.userID = [[caheDic objectForKey:@"userInfo"]objectForKey:@"member_id"];
            
        }
        
    }
    else
    {
        _single.isLogin = NO;
        _single.time = @"";
        _single.username = @"";
        _single.userID = @"";
        
    }
}

@end







































