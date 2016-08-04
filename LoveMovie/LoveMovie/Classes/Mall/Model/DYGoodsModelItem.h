//
//  DYGoodsModelItem.h
//  LoveMovie
//
//  Created by xudingyang on 16/6/3.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DYGoodsModelItem : NSObject
/**
 *              "subList":[
 {
 "title":"毁灭之锤",
 "goodsId":102833,
 "image":"http://img31.mtime.cn/mg/2016/05/27/170840.64093215.jpg",
 "url":""
 },
 */
/** 图片url */
@property (copy, nonatomic) NSString *image;
/** 商品name */
@property (copy, nonatomic) NSString *title;

@end
