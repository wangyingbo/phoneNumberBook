//
//  NetWorkRequest.h
//  Kergou
//
//  Created by JiaPin on 15/8/19.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWorkRequest : NSObject
/*
 GET  Method 
 *viewController  the class of data request
 *baseUrl         The basic Url
 *parameter       the parameter dictionary
 
 */
+(void)GETDataViewController:(id)viewcontroller BaseUrl:(NSURL *)baseurl FunctioName:(NSString *)name Parameter:(NSMutableDictionary *)para success:(void(^)(id responseObject))success loadFail:(void(^)(NSError *error))loadFail haveNoNetWork:(void(^)(void))noNetWork;
+(void)PostDataViewController:(id)viewController BaseUrl:(NSURL *)baseUrl Funtioname:(NSString *)name Parameter:(NSMutableDictionary *)para Success:(void(^)(id responseObject))suc LoadFailed:(void(^)(NSError *error))Fail haveNONetWork:(void(^)(void))haveNONetWork;
+ (void)GETDataViewController:(id)viewController BaseUrl:(NSURL *)baseUrl FunctionName:(NSString *)name Parameter:(NSMutableDictionary *)parameter Page:(NSInteger)page success:(void(^)(id responseObject , NSInteger page))successUpdate loadFail:(void(^)(NSError *errer , NSInteger page))loadFail haveNoNetWrok:(void(^)(NSInteger page))haveNoNetwork;


@end











































