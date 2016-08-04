//
//  NSString+DYExt.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/25.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DYExt)

/**
 *  消除首尾的空格和换行，消除中间的空格和换行
 *
 *  @return 消除空格后的字符串
 */
+ (NSString *)trimedSpaceReturnWithString:(NSString *)string;

@end
