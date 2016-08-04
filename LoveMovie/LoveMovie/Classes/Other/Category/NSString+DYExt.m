//
//  NSString+DYExt.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/25.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "NSString+DYExt.h"

@implementation NSString (DYExt)

+ (NSString *)trimedSpaceReturnWithString:(NSString *)string{
    
    NSString *str = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    str =[str stringByReplacingOccurrencesOfString:@" " withString:@""];
    str =[str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return str;
}

@end
