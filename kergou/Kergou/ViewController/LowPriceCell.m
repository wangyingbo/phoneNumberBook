//
//  LowPriceCell.m
//  Kergou
//
//  Created by JiaPin on 15/10/14.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "LowPriceCell.h"

@implementation LowPriceCell
- (void)awakeFromNib
{
   
   self.repeatTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
    
  
    [self.bgView.layer setBorderWidth:0.3f];
    [self.bgView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
}
-(void)ConfigureCellWithModel:(BrandSaleModel *)model
{
    [self.brandSaleIMV setImageWithURL:[NSURL URLWithString:model.tag_img] placeholderImage:[UIImage imageNamed:@"5951.png"]];
    
    self.describeLab.text = model.tag_description;
    
    self.endTimeStr = model.tag_end_time;
    
    
    
}
- (void)timerFireMethod:(NSTimer *)theTimer
{
    BOOL timeStart = YES;
    NSCalendar *cal = [NSCalendar currentCalendar];//定义一个NSCalendar对象
    NSDateComponents *endTime = [[NSDateComponents alloc] init];    //初始化目标时间...
    NSDate *today = [NSDate date];    //得到当前时间
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateString = [dateFormatter dateFromString:_endTimeStr];
    NSString *overdate = [dateFormatter stringFromDate:dateString];
      
    static int year;
    static int month;
    static int day;
    static int hour;
    static int minute;
    static int second;
    if(timeStart) {//从NSDate中取出年月日，时分秒，但是只能取一次
        year = [[overdate substringWithRange:NSMakeRange(0, 4)] intValue];
        month = [[overdate substringWithRange:NSMakeRange(5, 2)] intValue];
        day = [[overdate substringWithRange:NSMakeRange(8, 2)] intValue];
        hour = [[overdate substringWithRange:NSMakeRange(11, 2)] intValue];
        minute = [[overdate substringWithRange:NSMakeRange(14, 2)] intValue];
        second = [[overdate substringWithRange:NSMakeRange(17, 2)] intValue];
        timeStart= NO;
    }
    
    [endTime setYear:year];
    [endTime setMonth:month];
    [endTime setDay:day];
    [endTime setHour:hour];
    [endTime setMinute:minute];
    [endTime setSecond:second];
    NSDate *overTime = [cal dateFromComponents:endTime]; //把目标时间装载入date
    //用来得到具体的时差，是为了统一成北京时间
    unsigned int unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth| NSCalendarUnitDay| NSCalendarUnitHour| NSCalendarUnitMinute| NSCalendarUnitSecond;
    NSDateComponents *d = [cal components:unitFlags fromDate:today toDate:overTime options:0];
    NSString *t = [NSString stringWithFormat:@"%d", [d day]];
    NSString *h = [NSString stringWithFormat:@"%d", [d hour]];
    NSString *fen = [NSString stringWithFormat:@"%d", [d minute]];
    if([d minute] < 10) {
        fen = [NSString stringWithFormat:@"0%d",[d minute]];
    }
    NSString *miao = [NSString stringWithFormat:@"%d", [d second]];
    if([d second] < 10) {
        miao = [NSString stringWithFormat:@"0%d",[d second]];
    }
    //    NSLog(@"===%@天 %@:%@:%@",t,h,fen,miao);
    self.endTimeLab.text =[NSString stringWithFormat:@"%@天%@时%@分%@秒",t,h,fen,miao];
    if([d second] > 0) {
        //计时尚未结束，do_something
        //        [_longtime setText:[NSString stringWithFormat:@"%@:%@:%@",d,fen,miao]];
    } else if([d second] == 0) {
        //计时结束 do_something
        
    } else{
        //计时器失效
        [theTimer invalidate];
    } 
    
}
//- (NSString *)intervalFromLastDate: (NSString *) dateString1  toTheDate:(NSString *) dateString2
//{
//
//    NSDateFormatter *date=[[NSDateFormatter alloc] init];
//    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    
//    NSDate *d1=[date dateFromString:dateString1];
//    
//    NSTimeInterval late1=[d1 timeIntervalSince1970]*1;
//    
//    NSDate *d2=[date dateFromString:dateString2];
//    
//    NSTimeInterval late2=[d2 timeIntervalSince1970]*1;
//    
//    NSTimeInterval cha=late2-late1;
//   
//    NSInteger dayNum =   cha/86400;
//    
//    NSInteger hourNum =  (NSInteger)cha%86400;
//    
//    return timeString;er
//}


//
//- (NSString *)intervalSinceNow: (NSString *) theDate
//{
//    NSArray *timeArray=[theDate componentsSeparatedByString:@"."];
//    theDate=[timeArray objectAtIndex:0];
//    
//    NSDateFormatter *date=[[NSDateFormatter alloc] init];
//    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSDate *d=[date dateFromString:theDate];
//    
//    NSTimeInterval late=[d timeIntervalSince1970]*1;
//    
//    NSDate* dat = [NSDate date];
//    NSTimeInterval now=[dat timeIntervalSince1970]*1;
//    NSString *timeString=@"";
//    
//    NSTimeInterval cha=late-now;
//    
//    if (cha/3600<1) {
//        timeString = [NSString stringWithFormat:@"%f", cha/60];
//        timeString = [timeString substringToIndex:timeString.length-7];
//        timeString=[NSString stringWithFormat:@"剩余%@分", timeString];
//        
//    }
//    if (cha/3600>1&&cha/86400<1) {
//        timeString = [NSString stringWithFormat:@"%f", cha/3600];
//        timeString = [timeString substringToIndex:timeString.length-7];
//        timeString=[NSString stringWithFormat:@"剩余%@小时", timeString];
//    }
//    if (cha/86400>1)
//    {
//        timeString = [NSString stringWithFormat:@"%f", cha/86400];
//        timeString = [timeString substringToIndex:timeString.length-7];
//        timeString=[NSString stringWithFormat:@"剩余%@天", timeString];
//        
//    }
//  
//    return timeString;
//}
-(void)dealloc
{
   
   
    [self.repeatTimer invalidate];
     self.repeatTimer = nil;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
