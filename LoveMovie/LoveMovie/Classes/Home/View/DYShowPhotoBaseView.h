//
//  DYShowPhotoBaseView.h
//  LoveMovie
//
//  Created by xudingyang on 16/8/22.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYShowPhotoBaseView : UIView
/** 图片url数组 */
@property (strong, nonatomic) NSArray *iconArray;
/** index 模型在数组中的下标；或者说cell的row */
@property (assign, nonatomic) NSInteger index;
/** collection 在获得下一个cell的时候，需要用到collection */
@property (strong, nonatomic) UICollectionView *collectionView;
/** rectArray */
@property (strong, nonatomic) NSArray<NSString *> *rectArray;

@end
