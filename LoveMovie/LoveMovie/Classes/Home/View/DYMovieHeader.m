//
//  DYMovieHeader.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/24.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYMovieHeader.h"
#import <UIImageView+WebCache.h>
#import "DYNoHighlitedButton.h"

@interface DYMovieHeader ()

@property (weak, nonatomic) IBOutlet UIImageView *bgIcon;
@property (weak, nonatomic) IBOutlet UIImageView *movieIcon;
@property (weak, nonatomic) IBOutlet DYNoHighlitedButton *buyTicketBtn;

@end

@implementation DYMovieHeader

+ (instancetype)movieHeader{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)setIconUrl:(NSString *)iconUrl{
    _iconUrl = iconUrl;
    [self.movieIcon sd_setImageWithURL:[NSURL URLWithString:iconUrl] placeholderImage:[UIImage imageNamed:@"movie_default_image_170×254"]];
    [self.bgIcon sd_setImageWithURL:[NSURL URLWithString:iconUrl] placeholderImage:[UIImage imageNamed:@"declare_background"]];
}

- (void)setIsTicket:(BOOL)isTicket{
    _isTicket = isTicket;
    if (isTicket) {
        self.buyTicketBtn.hidden = NO;
        
    } else {
        self.buyTicketBtn.hidden = YES;
    }
}

- (IBAction)wantSeeClick {
}

- (IBAction)wantRateClick {
}

@end
