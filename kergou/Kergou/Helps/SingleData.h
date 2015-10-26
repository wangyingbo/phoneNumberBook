//
//  SingleData.h
//  Kergou
//
//  Created by JiaPin on 15/8/18.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleData : NSObject
@property (nonatomic,assign)BOOL   isLogin;
@property (nonatomic,strong)NSString *time;
@property (nonatomic,strong)NSString *username;
@property (nonatomic,strong)NSString *userID;
@property (nonatomic,assign)BOOL      appIsOnline;
+(SingleData *)single;
-(void)getTimeToSetLoginStatu;
-(void)comparaTimeTopListTime;
-(void)getTimeWithFinishSel:(SEL)select Target:(id)target;
@end





























