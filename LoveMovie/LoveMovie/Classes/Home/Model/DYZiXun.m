//
//  DYZiXun.m
//  LoveMovie
//
//  Created by xudingyang on 16/6/4.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYZiXun.h"
#import "NSDate+DYExt.h"

@implementation DYZiXun

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID" : @"id",
             @"movieInZiXun" : @"relatedObj"
             };
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"movies" : @"DYMovieInBangDan"};
}

/**
 *             if ([zixun.tag isEqualToString:@"简讯"] || [zixun.tag isEqualToString:@"头条"] || [zixun.tag isEqualToString:@"影评"] || [zixun.tag isEqualToString:@"图集"] || [zixun.tag isEqualToString:@"新片"] || [zixun.tag isEqualToString:@"欧美新片"] || [zixun.tag isEqualToString:@"日韩新片"] || [zixun.tag isEqualToString:@"猜电影"] || [zixun.tag isEqualToString:@"榜单"] || [zixun.tag isEqualToString:@"电影榜单"] || [zixun.tag isEqualToString:@"爆笑片单"] || [zixun.tag isEqualToString:@"电视榜单"] ) {
 */

- (CGFloat)cellHeight {
    CGFloat height = 0;
    if ([self.tag isEqualToString:@"简讯"]) {
        height = 190;
    } else if ([self.tag isEqualToString:@"头条"]) {
        height = 340;
    } else if ([self.tag isEqualToString:@"影评"]) {
        height = 200;
    } else if ([self.tag isEqualToString:@"图集"]) {
        height = 380;
    } else if ([self.tag isEqualToString:@"欧美新片"] || [self.tag isEqualToString:@"日韩新片"]) {
        height = 200;
    } else if ([self.tag isEqualToString:@"猜电影"]) {
        height = 180;
    } else if ([self.tag isEqualToString:@"榜单"] || [self.tag isEqualToString:@"电影榜单"] || [self.tag isEqualToString:@"电视榜单"] || [self.tag isEqualToString:@"爆笑片单"]) {
        height = 360;
    } else {
        height = 0;
    }
    return height;
}

- (NSString *)publishDate{
    if ([self.tag isEqualToString:@"影评"] || [self.tag isEqualToString:@"猜电影"] || [self.tag isEqualToString:@"欧美新片"] || [self.tag isEqualToString:@"日韩新片"] || [self.tag isEqualToString:@"榜单"] || [self.tag isEqualToString:@"电影榜单"] || [self.tag isEqualToString:@"电视榜单"] || [self.tag isEqualToString:@"爆笑片单"]) {
        return nil;
    }
    NSDate *publishDate = [NSDate dateWithTimeIntervalSince1970:self.publishTime];
    // 因为服务器发来的时间是中国时间，所以这里要换到统一参照系（0时区）来计算。
    publishDate = [NSDate dateWithTimeInterval:- 8 * 60 *60 sinceDate:publishDate];
    NSString *publishDateStr = nil;
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    if (![publishDate isThisYear]) {   // 不是今年
        [fmt setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        publishDateStr = [fmt stringFromDate:publishDate];
    } if ([publishDate isToday]) { // 是今天
        NSDateComponents *cmps = [NSDate deltaFrom:publishDate to:[NSDate date]];
        if (cmps.hour >= 1) {
            publishDateStr = [NSString stringWithFormat:@"%zd小时前", cmps.hour];
        } else if (cmps.minute >= 1) {
            publishDateStr = [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
        } else {
            publishDateStr = @"刚刚";
        }
    } else if ([publishDate isYesterday]) {  // 是昨天
        [fmt setDateFormat:@"昨天 HH:mm:ss"];
        publishDateStr = [fmt stringFromDate:publishDate];
    } else { // 是今年，但是不是今天也不是昨天
        [fmt setDateFormat:@"MM-dd HH:mm:ss"];
        publishDateStr = [fmt stringFromDate:publishDate];
    }
    return publishDateStr;
}

@end
