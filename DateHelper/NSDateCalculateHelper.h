//
//  NSDateCalculateHelper.h
//  NSDateCalculateHelper
//
//  Created by YongQiang Wei on 2019/4/25.
//  Copyright © 2019 YongQiang Wei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDateCalculateHelper : NSObject
/**
 *  默认使用yyyy-MM-dd HH:mm:ss
 *  修改后将使用dateFormat
 */
@property (nonatomic, copy) NSString *dateFormat;
/**
 *  默认 firstWeekday = 2 (周一)
 *  修改后将使用calendarFirstWeekDay
 */
@property (nonatomic, assign) NSInteger calendarFirstWeekDay;

/**
 * NSCalendarUnit包含的值有：
 * NSCalendarUnitEra                 -- 纪元单位。对于 NSGregorianCalendar (公历)来说，只有公元前(BC)和公元(AD)；
 * 而对于其它历法可能有很多，例如日本和历是以每一代君王统治来做计算。
 * NSCalendarUnitYear                -- 年单位。值很大，相当于经历了多少年，未来多少年。
 * NSCalendarUnitMonth               -- 月单位。范围为1-12
 * NSCalendarUnitDay                 -- 天单位。范围为1-31
 * NSCalendarUnitHour                -- 小时单位。范围为0-24
 * NSCalendarUnitMinute              -- 分钟单位。范围为0-60
 * NSCalendarUnitSecond              -- 秒单位。范围为0-60
 * NSCalendarUnitWeekOfMonth / NSCalendarUnitWeekOfYear -- 周单位。范围为1-53
 * NSCalendarUnitWeekday             -- 星期单位，每周的7天。范围为1-7
 * NSCalendarUnitWeekdayOrdinal      -- 没完全搞清楚
 * NSCalendarUnitQuarter             -- 几刻钟，也就是15分钟。范围为1-4
 * NSCalendarUnitWeekOfMonth         -- 月包含的周数。最多为6个周
 * NSCalendarUnitWeekOfYear          -- 年包含的周数。最多为53个周
 * NSCalendarUnitYearForWeekOfYear   -- 没完全搞清楚
 * NSCalendarUnitTimeZone            -- 没完全搞清楚
 */


/**
 *  创建单例
 *  dateFormat 时间格式化 默认 yyyy-MM-dd HH:mm:ss
 *  calendarFirstWeekDay 日历每周开始时间  默认 FirstWeekDay  = 2 (周一)
 *  使用前请查看NSCalendarUnit说明
 *  @return NSDateCalculateHelper单例
 */
+ (NSDateCalculateHelper *) sharedCalculateHelper;

#pragma mark --- 当前时间信息获取

/**
 *  获取当前时间世纪
 *  使用前请查看NSCalendarUnit说明
 */
- (NSInteger ) getEraForCurrentDate;

/**
 *  获取当前时间季度
 *  使用前请查看NSCalendarUnit说明
 */
- (NSInteger ) getQuarterForCurrentDate;

/**
 *  获取当前时间年份
 *  @return  年份
 */
- (NSInteger ) getYearForCurrentDate;

/**
 *  获取当前时间月份
 *  @return 月份
 */
- (NSInteger ) getMonthForCurrentDate;

/**
 *  获取当前时间 日
 *  @return 日期
 */
- (NSInteger ) getDayForCurrentDate;

/**
 *  获取当前月份星期序数
 *  @return 月份星期序数
 */
- (NSInteger ) getWeekOfMonthForCurrentDate;

/**
 *  获取当前年份星期序数
 *  @return 年份星期序数
 */
- (NSInteger ) getWeekOfYearForCurrentDate;

/**
 *  获取当前日星期
 *  Sunday:1, Monday:2, Tuesday:3, Wednesday:4, Thursday:5, Friday:6, Saturday:7
 *  @return 星期几
 */
- (NSInteger ) getWeekDayForCureentDate;

/**
 *  获取当前月第一天星期
 *  @return 星期几
 */
- (NSInteger ) getWeekOrdinalityOfFirstDayForCurrentDate;

/**
 *  获取NSDate 所在月第一天星期
 *  @para paraDate 参数NSDate
 *  @return 星期几
 */
- (NSInteger ) getWeekOrdinalityOfFirstDayForParaDate:(NSDate *) paraDate;

#pragma mark --- 月份天数
/**
 *  获取当前月份天数
 *  @return 总共天数
 */
- (NSInteger ) getNumberOfDayForCurrentDate;

/**
 *  获取NSDate月份天数
 *  @para paraDate 参数NSDate
 *  @return 总共天数
 */
- (NSInteger ) getNumberOfDayForParaDate:(NSDate *) paraDate;

/**
 *  获取时间戳获取月份天数
 *  @para timeInterval 时间戳
 *  @return 总共天数
 */
- (NSInteger ) getNumberOfDayForParaTimeInterval:(NSTimeInterval ) timeInterval;

/**
 *  获取指定时间月份天数
 *  @para 默认格式化 yyyy-MM-dd HH:mm:ss
 *  @para formatTime 默认格式化时间
 *  @return 总共天数
 */
- (NSInteger ) getNumberOfDayForParaFormatDate:(NSString *) formatTime;

/**
 *  获取指定时间月份天数
 *  @para formatTime 格式化时间
 *  @para formatString 时间格式化
 *  @return 总共天数
 */
- (NSInteger ) getNumberOfDayForParaFormatDate:(NSString *) formatTime withFormat:(NSString *) formatString;

#pragma mark --- 时间比较
/**
 *  时间顺序比较
 *  @para timeInterval 比较时间戳
 *  @return -1:过去 0:现在 1:将来 1000:错误码
 */
- (NSInteger ) compareTimeInterval:(NSTimeInterval )timeInterval;

#pragma mark --- NSDate
/**
 *  NSDate 获取
 *  @para timeInterval Since1970时间戳
 *  @return NSDate since1970
 */
- (NSDate *) getDateSince1970ForTimeInterval:(NSTimeInterval ) timeInterval;

/**
 *  NSDate 获取
 *  @para formatTine 默认格式化时间
 *  @return NSDate
 */
- (NSDate *) getDateForParaFormatTime:(NSString *) formatTine;

/**
 *  NSDate 获取
 *  @para formatTime 格式化时间
 *  @para formatString 时间格式化
 *  @return NSDate
 */
- (NSDate *) getDateForParaFormatTime:(NSString *) formatTime withFormat:(NSString *) formatString;

/**
 *  NSDate 获取
 *  @para year 指定年份
 *  @para month 指定月份
 *  year  eg:2019
 *  month eg:04
 *  @return NSDate
 */
- (NSDate *) getDateByYear:(NSInteger ) year Month:(NSInteger) month;

#pragma mark --- 时间戳获取
/**
 *  获取当前时间时间戳
 */
- (NSTimeInterval ) getTimeIntervalCurrentDate;

/**
 *  获取指定NSDate时间戳
 *  @para paramDate 参数NSDate
 *  @return NSDate -> NSTimeInterval
 */
- (NSTimeInterval ) getTimeIntervalParameterDate:(NSDate *)paramDate;

/**
 *  获取格式化时间戳
 *  时间默认格式  yyyy-MM-dd HH:mm:ss
 *  @para formatDate 默认格式化时间
 *  @return NSString -> NSTimeINterval
 */
- (NSTimeInterval ) getTimeIntervalParameterFormatDate:(NSString *)formatDate;

/**
 *  获取格式化时间戳
 *  @para formatDate 格式化时间
 *  @para formatString 格式化样式
 *  @return NSString -> NSTimeINterval
 */
- (NSTimeInterval ) getTimeIntervalParameterFormatDate:(NSString *)formatDate format:(NSString *)formatString;

#pragma mark --- NSString
/**
 *  获取当前时间描述
 *  默认格式化时间 yyyy-MM-dd HH:mm:ss
 *  @return NSString
 */
- (NSString *) getFormatTimeForCurrentDate;

/**
 *  获取当前时间描述
 *  @prar formatString  指定时间格式化
 *  @return NSString
 */
- (NSString *) getFormatTimeForCurrentDateForFormatter:(NSString *) formatString;

/**
 *  获取当前时间描述
 *  默认格式化时间 yyyy-MM-dd HH:mm:ss
 *  @paraDate NSDate
 *  @return NSString
 */
- (NSString *) getFormatTimeForParaDate:(NSDate *)paraDate;

/**
 *  获取当前时间描述
 *  @paraDate NSDate
 *  @para formatString 时间格式化
 *  @return NSString
 */
- (NSString *) getFormatTimeForParaDate:(NSDate *)paraDate dateFormat:(NSString *) formatString;

/**
 *  获取当前时间描述
 *  默认格式化时间 yyyy-MM-dd HH:mm:ss
 *  @para timeInterval since1970时间戳
 *  @return NSString
 */
- (NSString *) getFormatTimeForParaTimeInterval:(NSTimeInterval )timeInterval;

/**
 *  获取当前时间描述
 *  @para timeInterval since1970时间戳
 *  @para formatString 时间格式化
 *  @return NSString
 */
- (NSString *) getFormatTimeForParaTimeInterval:(NSTimeInterval )timeInterval dateFormat:(NSString *) formatString;

#pragma mark --- 时间描述
/**
 * 获取时间描述(仿微信朋友圈)
 * @para timeInterval 时间戳
 * @return 时间描述
 */
- (NSString *) getDateDescriputionForParaTimeInterval:(NSTimeInterval ) timeInterval;

#pragma mark --- 时间数组

- (NSArray *) getWeekOfMonthArrayByYear:(NSInteger ) year Month:(NSInteger ) month WeekOfMonth:(NSInteger ) weekOfMonth;
@end

NS_ASSUME_NONNULL_END
