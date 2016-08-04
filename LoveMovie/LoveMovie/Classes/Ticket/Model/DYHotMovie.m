//
//  DYHotMovie.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/16.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYHotMovie.h"
#import "NSDate+DYExt.h"

@implementation DYHotMovie

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"movieName" : @"tCn",
             @"movieScore" : @"r",
             @"moviewIcon" : @"img",
             @"showingDay" : @"rd",
             @"specialComment" : @"commonSpecial",
             @"cinemaCount" : @"NearestCinemaCount",
             @"showCount" : @"NearestShowtimeCount",
             @"moviewID" : @"id",
             @"movieLenght" : @"d",
             @"englishName" : @"tEn"
             };
}

// "rd":"20160506”,
- (NSString *)showingDay{
    NSString *showDate = nil;
//    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//    [fmt setDateFormat:@"yyyyMMdd"];
//    NSDate *date = [fmt dateFromString:_showingDay];
    
    NSDate *date = [self showDate];
    // 消除个位月份和日期第一位的0
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *compentens = [[NSDateComponents alloc] init];
    NSCalendarUnit unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    compentens = [calendar components:unitFlags fromDate:date];
    NSInteger year = compentens.year;
    NSInteger month = compentens.month;
    NSInteger day = compentens.day;
    
    if ([date isThisYear]) {
        showDate = [NSString stringWithFormat:@"%zd月%zd日上映", month, day];
    } else {
        showDate = [NSString stringWithFormat:@"%zd年%zd月%zd日上映", year, month, day];
    }
    return showDate;
}

- (NSDate *)showDate{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"yyyyMMdd"];
    NSDate *date = [fmt dateFromString:_showingDay];
    return date;
}

- (NSString *)showDateArea{
    NSString *showDate = nil;    
    NSDate *date = [self showDate];
    // 消除个位月份和日期第一位的0
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *compentens = [[NSDateComponents alloc] init];
    NSCalendarUnit unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    compentens = [calendar components:unitFlags fromDate:date];
    NSInteger year = compentens.year;
    NSInteger month = compentens.month;
    NSInteger day = compentens.day;
    showDate = [NSString stringWithFormat:@"%zd年%zd月%zd日中国上映", year, month, day];
    return showDate;
}
@end
