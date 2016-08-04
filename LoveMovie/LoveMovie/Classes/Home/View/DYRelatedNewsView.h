//
//  DYRelatedNewsView.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/24.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DYRelatedNews;

@interface DYRelatedNewsView : UIView

/** DYRelatedNews */
@property (strong, nonatomic) DYRelatedNews *relatedNews;

+ (instancetype)relatedNewsView;

@end
