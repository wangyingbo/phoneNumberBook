//
//  NetWorkRequest.m
//  Kergou
//
//  Created by JiaPin on 15/8/19.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "NetWorkRequest.h"

@implementation NetWorkRequest

//get方法获取数据
+(void)GETDataViewController:(id)viewcontroller BaseUrl:(NSURL *)baseurl FunctioName:(NSString *)name Parameter:(NSMutableDictionary *)para success:(void (^)(id))success loadFail:(void (^)(NSError *))loadFail haveNoNetWork:(void (^)(void))noNetWork
{
//    先判断网络
    if ([[CurrentNetStatus current]status] == NotReachable)
    {
//        穿过来的viewController要继承BasicViewController
        if ([viewcontroller isKindOfClass:[BasicViewController class]])
        {
            [(BasicViewController *)viewcontroller hidenWatingView];
            [(BasicViewController *)viewcontroller showWaitingResultWithWaitingText:@"当前没有网络" afterDelay:1];
        }
        if (noNetWork){
            noNetWork();
        }
        
        return;
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    
//    AF网络请求的固定方法
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:baseurl];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
//    此处传过来的para可以设置网络请求的状态
    [manager GET:name parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (![[para objectForKey:NET_WROK_HIDDEN_WAITINGVIEW_KEY]isEqualToString:@"NO"])
        {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            if ([(BasicViewController *)viewcontroller isKindOfClass:[BasicViewController class]])
            {
                [(BasicViewController *)viewcontroller hidenWatingView];
            }
            
        }
        
        //    此处传过来的para可以设置是否要缓存以及缓存的关键字KEY的值
        NSDictionary *responseDict = (NSDictionary *)responseObject;
        if ([para objectForKey:CACHE_KEY]&&responseDict.count>0&&!([[responseDict objectForKey:@"msg"]isEqualToString:@"error"]))
        {
            [[JPDataCache sharedInstance] setObject:responseDict forKey:[para objectForKey:CACHE_KEY]];
        }
//        成功则返回
        if (success)
        {
            success(responseObject);
        }
    }
//     失败处理
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if ([(BasicViewController *)viewcontroller isKindOfClass:[BasicViewController class]])
        {
            [(BasicViewController *)viewcontroller hidenWatingView];
            [(BasicViewController *)viewcontroller showWaitingResultWithWaitingText:@"请求失败，请稍后再试" afterDelay:2];
        }
        if (loadFail) {
            loadFail(error);
        }
        
    }];
}







//Post网络请求的方法，基本和Get一样
+(void)PostDataViewController:(id)viewController BaseUrl:(NSURL *)baseUrl Funtioname:(NSString *)name Parameter:(NSMutableDictionary *)para Success:(void(^)(id responseObject))suc LoadFailed:(void(^)(NSError *error))Fail haveNONetWork:(void(^)(void))haveNONetWork
{
    if ([[CurrentNetStatus current] status] == NotReachable) {
        if ([viewController isKindOfClass:[BasicViewController class]]) {
            [(BasicViewController *)viewController hidenWatingView];
            [(BasicViewController *)viewController showWaitingResultWithWaitingText:@"当前没有网络！" afterDelay:1];
        }
        if (haveNONetWork) {
            haveNONetWork();
        }
        return;
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPRequestOperationManager * manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseUrl];
    //解决请求失败问题
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    //Post请求
    [manager POST:name
       parameters:para
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              
              if (![[para objectForKey:NET_WROK_HIDDEN_WAITINGVIEW_KEY] isEqualToString:@"NO"]) {
                  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                  if ([viewController isKindOfClass:[BasicViewController class]]) {
                      [(BasicViewController *)viewController hidenWatingView];
                  }
              }
              //缓存信息
              NSDictionary * responseDict = (NSDictionary *)responseObject;
              
//              NSLog(@"------[parameter objectForKey:CACLE_KEY] = %@",[parameter objectForKey:CACLE_KEY]);
              
              if ([para objectForKey:CACHE_KEY] &&  responseDict.count > 0 && (![[responseObject objectForKey:@"msg"] isEqualToString:@"error"]))
              {
                  [[JPDataCache sharedInstance] setObject:responseObject forKey:[para objectForKey:CACHE_KEY]];
              }
              
              //POST请求完毕，判断子类是否存在updateDataSource方法
              if (suc) {
                  //调用子类接受数据方法
                  suc(responseObject);
              }
          }
          failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              NSLog(@"%@--Post请求失败Error==%@",name,error);
              [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
              if ([viewController isKindOfClass:[BasicViewController class]]) {
                  [(BasicViewController *)viewController hidenWatingView];
                  [(BasicViewController *)viewController showWaitingResultWithWaitingText:@"请求失败，请稍后再试"  afterDelay:2];
              }
              if (Fail) {
                  Fail(error);
                  
              }
          }
     ];

}



//这个方法主要是增加了上拉加载的网络请求
+ (void)GETDataViewController:(id)viewController BaseUrl:(NSURL *)baseUrl FunctionName:(NSString *)name Parameter:(NSMutableDictionary *)parameter Page:(NSInteger)page success:(void(^)(id responseObject , NSInteger page))successUpdate loadFail:(void(^)(NSError *errer , NSInteger page))loadFail haveNoNetWrok:(void(^)(NSInteger page))haveNoNetwork
{
    if ([[CurrentNetStatus current] status] == NotReachable) {
        if ([viewController isKindOfClass:[BasicViewController class]]) {
            [(BasicViewController *)viewController hidenWatingView];
            [(BasicViewController *)viewController showWaitingResultWithWaitingText:@"当前没有网络！" afterDelay:1];
        }
        if (haveNoNetwork) {
            haveNoNetwork(page);
        }
        return;
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPRequestOperationManager * manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseUrl];
    //解决请求失败问题
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    //Get请求
    [manager GET:name
      parameters:parameter
         success:^(AFHTTPRequestOperation *operation,id responseObject) {
             if (![[parameter objectForKey:NET_WROK_HIDDEN_WAITINGVIEW_KEY] isEqualToString:@"NO"]) {
                 [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                 if ([viewController isKindOfClass:[BasicViewController class]]) {
                     [(BasicViewController *)viewController hidenWatingView];
                 }
             }
             
             //缓存信息
             NSDictionary * responseDict = (NSDictionary *)responseObject;
             if ([parameter objectForKey:CACHE_KEY] &&  responseDict.count > 0 &&  (![[responseObject objectForKey:@"msg"] isEqualToString:@"error"])) {
                 [[JPDataCache sharedInstance] setObject:responseObject forKey:[parameter objectForKey:CACHE_KEY]];
             }
             //调用子类接受数据方法
             if (successUpdate) {
                 successUpdate(responseObject, page);
             }
             
         }
         failure:^(AFHTTPRequestOperation *operation,NSError *error) {
             NSLog(@"%@--Get请求失败Error==%@",name,error);
             [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
             if ([viewController isKindOfClass:[BasicViewController class]]) {
                 [(BasicViewController *)viewController hidenWatingView];
                 [(BasicViewController *)viewController showWaitingResultWithWaitingText:@"请求失败，请稍后再试" afterDelay:2];
             }
             if (loadFail) {
                 loadFail(error,page);
             }
         }
     ];

}
@end
