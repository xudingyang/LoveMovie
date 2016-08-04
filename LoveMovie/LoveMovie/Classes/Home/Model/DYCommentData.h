//
//  DYCommentData.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/26.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DYCommentData : NSObject
/**
 *      "data":{
 "cts":Array[20],
 "tpc":10,
 "totalCount":5280
 }
 */
/** totalCount */
@property (assign, nonatomic) NSInteger totalCount;
/** commentArray */
@property (strong, nonatomic) NSArray *cts;

@end
