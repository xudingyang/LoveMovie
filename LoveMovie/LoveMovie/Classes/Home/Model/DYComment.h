//
//  DYComment.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/25.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <Foundation/Foundation.h>

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
/** modifyTime 发布日期 秒数*/
@property (assign, nonatomic) NSInteger modifyTime;
/** rating 评分 */
@property (assign, nonatomic) CGFloat rating;


/** 发布日期 字符串形式 */
@property (copy, nonatomic) NSString *publishDate;
/** 对应view的高度 */
@property (assign, nonatomic, readonly) CGFloat viewHeight;
@end
