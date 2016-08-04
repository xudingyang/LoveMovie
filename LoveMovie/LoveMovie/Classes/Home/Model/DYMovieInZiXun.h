//
//  DYMovieInZiXun.h
//  LoveMovie
//
//  Created by xudingyang on 16/6/4.
//  Copyright © 2016年 许定阳. All rights reserved.
//  影评里的电影

#import <Foundation/Foundation.h>

@interface DYMovieInZiXun : NSObject
/**
 *             "relatedObj":{
 "type":Array[4],
 "id":83664,
 "title":"科洛弗道10号",
 "name":"科洛弗道10号",
 "titleCn":"科洛弗道10号",
 "titleEn":"10 Cloverfield Lane",
 "runtime":"103分钟",
 "url":"http://movie.mtime.com/83664/",
 "wapUrl":"http://movie.wap.mtime.com/83664/",
 "rating":7.2,
 "image":"http://img31.mtime.cn/mg/2016/06/04/102638.78865385.jpg",
 "releaseLocation":"美国"
 }
 
 {
 "id":232293,
 "name":"绝不轻易狗带",
 "nameEn":"Popstar: Never Stop Never Stopping",
 "posterUrl":"http://img31.mtime.cn/mt/2016/05/19/120050.94282296_1280X720X2.jpg",
 "decade":2016,
 "rating":0,
 "releaseLocation":"美国",
 "director":"阿吉瓦·沙弗尔",
 "actor":"安迪·萨姆伯格",
 "actor2":"伊莫珍·波茨"
 },
 */
/** titleCn */
@property (copy, nonatomic) NSString *titleCn;
/** 爆笑片单影片名 name */
@property (copy, nonatomic) NSString *name;
/** 爆笑片单图片 posterUrl */
@property (copy, nonatomic) NSString *posterUrl;
/** 爆笑片单日期 */
@property (assign, nonatomic) NSInteger decade;
/** rating */
@property (assign, nonatomic) CGFloat rating;
/** 影片图片 */
@property (copy, nonatomic) NSString *image;

@end
