//
//  YBDatePicker.m
//  Kergou
//
//  Created by 王迎博 on 15/10/8.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "YBDatePicker.h"

@implementation YBDatePicker

+ (UIDatePicker *)initDatePicker
{
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, (FULL_SCREEN_HEIGHT/3) * 2 - 40, FULL_SCREEN_WIDTH, 40)];
//     UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 40, view.frame.size.height)];
//    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(view.frame.size.width - 50, 0, 40, view.frame.size.height)];
//    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
//    [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
//    view.backgroundColor = [UIColor blackColor];
//    [view addSubview:leftBtn];
//    [view addSubview:rightBtn];
    
    
    UIDatePicker *datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, (FULL_SCREEN_HEIGHT/3) * 2, FULL_SCREEN_WIDTH, FULL_SCREEN_HEIGHT/3)];
    
    NSTimeInterval perDay = 24 * 60 * 60;
    NSTimeInterval minYear = perDay * 365 * 80;
    NSTimeInterval maxYear = perDay * 365;
    
    NSDate *today = [[NSDate alloc]init];
    NSDate *min = [today dateByAddingTimeInterval: -minYear];
    NSDate *max = [today dateByAddingTimeInterval: -maxYear];
    
    [datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    [datePicker setMinimumDate:min];
    [datePicker setMaximumDate:max];

    
    return datePicker;

}


@end
