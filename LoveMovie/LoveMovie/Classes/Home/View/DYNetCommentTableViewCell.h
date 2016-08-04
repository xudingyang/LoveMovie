//
//  DYNetCommentTableViewCell.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/27.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DYNetFriendComment;

@interface DYNetCommentTableViewCell : UITableViewCell

/** DYComment模型 */
@property (strong, nonatomic) DYNetFriendComment *comment;

@end
