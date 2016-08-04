//
//  DYNews.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/20.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYNews.h"
#import "DYImagesInNews.h"
#import "NSDate+DYExt.h"

@implementation DYNews
{
    CGFloat _cellHeight;
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"images" : [DYImagesInNews class]};
}

- (CGFloat)cellHeight{
    if (!_cellHeight) {
        if (self.type == 1) {  // 三图
            // 10 + 30 + 80 + 35 + 10 = 165
            _cellHeight = 165;
        } else {     // 普通/视频
            // 10 + 90 + 10 = 110
            _cellHeight = 110;
        }
    }
    return _cellHeight;
}

- (NSString *)publishDate{
    NSDate *publishDate = [NSDate dateWithTimeIntervalSince1970:self.publishTime];
    // 因为服务器发来的时间是中国时间，所以这里要换到统一参照系（0时区）来计算。
    publishDate = [NSDate dateWithTimeInterval:- 8 * 60 *60 sinceDate:publishDate];
    NSString *publishDateStr = nil;
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//    [fmt setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    if (![publishDate isThisYear]) {   // 不是今年
        [fmt setDateFormat:@"yyyy-MM-dd HH:mm"];
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
        [fmt setDateFormat:@"昨天 HH:mm"];
        publishDateStr = [fmt stringFromDate:publishDate];
    } else { // 是今年，但是不是今天也不是昨天
        [fmt setDateFormat:@"MM-dd HH:mm"];
        publishDateStr = [fmt stringFromDate:publishDate];
    }
    return publishDateStr;
}

@end
