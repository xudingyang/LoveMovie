//
//  DYReview.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/19.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DYMovieInReview;

@interface DYReview : NSObject

/***********************************************
 *                  上边的大图                   *
 ***********************************************/
/**
"review":{
"reviewID":7957374,   影评的ID，回根据这个找到该影评的具体内容以及评论
"title":"【无剧透】复联成功换血",
"posterUrl":"http:img31.mtime.cn/mt/2016/04/14/113933.51191278_1280X720X2.jpg",
"movieName":"美国队长3",
"imageUrl":"http:img31.mtime.cn/mg/2016/04/28/112742.39536555.jpg"
},
**/

/** 影评的ID */
@property (assign, nonatomic) NSInteger reviewID;
/** 大图的副标题。cell的主标题 */
@property (copy, nonatomic) NSString *title;
/** 海报url */
@property (copy, nonatomic) NSString *posterUrl;
/** 大图的标题 */
@property (copy, nonatomic) NSString *movieName;
/** 大图的url */
@property (copy, nonatomic) NSString *imageUrl;
/***********************************************
 *                  下边的cell                  *
 ***********************************************/
/*
{
    "id":7958400,    //影评的ID，回根据这个找到该影评的具体内容以及评论
    "nickname":"念及己名",
    "userImage":"http://img32.mtime.cn/up/2013/02/02/153807.75711201_128X128.jpg”,      //评论者头像
    "rating":"7.5",
    "title":"友谊的小船咋就翻了呢？",
    "summary":"　　美队3就是一场超级英雄大杂烩，典型的爆米花电影，与第二部风格不同，再次回归到私人恩怨的剧情上。但是这不是重点，首先看得爽，其次一堆超级英雄先导预告片你还想期待什么。 　　 　　在钢铁侠3华丽地欺骗我后，我就意识到电影宇宙和漫画宇宙是完全不同的世界观，其实这点没有太多纠结。无论DC或者漫威，那些经典角色早就历经大事件改动了N多设定和情节，我们只是选择了自己所理解的角色罢了。 　　 　　因此美队3...",
    "relatedObj":{
        "type":1,
        "id":209122,
        "title":"美国队长3",
        "rating":"8.0",
        "image":"http://img31.mtime.cn/mt/2016/04/14/113933.51191278_1280X720X2.jpg”     //电影图片
    }
},
 */
/** 评论人的昵称 */
@property (copy, nonatomic) NSString *nickname;
/** 评论人头像url */
@property (copy, nonatomic) NSString *userImage;
/** 评论人的评分：直接用字符串表示 */
@property (copy, nonatomic) NSString *rating;
/** 评论 */
@property (copy, nonatomic) NSString *summary;
/** DYMovieInReview模型 */
@property (strong, nonatomic) DYMovieInReview *movie;
/** 下次cell的id */
@property (assign, nonatomic) NSInteger cellID;
@end
