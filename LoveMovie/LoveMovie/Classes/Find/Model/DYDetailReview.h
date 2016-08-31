//
//  DYDetailReview.h
//  LoveMovie
//
//  Created by xudingyang on 16/8/10.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DYDetailReview : NSObject

/**
 *  {
 
 "id":7958576,
 "nickname":"游然自得",
 "userImage":"http://img2.mtime.cn/u/946/1680946/986f836a-411f-4889-8b30-aeacba992b26/128X128.jpg",
 "commentCount":3,
 "time":"2016-5-7 18:20",
 "title":"《美队3》：我选择站队黑寡妇",
 "url":"http://i.mtime.com/1680946/blog/7958576/",
 "content":"<div><img
 "relatedObj”:{
 }
 "topImgUrl":"http://img31.mtime.cn/pi/2016/03/11/130217.36298581.jpg"
 */

/** 昵称 */
@property (copy, nonatomic) NSString *nickname;
/** userImage 用户头像*/
@property (copy, nonatomic) NSString *userImage;
/** topImgUrl 电影url */
@property (copy, nonatomic) NSString *topImgUrl;
/** commentCount 评论条数*/
@property (assign, nonatomic) NSInteger commentCount;
/** title 影评标题*/
@property (copy, nonatomic) NSString *title;
/** content 内容 */
@property (copy, nonatomic) NSString *content;
/** time 时间 */
@property (copy, nonatomic) NSString *time;
/** rating */
@property (assign, nonatomic) CGFloat rating;
@end
