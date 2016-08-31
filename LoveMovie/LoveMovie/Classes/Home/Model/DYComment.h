//
//  DYComment.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/25.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DYComment;

@interface DYComment : NSObject
/**
 *          {
 "id":7957374,
 "title":"(个人视点)漫威宇宙的成功换血计划——无剧透简评《美国队长3》",
 "content":" 这是一部非常典型的漫威电影，简短的背景过后就是一场紧张激烈、炫目火爆的交锋，一下子把人们的兴奋点提了上来，事实证明，这种醍醐灌顶的开篇还是非常奏效的…”,       //  content可能为空，注意cell的高度
 "nickname":"Action",
 "commentCount":77,
 "headurl":"http://img32.mtime.cn/up/2015/06/03/035011.42330991_128X128.jpg",
 "location":"",
 "modifyTime":1461804180,
 "rating":8,
 "isWantSee":false
 }
 */
/** commentID */
@property (assign, nonatomic) NSInteger commentID;  // id
/** commentCount 该影评下的评论条数 */
@property (assign, nonatomic) NSInteger commentCount;
/** title 标题 */
@property (copy, nonatomic) NSString *title;
/** content 内容 */
@property (copy, nonatomic) NSString *content;
/** nickname 昵称 */
@property (copy, nonatomic) NSString *nickname;
/** headurl 评论者头像 */
@property (copy, nonatomic) NSString *headurl;
/** modifyTime 发布日期 秒数 已经是东八区了*/
@property (assign, nonatomic) NSInteger modifyTime;
/** rating 评分 */
@property (assign, nonatomic) CGFloat rating;

/** 发布日期 字符串形式（年月日） */
@property (copy, nonatomic) NSString *publishDate;
/** 对应view的高度 */
@property (assign, nonatomic, readonly) CGFloat viewHeight;

/**
 *  《影评》下边的评论
 {
 "id":8350497,
 "nickname":"凯凯3994501",
 "userImage":"http://img32.mtime.cn/up/2012/12/26/044620.52199602_o.jpg",
 "date":"2016-5-9 17:26:43",
 "timestamp":1462814803,
 "content":"对于站队问题，幻视",
 "fromApp":"来自手机客户端",
 "replyCount":1,
 "replies":[
 {
 "id":8353205,
 "nickname":"LaPri",
 "userImage":"http://img2.mtime.cn/u/347/2798347/d6a39947-131d-4c00-a6e9-3fff9ff2be05/128X128.jpg",
 "date":"2016-5-15 18:51:19",
 "timestamp":1463338280,
 "content":"很容易想通：鹰眼明说了自己欠红女巫人情，在复联2里，快银为了救他，自己牺牲了，所以他自然会跟红女巫站同一队。",
 "fromApp":""
 }
 ]
 },
 */
/** 时间 秒数（他已经是东八区时间了） */
@property (assign, nonatomic) NSInteger timestamp;
/** replyCount 评论的评论数量 */
@property (assign, nonatomic) NSInteger replyCount;
/** userImage 评论者头像*/
@property (copy, nonatomic) NSString *userImage;
/** 发布日期 字符串形式:多少分钟以前 */
@property (copy, nonatomic) NSString *publishTime;
/** replies 评论的评论数组*/
@property (strong, nonatomic) NSArray<DYComment *> *replies;

@end
