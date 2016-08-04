//
//  DYTicketListTableViewCell.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/21.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DYMovieInTicketList;

@interface DYTicketListTableViewCell : UITableViewCell
/** DYMovieInTicketList模型 */
@property (strong, nonatomic) DYMovieInTicketList *movie;
@end
