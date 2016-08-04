//
//  DYZiXun.h
//  LoveMovie
//
//  Created by xudingyang on 16/6/4.
//  Copyright © 2016年 许定阳. All rights reserved.
//  首页资讯类

#import <Foundation/Foundation.h>
@class DYMovieInZiXun;
@class DYMovieInBangDan;

@interface DYZiXun : NSObject


/**
 {
 "title":"直击《速度与激情8》冰岛拍摄现场",
 "titlesmall":"《速激8》曝冰岛片场视频",
 "publishTime":1465043369,
 "tag":"简讯",
 "id":1556033,
 "status":1,
 "dataType":2,
 "relations":Array[3],
 "isShow":"是",
 "img1":"http://img31.mtime.cn/mg/2016/06/04/123646.66097383.jpg",
 "img2":"http://img31.mtime.cn/mg/2016/06/04/123646.66097383.jpg",
 "img3":"",
 "type":51,
 "commentCount":0,
 "time":"2016-6-4 12:44:19",
 "content":"茫茫雪野机车飞驰 制造当地最大爆破场面"
 },
 */



/*********************************
*  简讯、头条、图集
**********************************/
/** id */
@property (assign, nonatomic) NSInteger ID;  // id
/** 标题title */
@property (copy, nonatomic) NSString *title;
/** 预览content */
@property (copy, nonatomic) NSString *content;
/** 标签tag */
@property (copy, nonatomic) NSString *tag;
/** 图片1  img1 */
@property (copy, nonatomic) NSString *img1;
/** 图片2 img2 */
@property (copy, nonatomic) NSString *img2;
/** 图片3 */
@property (copy, nonatomic) NSString *img3;
/** 评论数 commentCount */
@property (assign, nonatomic) NSInteger commentCount;
/** 发布时间 秒数 东八区 */
@property (assign, nonatomic) NSInteger publishTime;


/*********************************
 *  影评无、欧美日韩新片无、猜电影无、爆笑片单无、榜单无、电影榜单
 **********************************/
/** summaryInfo 评论预览 */
@property (copy, nonatomic) NSString *summaryInfo;
/** nickname */
@property (copy, nonatomic) NSString *nickname;
/** 用户头像 userImage */
@property (copy, nonatomic) NSString *userImage;
/** rating */
@property (assign, nonatomic) CGFloat rating;
/** DYMovieInZiXun */
@property (strong, nonatomic) DYMovieInZiXun *movieInZiXun;
/** 欧美新片 获奖佳片 image */
@property (copy, nonatomic) NSString *image;
/** 欧美新片 获奖佳片 副标题 titleEn */
@property (copy, nonatomic) NSString *titleEn;
/** 猜电影预览memo */
@property (copy, nonatomic) NSString *memo;
/** 猜电影图片 pic1Url */
@property (copy, nonatomic) NSString *pic1Url;
/** 爆笑片单、榜单 预览 电影榜单 Memo */
@property (copy, nonatomic) NSString *Memo;
/** 榜单的movie数组 */
@property (strong, nonatomic) NSArray *movies;


/**
 *  获奖佳片、经典重温、经典回顾
 */
/** 标题titleCn 预览是titleEn */
@property (copy, nonatomic) NSString *titleCn;


/** publishDate */
@property (copy, nonatomic) NSString *publishDate;
/** cellHeight */
@property (assign, nonatomic) CGFloat cellHeight;

@end
