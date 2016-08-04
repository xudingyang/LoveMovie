//
//  DYMeHotGoodsVCell.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/13.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DYMeHotGoods;

@interface DYMeHotGoodsVCell : UIView

/** DYMeHotGoods模型 */
@property (strong, nonatomic) DYMeHotGoods *hotGoods;


+ (instancetype)meHotGoodsCell;

@end
