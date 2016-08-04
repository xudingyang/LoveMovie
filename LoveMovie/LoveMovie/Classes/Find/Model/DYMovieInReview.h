//
//  DYMovieInReview.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/19.
//  Copyright © 2016年 许定阳. All rights reserved.
//  DYReview类的子属性类

#import <Foundation/Foundation.h>

@interface DYMovieInReview : NSObject
/**
 "relatedObj":{
 "type":1,
 "id":209122,     // 电影ID
 "title":"美国队长3",
 "rating":"8.0",
 "image":"http://img31.mtime.cn/mt/2016/04/14/113933.51191278_1280X720X2.jpg”     //电影图片
 }
 */
/** 电影名字 */
@property (copy, nonatomic) NSString *title;
/** 电影小图片的url */
@property (copy, nonatomic) NSString *image;

@end
