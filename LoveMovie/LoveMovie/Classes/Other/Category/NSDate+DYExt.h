//
//  NSDate+DYExt.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/16.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (DYExt)

/**
 *  比较从from到self的时间差值
 */
+ (NSDateComponents *)deltaFrom:(NSDate *)from to:(NSDate *)to;

/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  是否为今天
 */
- (BOOL)isToday;

/**
 *  是否为昨天
 */
- (BOOL)isYesterday;

@end
