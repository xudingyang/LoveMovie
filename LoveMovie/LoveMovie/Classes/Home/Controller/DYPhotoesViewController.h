//
//  DYPhotoesViewController.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/26.
//  Copyright © 2016年 许定阳. All rights reserved.
//  展示剧照的viewController

#import <UIKit/UIKit.h>
@class DYPhotoType;
@class DYPotoes;

@interface DYPhotoesViewController : UIViewController

/** photoes数组 */
@property (strong, nonatomic) NSArray<DYPotoes *> *photoes;
/** DYPhotoType数组 */
@property (strong, nonatomic) NSArray<DYPhotoType *> *photoTypes;
@property (copy, nonatomic) NSString *movieName;
@property (copy, nonatomic) NSString *movieEnName;
@end
