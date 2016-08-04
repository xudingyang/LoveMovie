//
//  DYScrollViewImage.h
//  LoveMovie
//
//  Created by xudingyang on 16/6/2.
//  Copyright © 2016年 许定阳. All rights reserved.
//  轮播图的模型

#import <Foundation/Foundation.h>

@interface DYScrollViewImage : NSObject

/**
 *      "scrollImg":[
 {
 "url":"http://warcraft.mtime.cn/mobile/clothes/index.html?app_mall_banner_warcraftclothes",
 "image":"http://img31.mtime.cn/mg/2016/05/30/120702.22653693.jpg"
 }]
 */
/** 图片的Url */
@property (copy, nonatomic) NSString *image;
/** 对应网址的url */
@property (copy, nonatomic) NSString *url;

@end
