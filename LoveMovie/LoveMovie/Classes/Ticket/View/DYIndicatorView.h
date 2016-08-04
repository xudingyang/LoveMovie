//
//  DYIndicatorView.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/15.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DyIndicatorViewDelegate <NSObject>

@optional
/** 点击了标题为title的按钮 */
- (void)indicatorViewDidSelectedButtonTitle:(NSString *)title;

@end

@interface DYIndicatorView : UIView

/** title数组 */
@property (strong, nonatomic) NSArray *titles;

/** delegate */
@property (weak, nonatomic) id<DyIndicatorViewDelegate> delegate;



+ (instancetype)indicatorView;

@end
