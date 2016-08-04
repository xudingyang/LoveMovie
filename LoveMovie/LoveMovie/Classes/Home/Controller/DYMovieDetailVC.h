//
//  DYMovieDetailVC.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/21.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYMovieDetailVC : UIViewController

/** iconUrl */
@property (copy, nonatomic) NSString *iconUrl;
@property (copy, nonatomic) NSString *movieName;
@property (copy, nonatomic) NSString *movieEnName;
@property (copy, nonatomic) NSString *movieLength;
@property (assign, nonatomic) CGFloat movieScore;
@property (copy, nonatomic) NSString *movieType;
@property (copy, nonatomic) NSString *showDateArea;
@property (assign, nonatomic) BOOL isTicket;
/** movieID */
@property (assign, nonatomic) NSInteger movieID;

@end
