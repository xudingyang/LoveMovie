//
//  DYHomeMovie.m
//  LoveMovie
//
//  Created by xudingyang on 16/6/3.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYHomeMovie.h"

@implementation DYHomeMovie


- (NSString *)showDateArea{
    NSString *str = nil;
    str = [NSString stringWithFormat:@"%zd年%zd月%zd日中国上映", self.rYear, self.rMonth, self.rDay];
    return str;
}

@end
