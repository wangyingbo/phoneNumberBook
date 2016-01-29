//
//  JPDataCache.m
//  Kergou
//
//  Created by JiaPin on 15/8/18.
//  Copyright (c) 2015年 张帅. All rights reserved.
//
#import "NSData+AES256.h"
#import "JPDataCache.h"

@implementation JPDataCache
{
    NSMutableDictionary *_JPDataCache;
}
static JPDataCache *_singleDatacache;

//单例类
+(JPDataCache *)sharedInstance
{
    @synchronized (self)
    {
        if (_singleDatacache ==nil) {
             _singleDatacache = [[self alloc]init];
        }
       
    }
    return _singleDatacache;
}
+(id)allocWithZone:(struct _NSZone *)zone
{
    @synchronized(self)
    {
        if (!_singleDatacache)
        {
            _singleDatacache = [super allocWithZone:zone]; //insure used the same zone
        }
    }
    return _singleDatacache;
}
-(id)copyWithZone:(NSZone *)zone
{
    return self;
    
}

//就是获取数据，然而路径并没有加密并没有
-(NSMutableDictionary *)getDataWithEncryptPath:(NSString *)cachePath
{
    NSMutableDictionary *cacheDic = [NSMutableDictionary dictionaryWithContentsOfFile:cachePath];
    return cacheDic;
}

//使用这个路径，创建一个文件，写入的是空数据
-(void)createCacheDicWithPath:(NSString *)cachePath
{
    NSError *error;
    NSMutableDictionary *cacheDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    [self setEncryptPath:cachePath withSaveData:cacheDic];
    
    if (error!=nil) {
        JPLog(@"----error = %@",error.description);
    }
}

//姜数据按照路径写入
-(void)setEncryptPath:(NSString *)cachePath withSaveData:(NSMutableDictionary *)dict
{
    _JPDataCache = dict;
    [dict writeToFile:cachePath atomically:YES];
}

//以名字将值写入
-(void)setObject:(id)value forKey:(NSString *)defaultName
{

    NSString *cachePath = [PATH_HOME_CACHE stringByAppendingString:JP_DATA_FILE_NAME];
    
    
    if (![[NSFileManager defaultManager]fileExistsAtPath:cachePath]) {
        [self createCacheDicWithPath:cachePath];
    }
    
//    将值加密
    if (value) {
        value = [[NSKeyedArchiver archivedDataWithRootObject:value]AES256EncryptWithKey:AES_KEY];
    }
    
    
    if (!_JPDataCache) {
        _JPDataCache = [NSMutableDictionary dictionaryWithDictionary:[self getDataWithEncryptPath:cachePath]];
    }
    NSMutableDictionary *cacheDict = _JPDataCache;
    
    [cacheDict setObject:value forKey:defaultName];
    
//    将数据写入
    [self setEncryptPath:cachePath withSaveData:cacheDict];
    
    
    
}

//读取数据
-(id)objectForKey:(NSString *)defaultName
{
    NSString * cachePath = [PATH_HOME_CACHE stringByAppendingPathComponent:JP_DATA_FILE_NAME];
    
    
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:cachePath])
    {
        [self createCacheDicWithPath:cachePath];
    }
    //解密取数据
    if (!_JPDataCache) {
        _JPDataCache = [NSMutableDictionary dictionaryWithDictionary:[self getDataWithEncryptPath:cachePath]];
    }
    NSMutableDictionary * cacheDict = _JPDataCache;
    
    if ([cacheDict objectForKey:defaultName]) {
        NSData * cacheData = [[cacheDict objectForKey:defaultName] AES256DecryptWithKey:AES_KEY];
        //NSData * cacheData = [NSData dataWithContentsOfFile:cachePath];
//        需要将值解密
        id cacheValue = [NSKeyedUnarchiver unarchiveObjectWithData:cacheData];
        return cacheValue;
    }else{
        return nil;
    }
    
}

//根据key值删除数据
-(void)removeObjectForKey:(NSString *)key
{
    NSString * cachePath = [PATH_HOME_CACHE stringByAppendingPathComponent:JP_DATA_FILE_NAME];
    if (![[NSFileManager defaultManager] fileExistsAtPath:cachePath]) {
        [self createCacheDicWithPath:cachePath];
    }
    //解密取数据
    if (!_JPDataCache) {
        _JPDataCache = [NSMutableDictionary dictionaryWithDictionary:[self getDataWithEncryptPath:cachePath]];
    }
    NSMutableDictionary * cacheDict = _JPDataCache;
    if ([cacheDict objectForKey:key]) {
        [cacheDict removeObjectForKey:key];
        [self setEncryptPath:cachePath withSaveData:cacheDict];
    }
}

//展示文件中所有的内容
-(void)showContent
{
    NSString * cachePath = [PATH_HOME_CACHE stringByAppendingPathComponent:JP_DATA_FILE_NAME];
    if (![[NSFileManager defaultManager] fileExistsAtPath:cachePath]) {
        [self createCacheDicWithPath:cachePath];
    }
    
    NSMutableDictionary * cacheDict = [NSMutableDictionary dictionaryWithDictionary:[self getDataWithEncryptPath:cachePath]];
    JPLog(@"--all the data with encryption = =%@", cacheDict);
}

//移除文件的所有数据
-(void)removeAllCacheData
{
    NSMutableDictionary *userInfoDict = nil;
    
    if ([[[JPDataCache sharedInstance]objectForKey:AUTO_LOGIN_KEY] isEqualToString:@"1"])
    {
        userInfoDict = [[NSMutableDictionary alloc]initWithDictionary:[[JPDataCache sharedInstance]objectForKey:USER_LOGIN_INFO]];
        
    }
    [[NSFileManager defaultManager]removeItemAtPath:[PATH_HOME_CACHE stringByAppendingPathComponent:JP_DATA_FILE_NAME] error:nil];
    if (userInfoDict) {
        [[JPDataCache sharedInstance]setObject:@"1" forKey:AUTO_LOGIN_KEY];
        [[JPDataCache sharedInstance]setObject:userInfoDict forKey:USER_LOGIN_INFO];
    }

}
@end












































