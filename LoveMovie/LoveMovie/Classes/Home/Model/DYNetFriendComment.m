//
//  DYNetFriendComment.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/26.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYNetFriendComment.h"
#import "NSDate+DYExt.h"
#import "NSString+DYExt.h"

@implementation DYNetFriendComment

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"content" : @"ce",
             @"name" : @"ca",
             @"publishTime" : @"cd",
             @"rating" : @"cr"
             };
}

- (NSString *)publishDate{
    
    NSDate *publishDate = [NSDate dateWithTimeIntervalSince1970:self.publishTime];
    // 因为服务器发来的时间是中国时间，所以这里要换到统一参照系（0时区）来计算。
    publishDate = [NSDate dateWithTimeInterval:- 8 * 60 *60 sinceDate:publishDate];
    NSString *publishDateStr = nil;
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
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


- (CGFloat)viewHeight{
//    CGFloat viewHeight = 0;
//    CGSize maxSize = CGSizeMake(DYScreenWidth - 80, 80);
//    
//    CGFloat textHeight = [[NSString trimedSpaceReturnWithString:self.content]   boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size.height;
////    viewHeight = textHeight + 132;
////    return viewHeight;
    return 60 + 132;
}
@end
