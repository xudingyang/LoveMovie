//
//  DYTouTiao.h
//  LoveMovie
//
//  Created by xudingyang on 16/6/4.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DYZiXun;

@interface DYTouTiao : UIView
/** DYZiXun */
@property (strong, nonatomic) DYZiXun *zixun;

+ (instancetype)touTiaoView;
@end
