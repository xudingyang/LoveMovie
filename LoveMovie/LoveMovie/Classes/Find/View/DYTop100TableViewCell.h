//
//  DYTop100TableViewCell.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/21.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DYMovieInTicketList;
@class DYTop100TableViewCell;

@protocol DYTop100TableViewCellDelegate <NSObject>

@optional
- (void)labelDidTapTop100Cell:(DYTop100TableViewCell *)cell;

@end


@interface DYTop100TableViewCell : UITableViewCell
/** DYMovieInTicketList模型 */
@property (strong, nonatomic) DYMovieInTicketList *movie;
/** 是否展开还是合拢 */
@property (assign, nonatomic) BOOL isBig;
/** delegate */
@property (weak, nonatomic) id<DYTop100TableViewCellDelegate> delegate;

@end
