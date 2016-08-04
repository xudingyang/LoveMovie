//
//  DYVideoPlayViewController.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/31.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYVideoPlayViewController : UIViewController

/** 普通视频url */
@property (copy, nonatomic) NSString *url;
/** 高清hightUrl */
@property (copy, nonatomic) NSString *hightUrl;
/** title */
@property (copy, nonatomic) NSString *vedioName;

@end
