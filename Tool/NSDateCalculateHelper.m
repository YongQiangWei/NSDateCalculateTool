//
//  NSDataCalculateHelper.m
//  HUD
//
//  Created by Yongqiang Wei on 2018/12/24.
//  Copyright © 2018 Yongqiang Wei. All rights reserved.
//

#import "NSDateCalculateHelper.h"
#import "DateTools.h"
#import "NSDate+Category.h"


@interface NSDateCalculateHelper ()
@property (nonatomic, strong) NSDate *currentDate;
@property (nonatomic, strong) NSDateFormatter *formatter;
@property (nonatomic, strong) NSCalendar *calender;

@end

@implementation NSDateCalculateHelper

// NSDateCalculateHelper 单例创建
+ (NSDateCalculateHelper *)sharedCalculateHelper{
    static NSDateCalculateHelper *singleton;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[NSDateCalculateHelper alloc] init];
        singleton.currentDate = [NSDate date];
        singleton.calender = [NSCalendar currentCalendar];
        [singleton.calender setFirstWeekday:2];// 设置每周开始时间为 周一
        singleton.formatter = [[NSDateFormatter alloc] init];
        if (singleton.formatString.length > 0) {
            [singleton.formatter setDateFormat:singleton.formatString];
        }else{
            [singleton.formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];            
        }
    });
    return singleton;
}

// 当前时间年份获取
- (NSInteger )getCurrentDateTimeOfYear{
    NSDateComponents *comp = [_calender components:NSCalendarUnitYear fromDate:_currentDate];
    return [comp year];
}

// 当前时间月份获取
- (NSInteger)getCurrentDateTimeOfMonth{
    NSDateComponents *comp = [_calender components:NSCalendarUnitMonth fromDate:_currentDate];
    return [comp month];
}

// 当前时间月份星期序数
- (NSInteger)getCurrentDateTimeMonthOfWeek{
    NSDateComponents *comp = [_calender components:(NSCalendarUnitWeekOfMonth) fromDate:_currentDate];
    return [comp weekOfMonth];
}

// 当前时间年份星期序数
- (NSInteger)getCurrentDateTimeYearOfWeek{
    NSDateComponents *comp = [_calender components:(NSCalendarUnitWeekOfYear) fromDate:_currentDate];
    return [comp weekOfYear];
}

// 指定年月中月份第一天时间格式化
- (NSString *)getFisrtDayWithYear:(NSInteger)year month:(NSInteger)month format:(NSString *) format{
    NSDate *timeDate = [self getParaDateWithYear:year month:month format:format];
    NSTimeInterval timeInterval = 0;
    NSDate *beginDate = nil;
    NSDate *endingDate = nil;
    BOOL result = [_calender rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&timeInterval forDate:timeDate];
    if (result) {
        endingDate = [beginDate dateByAddingTimeInterval:timeInterval - 1];
    }
    return  [self getParaFormatStringWithParaDate:endingDate];
    
}
// 指定年月下 当月天数
- (NSInteger)getTotalNumbersOfDayWithYear:(NSInteger)year month:(NSInteger)month{
    return [_calender rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[self getParaDateWithYear:year month:month format:@"yyyy-MM"]].length;
}

- (NSString *)getCurrentDateInWeekOfFirstDayAndEndingDay{
    NSDateComponents *comp = [_calender components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:_currentDate];
    // 得到星期几// 1(星期天) 2(星期一) 3(星期二) 4(三) 5(四) 6(星期五) 7(星期六)
    NSInteger weekDay = [comp weekday]; // 得到日期
    NSInteger day = [comp day];
    // 计算当前日期和本周周一周天相差天数
    long firstDiff,lastDiff;
    if (weekDay == 1) {
        firstDiff = 1;
        lastDiff = 0;
    }else{
        firstDiff = [_calender firstWeekday] - weekDay;
        lastDiff = 8 - weekDay;
    }
    // 当前时间（去掉时分秒）基础加上相差天数
    [comp setDay: day + firstDiff];
    NSDate *firstDayOfWeek = [_calender dateFromComponents:comp];
    [comp setDay:day + lastDiff];
    NSDate *lastDayOfWeek = [_calender dateFromComponents:comp];
    NSString *firstDay = [self getParaFormatStringWithParaDate:firstDayOfWeek format:@"yyyy-MM-dd"];
    NSString *lastDay = [self getParaFormatStringWithParaDate:lastDayOfWeek format:@"yyyy-MM-dd"];
    return [NSString stringWithFormat:@"%@,%@",firstDay,lastDay];
}

- (NSArray *) getParaDateArrayWithYear:(NSInteger)year month:(NSInteger)month weekOfMonth:(NSInteger)weekOfMonth{
    NSMutableArray *array = [NSMutableArray array];
    NSDate *timeDate = [NSDate dateWithYear:year month:month day:1];
    for (NSInteger i = 1; i <= timeDate.daysInMonth; i ++) {
        if (timeDate.weekOfMonth == weekOfMonth) {
            [array addObject:timeDate];
        }
        timeDate = [timeDate dateByAddingDays:1];
    }
    return array;
}

// 时间描述
- (NSString *)getParaTimeDescriputionWithTimeInterval:(NSTimeInterval)timeInterval{
    NSString *description;
    NSDate *timeDate = [self getParaDateSince1970WithTimeIntavel:timeInterval];
    NSDateComponents *comp = [_calender components:NSCalendarUnitHour | NSCalendarUnitMinute fromDate:timeDate toDate:_currentDate options:NSCalendarWrapComponents];
    if ([timeDate isThisYear]) {
        if ([timeDate isToday]) {
            if (comp.hour >= 1) {
                description = [NSString stringWithFormat:@"%ld小时前",comp.hour];
            }else if (comp.minute >= 2){
                description = [NSString stringWithFormat:@"%ld分钟前",comp.minute];
            }else{
                description = @"刚刚";
            }
        }else if ([timeDate isYesterday]){
            description = [self getParaFormatStringWithParaDate:timeDate format:@"昨天 HH:mm"];
        }else{
            description = [self getParaFormatStringWithParaDate:timeDate format:@"MM-dd"];
        }
    }else{
        description = [self getParaFormatStringWithParaDate:timeDate format:@"yyyy-MM-dd"];
    }
    return description;
}
// 指定时间 第一天星期
- (NSInteger)getWeeklyOrdinalityOfFisrtDayWithParaDate:(NSDate *)paraDate{
    
    return [_calender ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:paraDate];
}

// 指定年月获取NSDate
- (NSDate *)getParaDateWithYear:(NSInteger)year month:(NSInteger)month format:(nonnull NSString *)format{
    NSString *timeString = [NSString stringWithFormat:@"%ld-%ld",year,month];
    [self setFormatString:format];
    return [_formatter dateFromString:timeString];
}
// 指定时间格式 根据时间描述获取NSDate
- (NSDate *) getParaDateWithFormatTime:(NSString *) formatTime format:(NSString *)format{
    [self setFormatString:format];
    return [_formatter dateFromString:formatTime];
}
// 指定时间戳 获取当前时间NSDate
- (NSDate *)getParaDateSinceNowWithTimeIntavel:(NSTimeInterval)paraTimeInterval{
    return [NSDate dateWithTimeIntervalSinceNow:paraTimeInterval];
}
// 指定时间戳 获取1970开始时间NSDate
- (NSDate *)getParaDateSince1970WithTimeIntavel:(NSTimeInterval)paraTimeInterval{
    return [NSDate dateWithTimeIntervalSince1970:paraTimeInterval];
}
// 指定时间格式获取时间timeInterval
- (NSTimeInterval)getParaTimeIntervalWithFormatTime:(NSString *)formatTime format:(NSString *)format{
    [self setFormatString:format];
    return [self getParaTimeIntervalWithFormatTime:formatTime];
}
// 默认时间格式获取时间timeInterval
- (NSTimeInterval)getParaTimeIntervalWithFormatTime:(NSString *)formatTime{
    NSDate *formatDate = [_formatter dateFromString:formatTime];
    return  [self getParaTimeIntervalWithParaDate:formatDate];
}
// 指定时间格式 根据timeInterval获取时间描述
- (NSString *)getParaFormatStringSince1970WithTimeInterval:(NSTimeInterval)paraTimeInterval format:(NSString *)format{
    [self setFormatString:format];
    return [self getParaFormatStringSince1970WithTimeInterval:paraTimeInterval];
}
// 默认时间格式 根据timeInterval获取时间描述
- (NSString *)getParaFormatStringSince1970WithTimeInterval:(NSTimeInterval)paraTimeInterval{
    return [_formatter stringFromDate:[self getParaDateSince1970WithTimeIntavel:paraTimeInterval]];
}
// 指定时间格式 根据paraDate 获取时间戳
- (NSString *)getParaFormatStringWithParaDate:(NSDate *)paraDate format:(NSString *)format{
    [self setFormatString:format];
    return [self getParaFormatStringWithParaDate:paraDate];
}
// 默认时间格式 根据paraDate 获取时间戳
- (NSString *)getParaFormatStringWithParaDate:(NSDate *)paraDate{
    return [_formatter stringFromDate:paraDate];
}
// 根据paraDate 获取1970年时间戳
- (NSTimeInterval)getParaTimeIntervalWithParaDate:(NSDate *)paraDate{
    return [paraDate timeIntervalSince1970];
}

// 获取当前时间自1970时间戳
- (NSTimeInterval)getCurrentTimeInterval{
    return [_currentDate timeIntervalSince1970];
}

- (void)setFormatString:(NSString *)formatString{
    _formatString = formatString;
    [_formatter setDateFormat:formatString];
}


@end
