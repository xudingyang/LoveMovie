//
//  DYVideoPhotoesView.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/24.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DYVideo;
@class DYPotoes;
@class DYPhotoType;

@interface DYVideoPhotoesView : UIView

/** DYVideo模型 */
@property (strong, nonatomic) DYVideo *video;
/** DYPotoes模型 */
@property (strong, nonatomic) DYPotoes *poto;
/** DYPhotoType模型 */
@property (strong, nonatomic) DYPhotoType *photoType;

/**********************************************
 *  辅助属性
 **********************************************/
/** photoes数组 */
@property (strong, nonatomic) NSArray<DYPotoes *> *photoes;
/** DYPhotoType数组 */
@property (strong, nonatomic) NSArray<DYPhotoType *> *photoTypes;
/** movieID */
@property (assign, nonatomic) NSInteger movieID;
@property (copy, nonatomic) NSString *movieName;
@property (copy, nonatomic) NSString *movieEnName;

@property (weak, nonatomic) IBOutlet UILabel *videoCount;
@property (weak, nonatomic) IBOutlet UILabel *potoCount;


+ (instancetype)videoPhotoesView;

@end
