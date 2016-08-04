//
//  DYComingMovie.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/17.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 "attention":[
 {
 "releaseDate":"5月12日上映",
 "locationName":"美国",
 "isFilter":false,
 }]
 */
@interface DYComingMovie : NSObject

/** id */
@property (assign, nonatomic) NSInteger moviewID;  // id
/** name */
@property (copy, nonatomic) NSString *movieName;  // title
/** 图片url */
@property (copy, nonatomic) NSString *image;
/** 上映年份 */
@property (assign, nonatomic) NSInteger rYear;
/** 上映月份 */
@property (assign, nonatomic) NSInteger rMonth;
/** 上映日期 */
@property (assign, nonatomic) NSInteger rDay;
/** 电影类型 */
@property (copy, nonatomic) NSString *type;
/** 导演 */
@property (copy, nonatomic) NSString *director;
/** 主角1 */
@property (copy, nonatomic) NSString *actor1;
/** 主角2 */
@property (copy, nonatomic) NSString *actor2;
/** isTicket 显示“预售”。false显示“上映提醒” */
@property (assign, nonatomic) BOOL isTicket;
/** 想看人数 */
@property (assign, nonatomic) NSInteger wantedCount;
/** 有没有预告片 false表示没有视频，不显示“预告片” */
@property (assign, nonatomic) BOOL isVideo;

/** showDateArea */
@property (copy, nonatomic) NSString *showDateArea;
@end
