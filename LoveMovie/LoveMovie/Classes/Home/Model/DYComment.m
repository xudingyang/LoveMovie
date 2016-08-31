//
//  DYComment.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/25.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYComment.h"
#import "NSString+DYExt.h"
#import "NSDate+DYExt.h"

@implementation DYComment

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"commentID" : @"id"};
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"replies" : @"DYComment"};
}

- (NSString *)publishDate{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.modifyTime];
    NSDate *perkingTime = [NSDate dateWithTimeInterval:- 8 * 60 *60 sinceDate:date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *str = [fmt stringFromDate:perkingTime];
    
    return str;
}

- (CGFloat)viewHeight{
    CGFloat viewHeight = 0;
    CGSize maxSize = CGSizeMake(DYScreenWidth - 35, 60);
    
    CGFloat textHeight = [[NSString trimedSpaceReturnWithString:self.content]   boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size.height;
    viewHeight = textHeight + 170;
    return viewHeight;
}

- (NSString *)publishTime {
    NSDate *publishDate = [NSDate dateWithTimeIntervalSince1970:self.timestamp];
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
