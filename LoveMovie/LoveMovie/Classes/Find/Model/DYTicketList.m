//
//  DYTicketList.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/21.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYTicketList.h"

@implementation DYTicketList
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"movies" : @"DYMovieInTicketList"};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"header" : @"topList"
             };
}

@end
