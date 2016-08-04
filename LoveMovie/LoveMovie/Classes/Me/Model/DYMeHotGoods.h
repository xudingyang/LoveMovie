//
//  DYMeHotGoods.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/13.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DYMeHotGoods : NSObject

//http://api.m.mtime.cn/ECommerce/HotBuyProducts.api   post方式，无参数

//{
//    "background":"#28C8DC",
//    "goodsId":102149,
//    "iconText":"新品",
//    "image":"http://img31.mtime.cn/mg/2016/03/03/154128.29013294.jpg",
//    "longName":"细致工艺 柔软亲肤 透气抗压 缓解疲劳",
//    "marketPrice":12900,
//    "minSalePrice":8800,
//    "name":"蝙蝠侠黑暗骑士抱枕",
//    "url":"http://mall.wv.mtime.cn/#!/commerce/item/102149/"
//},

/** 货物ID goodsId */
@property (assign, nonatomic) NSInteger goodsId;

/** 货物标签 iconText */
@property (copy, nonatomic) NSString *iconText;

/** image的url */
@property (copy, nonatomic) NSString *image;

/** name */
@property (copy, nonatomic) NSString *name;

/** marketPrice */
@property (assign, nonatomic) NSInteger marketPrice;

/** 对应webview的url */
@property (copy, nonatomic) NSString *url;

@end
