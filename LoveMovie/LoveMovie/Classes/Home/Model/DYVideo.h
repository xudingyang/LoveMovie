//
//  DYVideo.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/24.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DYVideo : NSObject
/**
 *      "videoList":[
 {
 "id":57688,
 "url":"http://vfx.mtime.cn/Video/2016/04/12/mp4/160412151551083488_480.mp4",
 "hightUrl":"http://vfx.mtime.cn/Video/2016/04/12/mp4/160412151551083488.mp4",
 "image":"http://img31.mtime.cn/mg/2015/11/25/133553.93351574_235X132X4.jpg",
 "title":"美国队长3：英雄内战 中文版预告片1",
 "type":0,
 "length":139
 }]
 */

/** 图片 */
@property (copy, nonatomic) NSString *image;
/** 普通视频url */
@property (copy, nonatomic) NSString *url;
/** 高清hightUrl */
@property (copy, nonatomic) NSString *hightUrl;
/** title */
@property (copy, nonatomic) NSString *title;
/** length 以秒为单位，需要转换*/
@property (assign, nonatomic) NSInteger length;

/******************************
 *  辅助属性
 ******************************/
/** lengthStr 字符串形式的视频长度 */
@property (copy, nonatomic) NSString *lengthStr;
@end
