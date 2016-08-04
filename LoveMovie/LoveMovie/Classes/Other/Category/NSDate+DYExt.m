//
//  NSDate+DYExt.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/16.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "NSDate+DYExt.h"

@implementation NSDate (DYExt)

/**
 *  比较from和self的时间差值
 */
+ (NSDateComponents *)deltaFrom:(NSDate *)from to:(NSDate *)to{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unitFlags = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unitFlags fromDate:from toDate:to options:0];
}

/**
 *  是否为今年
 */
- (BOOL)isThisYear{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear;
    NSDate *now = [NSDate date];
    NSInteger nowYear = [calendar component:unit fromDate:now];
    NSInteger thatYear = [calendar component:unit fromDate:self];
    return nowYear == thatYear;
}

/**
 *  是否为今天
 */
- (BOOL)isToday{
    // 是否为今天，如果采用NSDateComponents来判断，那还要先判断年、月，麻烦
    // 既然是今天，直接比较两者的“yyyy-MM-dd”字符串即可。
    // 注意，不可比较时间，因为时间还有时分秒，没必要用来比较今天
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"yyyy-MM-dd"];
    NSString *todayStr = [fmt stringFromDate:[NSDate date]];
    NSString *thatDateStr = [fmt stringFromDate:self];
    return [todayStr isEqualToString:thatDateStr];
}

/**
 *  是否为昨天。
 *  注意：这里不能用相隔24*60*60来比较。
 *  因为这样会导致2015-12-31 23:59:59是2016-01-01 00:00:00的昨天
 *  但是我们这里的要求是，年份变了就显示去年，而不是显示昨天。
 */
- (BOOL)isYesterday{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDate *now = [NSDate date];
    NSDate *thatDay = self;
    // 因为算时间间距的方法，是按照秒数，再转换成日期形式来返回
    // 而我们这里，只要过了24点，都算昨天了。哪怕只间隔一秒。
    // 过滤掉NSDate的时分秒，只比较年月日
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"yyyy-MM-dd"];
    NSString *nowStr = [fmt stringFromDate:now];
    NSString *thatDayStr = [fmt stringFromDate:self];
    // 再转换成NSDate
    now = [fmt dateFromString:nowStr];
    thatDay = [fmt dateFromString:thatDayStr];
    
    NSDateComponents *components = [calendar components:unitFlags fromDate:thatDay toDate:now options:0];
    return components.year == 0 && components.month == 0 && components.day == 1;

}


@end
