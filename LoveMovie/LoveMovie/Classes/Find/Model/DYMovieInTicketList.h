//
//  DYMovieInTicketList.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/21.
//  Copyright © 2016年 许定阳. All rights reserved.
//  票房cell的模型里的电影模型

#import <Foundation/Foundation.h>

@interface DYMovieInTicketList : NSObject

/** 描述 */
@property (copy, nonatomic) NSString *remark;

/** cellOpenHeight 展开后的真实高度 */
@property (assign, nonatomic, readonly) CGFloat cellHeight;
/** cellCloseHeight 关闭时候的高度，因为有些cell关闭时候不足两行，所以也需要计算*/
@property (assign, nonatomic, readonly) CGFloat cellCloseHeight;

/**
 *  "movies":[
 {
 "id":207872,
 "rankNum":1,
 "posterUrl":"http://img31.mtime.cn/mt/2016/03/28/170428.48853494_1280X720X2.jpg",
 "decade":2016,
 "rating":7.6,
 "releaseDate":"2016年4月15日",
 "releaseLocation":"中国",
 "movieType":"冒险/剧情/家庭",
 "director":"乔恩·费儒",
 "actor":"尼尔·塞西",
 "remark":"毛克利是一家园，毛克利该何去何从？而毕生难忘的伟大冒险，才刚刚拉开序幕……",
 "weekBoxOffice":"周末票房 4244",
 "totalBoxOffice":"累计票房 25209",
 "isTicket":true,
 "isPresell":false
 }]
 */

/** chineseName */
@property (copy, nonatomic) NSString *chineseName;  // name
/** englishName */
@property (copy, nonatomic) NSString *englishName; // nameEn
/** rankNum */
@property (assign, nonatomic) NSInteger rankNum;
/** weekBoxOffice周票房 */
@property (copy, nonatomic) NSString *weekBoxOffice;
/** totalBoxOffice总票房 */
@property (copy, nonatomic) NSString *totalBoxOffice;
/** posterUrl */
@property (copy, nonatomic) NSString *posterUrl;
/** rating */
@property (assign, nonatomic) CGFloat rating;
/** movieID */
@property (assign, nonatomic) NSInteger movieID; // id
/** 发布日期 */
@property (copy, nonatomic) NSString *releaseDate;
/** 发布地区 */
@property (copy, nonatomic) NSString *releaseLocation;
/** movieType */
@property (copy, nonatomic) NSString *movieType;
/** 导演 */
@property (copy, nonatomic) NSString *director;
/** 主演 */
@property (copy, nonatomic) NSString *actor;
/** isTicket */
@property (assign, nonatomic) BOOL isTicket;

/** 周票房 */
@property (assign, nonatomic) NSInteger weekBoxOfficeNum;  // 周票房
/** 总票房 */
@property (assign, nonatomic) NSInteger totalBoxOfficeNum; //  累计票房
/** releaseDate */
@property (copy, nonatomic) NSString *showDateArea;


@end
