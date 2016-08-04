//
//  DYTop100TableVC.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/21.
//  Copyright © 2016年 许定阳. All rights reserved.
//  top100系列的控制器公共部分

#import <UIKit/UIKit.h>

//#define DYTimeTop100 @"timeTop100"
//#define DYChineseTop100 @"chineseTop100"
//#define DYBigTop100 @"bigTop100"
//#define DYCellTop100 @"cellTop100"

typedef enum {
    DYTimeTop100 = 2065,
    DYChineseTop100 = 2066,
    DYBigTop100 = 8888,  // 后两个只是作为类型，不作为url的参数了
    DYCellTop100 = 9999
} DYTop100VcType;

@interface DYTop100TableVC : UITableViewController

/** DYTop100VcType */
@property (assign, nonatomic) DYTop100VcType top100VcType;

/** topListId外界参数，url中用得着 */
@property (assign, nonatomic) NSInteger topListId;


@end
