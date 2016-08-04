//
//  DYNewsTableViewCell.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/20.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYNewsTableViewCell.h"
#import "DYNews.h"
#import "DYPictureView.h"
#import "DYThreePictureView.h"
#import "DYVideoView.h"

@interface DYNewsTableViewCell ()
/** 普通pictureView */
@property (weak, nonatomic) DYPictureView *pictureView;
/** 三图threePictureView */
@property (weak, nonatomic) DYThreePictureView *threePictureView;
/** 视频videoView */
@property (weak, nonatomic) DYVideoView *videoView;
@end

@implementation DYNewsTableViewCell

+ (instancetype)newsCellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"DYNewsTableViewCell";
    DYNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[DYNewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        DYPictureView *pictureView = [DYPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
        
        DYThreePictureView *threePictureView = [DYThreePictureView threePictureView];
        [self.contentView addSubview:threePictureView];
        _threePictureView = threePictureView;
        
        DYVideoView *videoView = [DYVideoView videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return self;
}

- (void)setNews:(DYNews *)news{
    _news = news;
    CGFloat width = DYScreenWidth;
    if (news.type == 0) {  // 普通
        self.pictureView.hidden = NO;
        self.threePictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.pictureView.frame = CGRectMake(0, 0, width, 110);
        self.pictureView.news = news;
    } else if (news.type == 1) { // 三图
        self.pictureView.hidden = YES;
        self.threePictureView.hidden = NO;
        self.videoView.hidden = YES;
        self.threePictureView.frame = CGRectMake(0, 0, width, 165);
        self.threePictureView.news = news;
    } else if (news.type == 2) { // 视频
        self.pictureView.hidden = YES;
        self.threePictureView.hidden = YES;
        self.videoView.hidden = NO;
        self.videoView.frame = CGRectMake(0, 0, width, 110);
        self.videoView.news = news;
    }
//    
//    else {
//        if (news.type == 0) {  // 普通
//            self.pictureView.hidden = NO;
//            self.threePictureView.hidden = YES;
//            self.videoView.hidden = YES;
//            self.pictureView.frame = CGRectMake(DYMargin, DYMargin, width, 90 + 20);
//        } else if (news.type == 1) { // 三图
//            self.pictureView.hidden = YES;
//            self.threePictureView.hidden = NO;
//            self.videoView.hidden = YES;
//            self.threePictureView.frame = CGRectMake(DYMargin, DYMargin, width, 140 + 20);
//        } else if (news.type == 2) { // 视频
//            self.pictureView.hidden = YES;
//            self.threePictureView.hidden = YES;
//            self.videoView.hidden = NO;
//            self.videoView.frame = CGRectMake(DYMargin, DYMargin, width, 90 + 20);
//        }
//    }

}


@end
