//
//  DYNetFriendComment.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/26.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DYNetFriendComment : NSObject
/**
 *             {
 "tweetId":35824033,
 "ce":"电影没有什么问题，就是影院四号厅太吵了，中央空调转的声音比电影声音还大",
 "isHot":false,
 "ceimg":"",
 "ca":"M_1605251946330665714",
 "cd":1464200569,
 "caimg":"http://img32.mtime.cn/up/2016/05/25/194635.86935144_48X48.jpg",
 "cal":"",
 "commentCount":0,
 "cr":"6"
 },
 */
/** tweetId 评论id */
@property (assign, nonatomic) NSInteger tweetId;
/** conten 内容 */
@property (copy, nonatomic) NSString *content;  // ce
/** name 昵称 */
@property (copy, nonatomic) NSString *name;  // ca
/** 时间 秒数 */
@property (assign, nonatomic) NSInteger publishTime;  // cd
/** commentCount 对该评论的评论数目 */
@property (assign, nonatomic) NSInteger commentCount;
/** 评分 */
@property (assign, nonatomic) CGFloat rating; // cr
/** caimg 头像 */
@property (copy, nonatomic) NSString *caimg;
/** ceimg 评论中的图片 */
@property (copy, nonatomic) NSString *ceimg;
/**************************************
 *  辅助属性
 **************************************/
/** 发布时间  字符串(xx小时前) */
@property (copy, nonatomic) NSString *publishDate;
/** viewHeight 对应view的高度 */
@property (assign, nonatomic) CGFloat viewHeight;

@end
