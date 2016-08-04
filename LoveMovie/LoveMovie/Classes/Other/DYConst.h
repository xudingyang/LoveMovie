//
//  DYConst.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/11.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <UIKit/UIKit.h>

// 电影票房的地区
typedef enum{
    DYMainLand = 2020,
    DYAmerica = 2015,
    DYHongKong = 2016,
    DYTaiWan = 2019,
    DYJapan = 2017,
    DYKorea = 2018
} DYAreaNumber;

/**  常用间距 = 10 */
UIKIT_EXTERN CGFloat const DYMargin;
/**  电影控制器顶部按钮高度 */
UIKIT_EXTERN CGFloat const DYIndicatorHeight;