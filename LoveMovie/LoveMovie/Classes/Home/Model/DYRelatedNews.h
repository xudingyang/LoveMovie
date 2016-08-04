//
//  DYRelatedNews.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/24.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DYRelatedNews : NSObject
/**
 *      "news":[
 {
 "newCount":226,
 "id":1555657,
 "type":0,
 "image":"http://img31.mtime.cn/mg/2016/05/23/114106.74753034.jpg",
 "title":"《愤怒的小鸟》周票房夺冠",
 "title2":"《美国队长3》破11亿 2016大盘迈过200亿",
 "publishTime":1464014644
 }
 ],
 */
/** 新闻条数 */
@property (assign, nonatomic) NSInteger newCount;
/** 主标题 */
@property (copy, nonatomic) NSString *title;
/** 副标题 */
@property (copy, nonatomic) NSString *title2;
/** 发布日期 秒数 */
@property (assign, nonatomic) NSInteger publishTime;
/** image url */
@property (copy, nonatomic) NSString *image;

/** 发布日期 字符串*/
@property (copy, nonatomic) NSString *publishDate;
@end
