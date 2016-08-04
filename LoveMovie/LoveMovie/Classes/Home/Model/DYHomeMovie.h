//
//  DYHomeMovie.h
//  LoveMovie
//
//  Created by xudingyang on 16/6/3.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DYHomeMovie : NSObject
/**
 *      "movies":[
 {
 "movieId":209122,   //电影的ID。与“热映”模块的模型不同。
 "titleCn":"美国队长3",
 "titleEn":"Captain America: Civil War",
 "img":"http://img31.mtime.cn/mt/2016/04/14/113933.51191278_1280X720X2.jpg",
 "ratingFinal":8,
 "length":147,
 "directorName":"安东尼·罗素",
 "actorName1":"克里斯·埃文斯",
 "actorName2":"小罗伯特·唐尼",
 "type":"动作 | 冒险 | 科幻",
 "rYear":2016,
 "rMonth":5,
 "rDay":6,
 "isNew":false,
 "isHot":false,
 "commonSpecial":"CP全翻脸，盾冬比金坚",
 "btnText":"",
 "wantedCount":10129,
 "isFilter":false,
 "is3D":true,
 "isIMAX":false,
 "isIMAX3D":true,
 "isDMAX":true,
 "nearestShowtime":{
 "nearestCinemaCount":58,
 "nearestShowtimeCount":75,
 "nearestShowDay":1462435200,
 "isTicket":true
 }
 }]
 */
/** movieId */
@property (assign, nonatomic) NSInteger movieId;
/** 中文名字titleCn */
@property (copy, nonatomic) NSString *titleCn;
/** 英文名字titleEn */
@property (copy, nonatomic) NSString *titleEn;
/** 图片url */
@property (copy, nonatomic) NSString *img;
/** 评分 */
@property (assign, nonatomic) CGFloat ratingFinal;
/** 时长 */
@property (assign, nonatomic) NSInteger length;
/** 导演directorName */
@property (copy, nonatomic) NSString *directorName;
/** 演员1 */
@property (copy, nonatomic) NSString *actorName1;
/** 演员2 */
@property (copy, nonatomic) NSString *actorName2;
/** 类型 */
@property (copy, nonatomic) NSString *type;
/** 年 */
@property (assign, nonatomic) NSInteger rYear;
/** 月 */
@property (assign, nonatomic) NSInteger rMonth;
/** 日 */
@property (assign, nonatomic) NSInteger rDay;
/** 特殊评论 */
@property (copy, nonatomic) NSString *commonSpecial;
/** 是否3D */
@property (assign, nonatomic) BOOL is3D;
/** 是否isIMAX3D */
@property (assign, nonatomic) BOOL isIMAX3D;
/** isTicket */
@property (assign, nonatomic) BOOL isTicket;
/** showDateArea */
@property (copy, nonatomic) NSString *showDateArea;
///** 中国巨幕isDMAX */
//@property (assign, nonatomic) BOOL isDMAX;
///** 是否isIMAX */
//@property (assign, nonatomic) BOOL isIMAX;

@end
