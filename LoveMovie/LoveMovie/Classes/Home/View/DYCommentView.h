//
//  DYCommentView.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/25.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DYComment;

@interface DYCommentView : UIView

/** DYComment模型 */
@property (strong, nonatomic) DYComment *comment;

@property (weak, nonatomic) IBOutlet UILabel *commentsCount;

/** movieID */
@property (assign, nonatomic) NSInteger movieID;

+ (instancetype)commentView;

@end
