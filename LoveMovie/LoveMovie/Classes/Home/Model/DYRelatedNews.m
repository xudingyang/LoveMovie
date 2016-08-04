//
//  DYRelatedNews.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/24.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYRelatedNews.h"

@implementation DYRelatedNews

- (NSString *)publishDate{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.publishTime];
    NSDate *perkingTime = [NSDate dateWithTimeInterval:- 8 * 60 *60 sinceDate:date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *str = [fmt stringFromDate:perkingTime];
    
    return str;
}

@end
