//
//  DYGoodItem.h
//  LoveMovie
//
//  Created by xudingyang on 16/6/2.
//  Copyright © 2016年 许定阳. All rights reserved.
//  中间商品导航栏的模型

#import <Foundation/Foundation.h>

@interface DYGoodItem : NSObject

/**
 *          {
 "iconTitle":"模玩",
 "url":"#!/commerce/list/?c1=25",
 "image":"http://img31.mtime.cn/mg/2016/03/29/180821.36534746.jpg"
 },
 */
/** title */
@property (copy, nonatomic) NSString *iconTitle;
/** image */
@property (copy, nonatomic) NSString *image;

@end
