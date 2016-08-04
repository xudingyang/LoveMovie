//
//  DYReviewTableVCell.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/20.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DYReview;

@interface DYReviewTableVCell : UITableViewCell
/** DYReview模型 */
@property (strong, nonatomic) DYReview *review;
@end
