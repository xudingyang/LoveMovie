//
//  DYTopList.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/19.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DYTopList : NSObject

/***********************************************
 *                  上边的大图                   *
 ***********************************************/
/**
  "topList”:{     //排行榜大图
 "id":1357,    //topListID，点开大图后，会把该ID作为请求参数传到下一界面
 "title":"那些用书信传情的电影",
 "imageUrl":"http://img31.mtime.cn/mg/2016/05/02/171346.87271987.jpg",
 "type":0
 }
 */


/***********************************************
 *                  下边的cell                  *
 ***********************************************/
/**
"topLists":[
 {
 "id":1349,   //topListsID 会传到点击后的下一个界面
 "topListNameCn":"英国电影学会影史LGBT电影30佳",
 "topListNameEn":"",
 "type":0,
 "summary":"《卡罗尔》荣登榜首"
 }]
 */

/** topListID */
@property (assign, nonatomic) NSInteger topListID;  // id
/** 大图的title */
@property (copy, nonatomic) NSString *title;
/** 大图的url */
@property (copy, nonatomic) NSString *imageUrl;
/** cell的标题 */
@property (copy, nonatomic) NSString *topListNameCn;

@end
