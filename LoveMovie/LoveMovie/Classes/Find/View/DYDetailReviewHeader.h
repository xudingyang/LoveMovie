//
//  DYDetailReviewHeader.h
//  LoveMovie
//
//  Created by xudingyang on 16/8/15.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DYDetailReview;

@interface DYDetailReviewHeader : UIView
/** DYDetailReview */
@property (strong, nonatomic) DYDetailReview *detailReview;
/** movieName */
@property (copy, nonatomic) NSString *movieName;


+ (instancetype)detailReviewHeader;

@end
