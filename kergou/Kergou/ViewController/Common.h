
//
//  Common.h
//  Kergou
//
//  Created by 王迎博 on 15/9/21.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#ifndef Kergou_Common_h
#define Kergou_Common_h



#define FULL_SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define FULL_SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height


#define Adopt_Device_iPhone6_Width [UIScreen mainScreen].bounds.size.width/375;
#define Adopt_Device_iPhone6_Height [UIScreen mainScreen].bounds.size.height/667;



#define kClassifyBaseURL @"http://221.123.168.123/goods/Category"
#define kCountryBaseURL  @"http://221.123.168.123/goods/countrybrand"
#define kClassifyParameter @"catType"
#define KsendVertifyNumParameter @"address"
#define CHILDREN  @"children"
#define DATA @"data"

#define BASEURL [NSURL URLWithString:@"http://221.123.168.123"]
#define KsendVertifyNumURL @"/app/user_captcha"

#define VerifiyNumLength 6
#define PhoneNumLength 11
#endif
