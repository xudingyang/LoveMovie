//
//  DYShowPictureViewController.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/27.
//  Copyright © 2016年 许定阳. All rights reserved.
//  点击剧照collection里面的小图后，展示大图

#import <UIKit/UIKit.h>
@class DYPotoes;

@interface DYShowPictureViewController : UIViewController

/** DYPotoes数组。该数组不是整体数组，是对应type的照片数组 */
@property (strong, nonatomic) NSArray<DYPotoes *> *photoes;

@end
