//
//  DYGoodsModel.h
//  LoveMovie
//
//  Created by xudingyang on 16/6/3.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DYGoodsModelItem;

@interface DYGoodsModel : NSObject
/**
 *      "category":[
 {
 "goodsId":0,
 "moreUrl":"http://mall.wv.mtime.cn/#!/commerce/list/?c1=25",
 "imageUrl":"http://mall.wv.mtime.cn/#!/commerce/list/?q=cosbaby",
 "image":"http://img31.mtime.cn/mg/2016/05/27/170756.11304987.jpg",
 "name":"玩具模型",
 "colorValue":"#FFB90F",
 "subList":Array[3]
 },
 */
/** 大图url */
@property (copy, nonatomic) NSString *image;
/** 模型名字 */
@property (copy, nonatomic) NSString *name;
/** 商城url */
@property (copy, nonatomic) NSString *moreUrl;


/** DYGoodsModelItem数组 */
@property (strong, nonatomic) NSArray *subList;

@end
