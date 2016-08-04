//
//  DYHotMovie.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/16.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DYHotMovie : NSObject

/** 
 
 "ms":[
 {
 "id":209122,
 "t":"美国队长3",
 "tCn":"美国队长3",
 "tEn":"Captain America: Civil War",
 "r":8,
 "rc":4633,
 "img":"http://img31.mtime.cn/mt/2016/04/14/113933.51191278_1280X720X2.jpg",
 "dN":"安东尼·罗素",
 "aN1":"克里斯·埃文斯",
 "aN2":"小罗伯特·唐尼",
 "p":[
 "动作",
 "冒险",
 "科幻",
 "惊悚"
 ],
 "rd":"20160506”,  //上映日期。如果在今日之后且可以购票，则显示“预售”
 "d":"147分钟",
 "cC":75,
 "sC":4344,
 "rsC":0,
 "NearestCinemaCount":58,    //58家影院
 "NearestShowtimeCount":75,  //75场
 "NearestDay":1462435200,   //  16年05月05日 16:00:00
 "ua":0,
 "isNew":false,
 "isHot":false,
 "isTicket":true,       //可以购票。如果不售票，且日期在今天之前，那么显示“查影讯”
 "commonSpecial":"不是内战，而是内讧",
 "isFilter":false,
 "wantedCount":10369,
 "movieType":"动作 | 冒险 | 科幻",
 "is3D":true,
 "isIMAX":false,
 "isIMAX3D":true,
 "isDMAX":true,
 "versions":[
 {
 "enum":2,
 "version":"3D"
 },
 {
 "enum":4,
 "version":"IMAX3D"
 },
 {
 "enum":6,
 "version":"中国巨幕"
 }
 ]
 }]
 
 */

/** 名称  movieName */
@property (copy, nonatomic) NSString *movieName;  // tCn
/** enlishName */
@property (copy, nonatomic) NSString *englishName; // tEn
/** 评分  movieScore */
@property (assign, nonatomic) CGFloat movieScore;  // r
/** 图片  moviewIcon */
@property (copy, nonatomic) NSString *moviewIcon;  // img
/** 上映日期  showingDay */
@property (copy, nonatomic) NSString *showingDay;  // rd
/** specialComment */
@property (copy, nonatomic) NSString *specialComment; // commonSpecial
/** 多少家影院 cinemaCount  */
@property (assign, nonatomic) NSInteger cinemaCount;   // NearestCinemaCount
/** 上映多少场 showCount */
@property (assign, nonatomic) NSInteger showCount; // NearestShowtimeCount
/** 是否是3D */
@property (assign, nonatomic) BOOL is3D;
/** 是否是IMAX */
@property (assign, nonatomic) BOOL isIMAX3D;
/** 是否是中国巨幕 */
@property (assign, nonatomic) BOOL isDMAX;

/** 想看人数 */
@property (assign, nonatomic) NSInteger wantedCount;
/** 电影类型 */
@property (copy, nonatomic) NSString *movieType;
/** 是否售票 */
@property (assign, nonatomic) BOOL isTicket;
/** 电影id */
@property (assign, nonatomic) NSInteger moviewID;  // id
/** 电影长度 movieLenght */
@property (copy, nonatomic) NSString *movieLenght;  // d


// 辅助属性
/** showDate */
@property (strong, nonatomic) NSDate *showDate;
/** 上映日期(2016年5月20日中国上映) */
@property (copy, nonatomic) NSString *showDateArea;
@end
