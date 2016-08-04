//
//  DYGoodsModel.m
//  LoveMovie
//
//  Created by xudingyang on 16/6/3.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYGoodsModel.h"
#import "DYGoodsModelItem.h"

@implementation DYGoodsModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"subList" : [DYGoodsModelItem class]};
}

@end
