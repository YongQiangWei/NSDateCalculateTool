//
//  NSDataCalculateHelper.h
//  HUD
//
//  Created by Yongqiang Wei on 2018/12/24.
//  Copyright © 2018 Yongqiang Wei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDateCalculateHelper : NSObject
/**格式化时间 默认:yyyy-MM-dd HH:mm:ss*/
@property (nonatomic, copy) NSString *formatString;

/**
 * 单例创建
 * formatString 格式化时间 默认 yyyy-MM-dd HH:mm:ss
 */
+ (NSDateCalculateHelper *) sharedCalculateHelper;

#pragma mark ------ 获取当前时间  年 月 星期

/**
 * 获取当前时间年份
 * @return 年份
 */
- (NSInteger) getCurrentDateTimeOfYear;

/**
 * 获取当前时间月份
 * @return 月份
 */
- (NSInteger) getCurrentDateTimeOfMonth;

/**
 * 获取当前时间月份的星期
 * @return 星期序数
 */
- (NSInteger) getCurrentDateTimeMonthOfWeek;

/**
 * 获取当前时间年份的星期
 * @return 星期序数
 */
- (NSInteger) getCurrentDateTimeYearOfWeek;

/**
 * 指定年月获取当前月份第一天
 * @para year 指定年份
 * @para month 指定月份
 * @para format 指定格式化
 * @treturn 当前月第一天
 */
- (NSString *)getFisrtDayWithYear:(NSInteger)year month:(NSInteger)month format:(NSString *) format;

/**
 * 指定年月获取当前NSDate
 * @para year 指定年份
 * @para month 指定月份
 * @treturn NSDate
 */
- (NSDate *)getParaDateWithYear:(NSInteger) year month:(NSInteger) month format:(NSString *)format;

/**
 * 计算当前年 月份 总共天数
 * @para year 年份
 * @para month 月份
 * @return 天数
 */
- (NSInteger )getTotalNumbersOfDayWithYear:(NSInteger)year month:(NSInteger ) month;

/**
 * 计算当前NSDate 第一天为周几
 * @para paraDate NSDate
 * @return 周几
 */
- (NSInteger )getWeeklyOrdinalityOfFisrtDayWithParaDate:(NSDate *)paraDate;

/**
 * 获取当前时间本周 周一和周末
 * @return 周一 周末 时间
 */
- (NSString *) getCurrentDateInWeekOfFirstDayAndEndingDay;

/**
 * 指定年 月 本月第几周 获取本周开始至结束时间array
 * @para year 年份
 * @para month 月份
 * @para weekOfMonth 第几周
 * @return 本周起止数组
 */
- (NSArray *) getParaDateArrayWithYear:(NSInteger)year month:(NSInteger) month weekOfMonth:(NSInteger) weekOfMonth;
/**
 * 指定时间戳 与当前时间对比 获取时间描述
 * @para timeInterval 时间戳
 * @return 时间描述
 */
- (NSString *) getParaTimeDescriputionWithTimeInterval:(NSTimeInterval ) timeInterval;
#pragma mark ------ NSDate

/**
 * 传入时间戳获取NSDate SinceNow
 * @para paraTimeInterval 时间戳
 * @return NSDate
 */
- (NSDate *)getParaDateSinceNowWithTimeIntavel:(NSTimeInterval )paraTimeInterval;

/**
 * 传入时间戳获取NSDate Since1970
 * @para paraTimeInterval 时间戳
 * @return NSDate
 */
- (NSDate *)getParaDateSince1970WithTimeIntavel:(NSTimeInterval )paraTimeInterval;

#pragma mark ------ NSString format

/**
 * 传入时间戳获取格式化时间 Since1970
 * @para paraTimeInterval 时间戳
 * @para format 指定格式化
 * @return 格式化时间
 */
- (NSString *) getParaFormatStringSince1970WithTimeInterval:(NSTimeInterval) paraTimeInterval format:(NSString *)format;

/**
 * 传入时间戳获取格式化时间(yyyy-MM-dd HH:mm:ss) Since1970
 * @para paraTimeInterval 时间戳
 * @return 格式化时间
 */
- (NSString *) getParaFormatStringSince1970WithTimeInterval:(NSTimeInterval) paraTimeInterval;


/**
 * 传入NSDate 格式化输出时间
 * @para paraDate 参数NSDate
 * @para format 格式化
 * @return 格式化时间
 */
- (NSString *) getParaFormatStringWithParaDate:(NSDate *)paraDate format:(NSString *)format;

/**
 * 传入NSDate 格式化输出时间(yyyy-MM-dd HH:mm:ss)
 * @para paraDate 参数NSDate
 * @return 格式化时间
 */
- (NSString *) getParaFormatStringWithParaDate:(NSDate *)paraDate;

/**
 * 指定时间戳 获取格式化时间以及星期
 * @para timeInterval 指定时间戳
 * @format 时间格式化
 * @return 格式化时间 星期
 */
- (NSString *) getFormatTimeAndWeekOfMonthWithTimeInterval:(NSTimeInterval )timeInterval format:(NSString *) format;
#pragma mark ------ NSTimeInterval

/**
 * 传入格式化时间获取时间戳
 * @para formatTime 格式化时间
 * @para format 格式化
 * @return 时间戳
 */
- (NSTimeInterval ) getParaTimeIntervalWithFormatTime:(NSString *)formatTime format:(NSString *)format;

/**
 * 传入格式化时间获取时间戳
 * @para formatTime 格式化时间(yyyy-MM-dd HH:mm:ss)
 * @return 时间戳
 */
- (NSTimeInterval ) getParaTimeIntervalWithFormatTime:(NSString *)formatTime;

/**
 * 传入NSDate 获取时间戳
 * @para paraDate 参数Date
 * @return 返回paraDate timeInterval
 */
- (NSTimeInterval) getParaTimeIntervalWithParaDate:(NSDate *)paraDate;

/**
 * 获取当前时间戳
 */
- (NSTimeInterval) getCurrentTimeInterval;

#pragma mark ------ 时间比较
/**
 * 时间前后顺序比较
 * @para timeInterval 比较时间戳
 * @return -1:h过去 0:现在 1:将来
 */
- (NSInteger ) compareTimeInterval:(NSTimeInterval )timeInterval;

@end

NS_ASSUME_NONNULL_END
