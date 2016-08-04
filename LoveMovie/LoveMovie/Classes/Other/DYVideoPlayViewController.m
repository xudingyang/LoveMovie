//
//  DYVideoPlayViewController.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/31.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYVideoPlayViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "NSString+DYExt.h"

@interface DYVideoPlayViewController ()

@property (weak, nonatomic) IBOutlet UILabel *vedioTitle;
@property (weak, nonatomic) IBOutlet UILabel *currentTime;
@property (weak, nonatomic) IBOutlet UILabel *totalTime;
@property (weak, nonatomic) IBOutlet UISlider *slide;
@property (weak, nonatomic) IBOutlet UIView *topToolBar;
@property (weak, nonatomic) IBOutlet UIView *bottomToolBar;
@property (weak, nonatomic) IBOutlet UIButton *playButton;



/** UIImageView *bgView */
@property (weak, nonatomic) UIImageView *bgView;
/** player 播放器 */
@property (strong, nonatomic) AVPlayer *player;
/** playerLayer 播放器的layer */
@property (weak, nonatomic) AVPlayerLayer *playerLayer;
/** 工具条隐藏标记 */
@property (assign, nonatomic) BOOL isShow;

/** 定时器 */
@property (strong, nonatomic) CADisplayLink *timer;

@end

@implementation DYVideoPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.slide.value = 0;
}

- (void)addTimer{
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateTime)];
    
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)removeTimer{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)updateTime{
    // 1.更新时间
    self.currentTime.text = [self currentTimeString];
    self.totalTime.text = [self totalTimeString];
    // 2.设置进度条的value
    self.slide.value = CMTimeGetSeconds(self.player.currentTime) / CMTimeGetSeconds(self.player.currentItem.duration);
    if (self.slide.value >= 0.999) {
        [self backClick:nil];
    }
}

- (NSString *)currentTimeString{
    NSTimeInterval curent = CMTimeGetSeconds(self.player.currentTime);
    NSInteger second = (NSInteger)curent % 60;
    NSInteger minute = curent / 60;
    NSInteger hour = minute / 60;
    
    return [NSString stringWithFormat:@"%02zd:%02zd:%02zd", hour, minute, second];
}

- (NSString *)totalTimeString{
    NSTimeInterval duration = CMTimeGetSeconds(self.player.currentItem.duration);
    NSInteger second = (NSInteger)duration % 60;
    NSInteger minute = duration / 60;
    NSInteger hour = minute / 60;
    
    return [NSString stringWithFormat:@" / %02zd:%02zd:%02zd", hour, minute, second];
}

//- (void)setVedioName:(NSString *)vedioName {
//    NSLog(@"%@", vedioName);
//    _vedioName = vedioName;
//    self.vedioTitle.text = [NSString trimedSpaceReturnWithString:vedioName];
//    NSLog(@"vc里面%@", self.vedioTitle.text);
//}

- (void)setHightUrl:(NSString *)hightUrl{
    _hightUrl = hightUrl;
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:hightUrl]];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:item];
    self.player = player;
    
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:player];
    self.playerLayer = layer;

    UIImageView *bgView = [[UIImageView alloc] init];
    [self.view insertSubview:bgView atIndex:0];
    self.bgView = bgView;
    
    [bgView.layer addSublayer:layer];
    
    [player play];
    self.playButton.selected = YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1 animations:^{
            self.topToolBar.alpha = 0;
            self.bottomToolBar.alpha = 0;
            self.slide.alpha = 0;
            self.isShow = NO;
        }];
    });
    
    [self addTimer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.isShow == YES) {
        [UIView animateWithDuration:1 animations:^{
            self.topToolBar.alpha = 0;
            self.bottomToolBar.alpha = 0;
            self.slide.alpha = 0;
            self.isShow = NO;
        }];
    } else {
        [UIView animateWithDuration:1 animations:^{
            self.topToolBar.alpha = 0.6;
            self.bottomToolBar.alpha = 0.6;
            self.slide.alpha = 1;
            self.isShow = YES;
        }];
    }
}


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.bgView.frame = self.view.bounds;
    self.playerLayer.frame = self.bgView.bounds;
    
    self.vedioTitle.text = [NSString trimedSpaceReturnWithString:self.vedioName];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeLeft;
}

// 返回按钮
- (IBAction)backClick:(id)sender {
    [self removeTimer];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)goBackBtn {
    NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentTime) - 10;
    // 设置当前播放时间
    [self.player seekToTime:CMTimeMakeWithSeconds(currentTime, NSEC_PER_SEC) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
}

// 播放
- (IBAction)playBtnClick {
    self.playButton.selected = !self.playButton.selected;
    if (self.playButton.selected) {  // 在播放
        [self.player play];
        
        [self addTimer];
    } else {
        [self.player pause];
        
        [self removeTimer];
    }
}

- (IBAction)forwardBtn {
    NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentTime) + 10;
    // 设置当前播放时间
    [self.player seekToTime:CMTimeMakeWithSeconds(currentTime, NSEC_PER_SEC) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
}

- (IBAction)shareClick:(id)sender {
}

// 滑动的时候
- (IBAction)slideChage:(id)sender {
    NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentItem.duration) * self.slide.value;
    NSTimeInterval duration = CMTimeGetSeconds(self.player.currentItem.duration);
    NSInteger second = (NSInteger)duration % 60;
    NSInteger minute = duration / 60;
    NSInteger hour = minute / 60;
    
    NSInteger second1 = (NSInteger)currentTime % 60;
    NSInteger minute1 = currentTime / 60;
    NSInteger hour1 = minute1 / 60;
    
    self.currentTime.text = [NSString stringWithFormat:@"%02zd:%02zd:%02zd", hour1, minute1, second1];
    self.totalTime.text = [NSString stringWithFormat:@" / %02zd:%02zd:%02zd", hour, minute, second];
}

// 按下滑块的时候
- (IBAction)slideTouchDown:(id)sender {
    [self removeTimer];
}

// 松开滑块的时候
- (IBAction)slide:(id)sender {
    [self addTimer];
    NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentItem.duration) * self.slide.value;
    
    // 设置当前播放时间
    [self.player seekToTime:CMTimeMakeWithSeconds(currentTime, NSEC_PER_SEC) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    
    [self.player play];
    
}
@end
