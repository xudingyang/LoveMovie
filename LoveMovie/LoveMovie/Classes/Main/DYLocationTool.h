//
//  DYLocationTool.h
//  LoveMovie
//
//  Created by xudingyang on 16/6/2.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CLLocation;

@interface DYLocationTool : NSObject

/**
 *  定位工具
 *
 *  @return 单例
 */
+ (instancetype)sharedLoactionTool;

/**
 *  当前位置与目标位置的距离
 *
 *  @param latitude  目标位置的纬度
 *  @param longitude 目标位置的经度
 *
 *  @return 两地的距离（单位：米）
 */
- (CGFloat)distanceFromLatitude:(CGFloat)latitude andLongitude:(CGFloat)longitude;

/** 是否要切换城市 */
@property (assign, nonatomic) BOOL isChageCity;
/** distance */
@property (assign, nonatomic) CGFloat distance;

@end
