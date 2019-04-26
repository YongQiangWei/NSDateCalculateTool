//
//  NSDateCalculateHelper.m
//  NSDateCalculateHelper
//
//  Created by YongQiang Wei on 2019/4/25.
//  Copyright © 2019 YongQiang Wei. All rights reserved.
//

#import "NSDateCalculateHelper.h"
#import "NSDate+DateCategory.h"
#import "DateTools.h"
@interface NSDateCalculateHelper ()

@property (nonatomic, strong) NSDate *currentDate;

@property (nonatomic, strong) NSDateFormatter *formatter;

@property (nonatomic, strong) NSCalendar *calender;

@property (nonatomic, strong) NSDateComponents *components;

@end

@implementation NSDateCalculateHelper
#pragma mark --- 单例创建
+ (NSDateCalculateHelper *)sharedCalculateHelper{
    static NSDateCalculateHelper *singleton;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[NSDateCalculateHelper alloc] init];
        singleton.calendarFirstWeekDay = 2;
        singleton.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    });
    return singleton;
}

- (NSInteger)getEraForCurrentDate{
    return [self.components era];
}

- (NSInteger)getQuarterForCurrentDate{
    return [self.components quarter];
}

- (NSInteger)getYearForCurrentDate{
    return [self.components year];
}
- (NSInteger)getMonthForCurrentDate{
    return [self.components month];
}
- (NSInteger)getDayForCurrentDate{
    return [self.components day];
}
- (NSInteger)getWeekOfMonthForCurrentDate{
    return [self.components weekOfMonth];
}

- (NSInteger)getWeekOfYearForCurrentDate{
    return [self.components weekOfYear];
}

- (NSInteger)getWeekDayForCureentDate{
    return [self.components weekday];
}

- (NSInteger)getWeekOrdinalityOfFirstDayForCurrentDate{
    return [self.calender ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:self.currentDate];
    
}

- (NSInteger)getWeekOrdinalityOfFirstDayForParaDate:(NSDate *)paraDate{
    return [_calender ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:paraDate];
}

- (NSInteger)getNumberOfDayForCurrentDate{
    return [self.calender rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self.currentDate].length;
}

- (NSInteger)getNumberOfDayForParaDate:(NSDate *)paraDate{
    return [self.calender rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:paraDate].length;
}

- (NSInteger)getNumberOfDayForParaTimeInterval:(NSTimeInterval)timeInterval{
    return [self getNumberOfDayForParaDate:[self getDateSince1970ForTimeInterval:timeInterval]];
}

- (NSInteger)getNumberOfDayForParaFormatDate:(NSString *)formatTime{
    return [self getNumberOfDayForParaDate:[self getDateForParaFormatTime:formatTime]];
}

- (NSInteger)getNumberOfDayForParaFormatDate:(NSString *)formatTime withFormat:(NSString *)formatString{
    return [self getNumberOfDayForParaDate:[self getDateForParaFormatTime:formatTime withFormat:formatString]];
}

- (NSDate *)getDateSince1970ForTimeInterval:(NSTimeInterval)timeInterval{
    return [NSDate dateWithTimeIntervalSince1970:timeInterval];
}

- (NSDate *)getDateForParaFormatTime:(NSString *)formatTime{
    return [self.formatter dateFromString:formatTime];
}

- (NSDate *)getDateForParaFormatTime:(NSString *)formatTime withFormat:(NSString *)formatString{
    [self.formatter setDateFormat:formatString];
    return [self.formatter dateFromString:formatTime];
}

- (NSDate *)getDateByYear:(NSInteger)year Month:(NSInteger)month{
    NSString *timeString = [NSString stringWithFormat:@"%ld-%ld",year,month];
    [self.formatter setDateFormat:@"yyyy-MM"];
    return [self.formatter dateFromString:timeString];
}

- (NSInteger)compareTimeInterval:(NSTimeInterval)timeInterval{
    NSTimeInterval currentTimeInterval = [self getTimeIntervalCurrentDate];
    if (timeInterval < currentTimeInterval) {
        return -1;
    }else if (timeInterval == currentTimeInterval){
        return 0;
    }else if(timeInterval > currentTimeInterval){
        return 1;
    }else{
        return 1000;
    }
}

- (NSTimeInterval)getTimeIntervalCurrentDate{
    return [self.currentDate timeIntervalSince1970];
}

- (NSTimeInterval)getTimeIntervalParameterDate:(NSDate *)paramDate{
    return [paramDate timeIntervalSince1970];
}

- (NSTimeInterval)getTimeIntervalParameterFormatDate:(NSString *)formatDate{
    NSDate *paramDate = [_formatter dateFromString:formatDate];
    return [self getTimeIntervalParameterDate:paramDate];
}

- (NSTimeInterval)getTimeIntervalParameterFormatDate:(NSString *)formatDate format:(NSString *)formatString{
    [self.formatter setDateFormat:formatString];
    return [self getTimeIntervalParameterFormatDate:formatDate];
}

- (NSString *) getFormatTimeForCurrentDate{
    return [self.formatter stringFromDate:self.currentDate];
}
- (NSString *)getFormatTimeForCurrentDateForFormatter:(NSString *)formatString{
    [self.formatter setDateFormat:formatString];
    return [self.formatter stringFromDate:self.currentDate];
}

- (NSString *) getFormatTimeForParaDate:(NSDate *)paraDate{
    return [self.formatter stringFromDate:paraDate];
}

- (NSString *)getFormatTimeForParaDate:(NSDate *)paraDate dateFormat:(NSString *)formatString{
    [self.formatter setDateFormat:formatString];
    return [self.formatter stringFromDate:paraDate];
}

- (NSString *) getFormatTimeForParaTimeInterval:(NSTimeInterval)timeInterval{
    return [self.formatter stringFromDate:[self getDateSince1970ForTimeInterval:timeInterval]];
}

- (NSString *)getFormatTimeForParaTimeInterval:(NSTimeInterval)timeInterval dateFormat:(NSString *)formatString{
    [self.formatter setDateFormat:formatString];
    return [self getFormatTimeForParaTimeInterval:timeInterval];
}
- (NSString *)getDateDescriputionForParaTimeInterval:(NSTimeInterval)timeInterval{
    NSString *description;
    NSDate *timeDate = [self getDateSince1970ForTimeInterval:timeInterval];
    NSDateComponents *comp = [self.calender components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour fromDate:timeDate toDate:self.currentDate options:(NSCalendarWrapComponents)];
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
            description = [self getFormatTimeForParaDate:timeDate dateFormat:@"昨天 HH:mm"];
        }else{
            description = [self getFormatTimeForParaDate:timeDate dateFormat:@"MM-dd"];
        }
    }else{
        description = [self getFormatTimeForParaDate:timeDate dateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    return description;
}

- (NSArray *)getWeekOfMonthArrayByYear:(NSInteger)year Month:(NSInteger)month WeekOfMonth:(NSInteger)weekOfMonth{
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
#pragma mark --- lazy loading

- (NSDateFormatter *)formatter{
    if (!_formatter) {
        _formatter = [[NSDateFormatter alloc] init];
        [_formatter setDateFormat:_dateFormat];
    }
    return _formatter;
}
- (NSDate *)currentDate{
    if (!_currentDate) {
        _currentDate = [NSDate date];
    }
    return _currentDate;
}
- (NSCalendar *)calender{
    if (!_calender) {
        _calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        _calender.firstWeekday = _calendarFirstWeekDay;
    }
    return _calender;
}

- (NSDateComponents *)components{
    if (!_components) {
        NSInteger calendarUnit = NSCalendarUnitEra | NSCalendarUnitQuarter | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekdayOrdinal;
        _components = [self.calender components:calendarUnit fromDate:self.currentDate];
    }
    return _components;
}

- (void)setDateFormat:(NSString *)dateFormat{
    _dateFormat = dateFormat;
    [self.formatter setDateFormat:dateFormat];
}

- (void)setCalendarFirstWeekDay:(NSInteger)calendarFirstWeekDay{
    _calendarFirstWeekDay = calendarFirstWeekDay;
    self.calender.firstWeekday = calendarFirstWeekDay;
}
@end
