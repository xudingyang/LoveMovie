//
//  DYHomeScrollImage.h
//  LoveMovie
//
//  Created by xudingyang on 16/6/3.
//  Copyright © 2016年 许定阳. All rights reserved.
//  轮播器的图片模型

#import <Foundation/Foundation.h>

@interface DYHomeScrollImage : NSObject
/**
 *          {
 "url":"http://m.mtime.cn/#!/news/movie/1555879/",
 "keyColor":"#888888",
 "img":"http://img31.mtime.cn/mg/2016/06/03/092317.12524205.jpg",
 "gotoPage":Object{...}
 },
 */
/** 图片img */
@property (copy, nonatomic) NSString *img;

@end
