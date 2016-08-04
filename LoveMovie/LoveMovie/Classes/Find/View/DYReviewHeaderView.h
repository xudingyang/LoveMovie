//
//  DYReviewHeaderView.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/19.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DYReview;
@interface DYReviewHeaderView : UIView
/** DYReview */
@property (strong, nonatomic) DYReview *review;

+ (instancetype)reviewHeaderView;
@end
