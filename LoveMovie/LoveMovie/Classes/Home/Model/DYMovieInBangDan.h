//
//  DYMovieInBangDan.h
//  LoveMovie
//
//  Created by xudingyang on 16/6/4.
//  Copyright © 2016年 许定阳. All rights reserved.
//  榜单里的电影

#import <Foundation/Foundation.h>

@interface DYMovieInBangDan : NSObject
/**
 *                  {
 "id":11238,
 "name":"查令十字街84号",
 "nameEn":"84 Charing Cross Road",
 "posterUrl":"http://img31.mtime.cn/mt/2014/02/22/225241.72157174_1280X720X2.jpg",
 "decade":1987,
 "rating":8.3,
 "releaseLocation":"美国",
 "director":"大卫·休·琼斯",
 "actor":"安妮·班克罗夫特",
 "actor2":"安东尼·霍普金斯"
 }]
 */

/** name */
@property (copy, nonatomic) NSString *name;
/** rating */
@property (assign, nonatomic) CGFloat rating;
/** posterUrl */
@property (copy, nonatomic) NSString *posterUrl;
/** decade */
@property (assign, nonatomic) NSInteger decade;


@end
