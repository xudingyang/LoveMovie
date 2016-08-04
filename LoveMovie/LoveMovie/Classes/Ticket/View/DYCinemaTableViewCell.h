//
//  DYCinemaTableViewCell.h
//  LoveMovie
//
//  Created by xudingyang on 16/6/2.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DYCinema;

@interface DYCinemaTableViewCell : UITableViewCell

/** DYCinema模型 */
@property (strong, nonatomic) DYCinema *cinema;

@end
