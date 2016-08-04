//
//  DYHomeHeaderView.h
//  LoveMovie
//
//  Created by xudingyang on 16/6/3.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DYHomeScrollImage;
@class DYHomeMovie;

@interface DYHomeHeaderView : UIView

/** DYHomeScrollImage数组 */
@property (strong, nonatomic) NSArray<DYHomeScrollImage *> *scrollImageArray;
/** DYHomeMovie数组 */
@property (strong, nonatomic) NSArray<DYHomeMovie *> *movieArray;
/** 正在上映的数目 */
@property (assign, nonatomic) NSInteger showingNum;
/** 即将上映的数目 */
@property (assign, nonatomic) NSInteger comingNum;
/** 影院数目 */
@property (assign, nonatomic) NSInteger cinemaNum;
// 轮播器
@property (weak, nonatomic) IBOutlet UIView *scrollImage;

+ (instancetype)homeHeaderView;

@end
