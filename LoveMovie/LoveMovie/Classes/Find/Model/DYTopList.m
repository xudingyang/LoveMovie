//
//  DYTopList.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/19.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYTopList.h"

@implementation DYTopList
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"topListID" : @"id"
             };
}
@end
