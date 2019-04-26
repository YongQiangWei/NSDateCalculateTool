//
//  NSDateFormatter+Category.m
//  NSDateCalculateHelper
//
//  Created by YongQiang Wei on 2019/4/26.
//  Copyright © 2019 YongQiang Wei. All rights reserved.
//

#import "NSDateFormatter+Category.h"

@implementation NSDateFormatter (Category)

+ (id)dateFormatter{
    return [[self alloc] init];
}

+ (id)dateFormatterWithFormat:(NSString *)dateFormat{
    NSDateFormatter *dateFormatter = [[self alloc] init];
    dateFormatter.dateFormat = dateFormat;
    return dateFormatter;
}

+ (id)defaultDateFormatter{
    return [self dateFormatterWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}
@end
