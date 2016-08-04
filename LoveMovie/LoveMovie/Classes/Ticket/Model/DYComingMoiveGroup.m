//
//  DYComingMoiveGroup.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/18.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYComingMoiveGroup.h"
#import "DYComingMovie.h"

@implementation DYComingMoiveGroup

//// 这个数组(top_cmt)里面，放的是(DYComment)这个模型
//+ (NSDictionary *)mj_objectClassInArray{
////    return @{@"top_cmt" : [DYComment class]};
////    上边方法依赖头文件，若不想依赖头文件，可以用下边的方法
//    return @{@"top_cmt" : @"DYComment"};
//}

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"comingMoives" : [DYComingMovie class]};
}


@end
