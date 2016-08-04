//
//  UIView+DYExt.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/10.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DYExt)

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

/**
 * 判断一个控件是否真正显示在主窗口
 */
- (BOOL)isShowingOnKeyWindow;

@end
