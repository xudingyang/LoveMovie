//
//  DYImagesInNews.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/20.
//  Copyright © 2016年 许定阳. All rights reserved.
//  三图新闻里面的图片模型

#import <Foundation/Foundation.h>

@interface DYImagesInNews : NSObject

/**
 *                  {
 "gId":506208,
 "title":"",
 "desc":"冯小刚",
 "url1":"http://img31.mtime.cn/CMS/Gallery/2016/05/09/080822.18294586.jpg",
 "url2":"http://img31.mtime.cn/CMS/Gallery/2016/05/09/080822.18294586_900.jpg"
 },
 */

/** url */
@property (copy, nonatomic) NSString *url1;
/** desc */
@property (copy, nonatomic) NSString *desc;

@end
