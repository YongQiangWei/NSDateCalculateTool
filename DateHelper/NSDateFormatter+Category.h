//
//  NSDateFormatter+Category.h
//  NSDateCalculateHelper
//
//  Created by YongQiang Wei on 2019/4/26.
//  Copyright © 2019 YongQiang Wei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDateFormatter (Category)
+ (id)dateFormatter;
+ (id)dateFormatterWithFormat:(NSString *)dateFormat;

+ (id)defaultDateFormatter;/*yyyy-MM-dd HH:mm:ss*/
@end

NS_ASSUME_NONNULL_END
