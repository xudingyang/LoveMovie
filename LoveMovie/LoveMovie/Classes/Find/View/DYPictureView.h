//
//  DYPictureView.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/20.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DYNews;

@interface DYPictureView : UIView

/** DYNews模型 */
@property (strong, nonatomic) DYNews *news;

+ (instancetype)pictureView;


@end
