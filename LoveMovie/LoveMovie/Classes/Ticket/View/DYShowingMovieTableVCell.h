//
//  DYShowingMovieTableVCell.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/16.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DYHotMovie;

@interface DYShowingMovieTableVCell : UITableViewCell
/** DYHotMovie模型 */
@property (strong, nonatomic) DYHotMovie *hotMovie;
@end
