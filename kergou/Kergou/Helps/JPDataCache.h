//
//  JPDataCache.h
//  Kergou
//
//  Created by JiaPin on 15/8/18.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JPDataCache : NSObject
+(JPDataCache *)sharedInstance;

-(void)setObject:(id)value forKey:(NSString *)defaultName;

-(id)objectForKey:(NSString *)defaultName;

-(void)removeObjectForKey:(NSString *)key;

-(void)showContent;

//the path is encrypted,you will get the data with the encryption path
-(NSMutableDictionary *)getDataWithEncryptPath:(NSString *)cachePath;

//save the  date with encryption path
-(void)setEncryptPath:(NSString *)cachePath withSaveData:(NSMutableDictionary *)dict;

//create plist file
-(void)createCacheDicWithPath:(NSString *)cachePath;

-(void)removeAllCacheData;
@end









































