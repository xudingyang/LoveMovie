//
//  DYHeaderInTicketList.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/21.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYHeaderInTicketList.h"

@implementation DYHeaderInTicketList

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"topListID" : @"id"
             };
}

@end
