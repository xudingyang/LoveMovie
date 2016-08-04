//
//  DYTrailer.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/19.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DYTrailer : NSObject

/***********************************************
 *                上边的大图                     *
 ***********************************************/
/**
 "trailer":{
 "trailerID":60250,
 "title":"《X战警：天启》角色预告片",
 "imageUrl":"http://img31.mtime.cn/mg/2016/05/07/175306.94788904.jpg",
 "mp4Url":"http://vfx.mtime.cn/Video/2016/05/07/mp4/160507115516211353.mp4",
 "hightUrl":"http://vfx.mtime.cn/Video/2016/05/07/mp4/160507115516211353.mp4",
 "movieId":208116
 },
 */
/** trailerID */
@property (assign, nonatomic) NSInteger trailerID;
/** title */
@property (copy, nonatomic) NSString *title;
/** imageUrl 图片*/
@property (copy, nonatomic) NSString *imageUrl;
/** mp4Url 视频url */
@property (copy, nonatomic) NSString *mp4Url;
/** hightUrl */
@property (copy, nonatomic) NSString *hightUrl;

/***********************************************
 *               上下都有的属性                  *
 ***********************************************/
/** movieId */
@property (assign, nonatomic) NSInteger movieId;



/***********************************************
 *             下边的tableViewCell              *
 ***********************************************/
/**
   {
 "id":60234,
 "movieName":"《魔兽》人物版预告片",
 "coverImg":"http://img31.mtime.cn/mg/2016/05/06/102007.46964016.jpg",
 "movieId":89952,
 "url":"http://vfx.mtime.cn/Video/2016/05/06/mp4/160506094549176298_480.mp4",
 "hightUrl":"http://vfx.mtime.cn/Video/2016/05/06/mp4/160506094549176298.mp4",
 "videoTitle":"魔兽 中文版迦罗娜预告片",
 "videoLength":21,
 "rating":-1,
 "type":[
 "动作",
 "冒险",
 "奇幻"
 ],
 "summary":"半兽人迦罗娜英勇对战绿兽人"
 },
 */
/** movieName 预告片名字 */
@property (copy, nonatomic) NSString *movieName;
/** coverImg的url */
@property (copy, nonatomic) NSString *coverImg;
/** url视频url mp4格式*/
@property (copy, nonatomic) NSString *url;
///** videoTitle 不知道什么鬼 */
//@property (copy, nonatomic) NSString *videoTitle;
/** summary 评论 */
@property (copy, nonatomic) NSString *summary;
@end

