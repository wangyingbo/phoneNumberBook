//
//  CurrentNetStatus.h
//  Kergou
//
//  Created by JiaPin on 15/8/18.
//  Copyright (c) 2015年 张帅. All rights reserved.
//
#import "CurrentNetStatus.h"
#import <Foundation/Foundation.h>

@interface CurrentNetStatus : NSObject
@property (nonatomic,assign)NetworkStatus status;
+(id)current;
-(void)autoLogin;
@end
