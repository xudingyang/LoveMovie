//
//  DYCreditsView.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/24.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DYPosition;

@interface DYCreditsView : UIView

/** DYPosition数组 */
@property (strong, nonatomic) NSArray<DYPosition *> *positions;

+ (instancetype)creditsView;

@end
