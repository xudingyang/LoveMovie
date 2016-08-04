//
//  DYHomeCollectionViewCell.h
//  LoveMovie
//
//  Created by xudingyang on 16/6/3.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DYHomeMovie;

@interface DYHomeCollectionViewCell : UICollectionViewCell

/** DYHomeMovie模型 */
@property (strong, nonatomic) DYHomeMovie *moview;

@end
