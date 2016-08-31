//
//  DYPhotoCollectionViewCell.h
//  LoveMovie
//
//  Created by xudingyang on 16/6/4.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DYPotoes;

@interface DYPhotoCollectionViewCell : UICollectionViewCell
/** DYPotoes */
@property (strong, nonatomic) DYPotoes *photo;
@property (weak, nonatomic) IBOutlet UIImageView *imge;
@end
