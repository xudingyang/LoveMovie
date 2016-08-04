//
//  DYMovieHeader.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/24.
//  Copyright © 2016年 许定阳. All rights reserved.
//  detailMovie的最上边：显示电影头像的地方。由于数据请求不到，只能这样曲线救国

#import <UIKit/UIKit.h>

@interface DYMovieHeader : UIView

/** movieIcon  url */
@property (copy, nonatomic) NSString *iconUrl;
@property (weak, nonatomic) IBOutlet UILabel *movieName;
@property (weak, nonatomic) IBOutlet UILabel *movieEnName;
@property (weak, nonatomic) IBOutlet UILabel *movieLength;
@property (weak, nonatomic) IBOutlet UILabel *movieScore;
@property (weak, nonatomic) IBOutlet UILabel *movieType;
@property (weak, nonatomic) IBOutlet UILabel *showDateArea;

/** isTicket */
@property (assign, nonatomic) BOOL isTicket;

+ (instancetype)movieHeader;

@end
