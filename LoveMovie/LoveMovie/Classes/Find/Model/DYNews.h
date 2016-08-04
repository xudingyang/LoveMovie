//
//  DYNews.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/20.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DYImagesInNews;

@interface DYNews : NSObject
/**********************************
 *  大图
 **********************************/
/** 大图url */
@property (copy, nonatomic) NSString *imageUrl;


/**********************************
 *  公共
 **********************************/
/** newsID */
@property (assign, nonatomic) NSInteger newsID;
/** 新闻类型
    type 0 普通
    type 1 三图（也可能两图）
    type 2 视频（加播放按钮）
 
 */
@property (assign, nonatomic) NSInteger type;
/** 大图标题。cell标题 */
@property (copy, nonatomic) NSString *title;
/** tag标记
    tag为“无”的时候，隐藏tag。
    tag为“策划”的时候，要显示策划，否则隐藏策划。还有“观剧”，注意这个坑。还有“独家”，草！还有“观影”，艹！
 */
@property (copy, nonatomic) NSString *tag;
/** 发布时间的秒数 */
@property (assign, nonatomic) NSInteger publishTime;
/** 评论条数 */
@property (assign, nonatomic) NSInteger commentCount;

/**********************************
 *  一图新闻(普通新闻)
 **********************************/
/** 新闻图片的url */
@property (copy, nonatomic) NSString *image;
/** cell副标题（描述） */
@property (copy, nonatomic) NSString *title2;

/**********************************
 *  三图新闻
 **********************************/
/** 图片数组 */
@property (strong, nonatomic) NSArray *images;

/**********************************
 *  视频新闻：只是加个播放标记，没有数据的不同
 **********************************/

/**********************************
 *  辅助属性
 **********************************/
/** cell的高度 */
@property (assign, nonatomic, readonly) CGFloat cellHeight;
/** 发布时间 */
@property (copy, nonatomic) NSString *publishDate;
@end
