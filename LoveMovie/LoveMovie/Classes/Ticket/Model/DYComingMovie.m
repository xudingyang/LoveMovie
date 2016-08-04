//
//  DYComingMovie.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/17.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYComingMovie.h"

@implementation DYComingMovie

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"movieName" : @"title",
             @"moviewID" : @"id",
             };
}


- (NSString *)showDateArea{
    NSString *str = nil;
    str = [NSString stringWithFormat:@"%zd年%zd月%zd日中国上映", self.rYear, self.rMonth, self.rDay];    
    return str;
}

@end
