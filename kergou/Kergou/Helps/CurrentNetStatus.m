//
//  CurrentNetStatus.m
//  Kergou
//
//  Created by JiaPin on 15/8/18.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "Reachability.h"

@interface CurrentNetStatus()
@property (nonatomic)Reachability *hostReachAblity;
@end

static CurrentNetStatus  *_curretClass = nil;

@implementation CurrentNetStatus

//单例
+(id)current
{
    @synchronized (self)
    {
        if (_curretClass ==nil)
        {
            _curretClass = [[CurrentNetStatus alloc]init];
            [_curretClass HaveNetOrNot];
            
        }
    }
    return _curretClass;
}

//判断是否有网络
-(void)HaveNetOrNot
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reachabilitychange:) name:kReachabilityChangedNotification object:nil];
    NSString *remoteHostName = @"www.jiapin.com";
    self.hostReachAblity = [Reachability reachabilityWithHostName:remoteHostName];
    _status = [self.hostReachAblity currentReachabilityStatus];
    [self.hostReachAblity startNotifier];
    
}

-(void)reachabilitychange:(NSNotification *)note
{
    Reachability *curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}

-(void)updateInterfaceWithReachability:(Reachability *)reachability
{
    if (reachability == self.hostReachAblity) {
        _status = [reachability currentReachabilityStatus];
        if (_status!=NotReachable) {
            [self autoLogin];
        }
        else
        {
            [SingleData single].isLogin =YES;
        }
    }
}
-(void)autoLogin
{
    [NSThread detachNewThreadSelector:@selector(startLogin) toTarget:self withObject:nil];
}
-(void)startLogin
{
    [[SingleData single]getTimeToSetLoginStatu];
    [[SingleData single]comparaTimeTopListTime];
    
}
@end
