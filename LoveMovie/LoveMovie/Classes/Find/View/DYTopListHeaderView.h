//
//  DYTopListHeaderView.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/19.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DYTopList;

@interface DYTopListHeaderView : UIView

/** DYTopList模型 */
@property (strong, nonatomic) DYTopList *topList;

+ (instancetype)topListHeaderView;

@end
