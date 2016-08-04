//
//  DYHomeTableViewCell.m
//  LoveMovie
//
//  Created by xudingyang on 16/6/4.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYHomeTableViewCell.h"
#import "DYJianXunView.h"  // 简讯
#import "DYTouTiao.h"  // 头条
#import "DYTuJi.h"   // 图集
#import "DYXinPianView.h"  // 新片
#import "DYBangDanView.h"  // 榜单
#import "DYYingPingView.h"  // 影评
#import "DYCaiDianYingView.h"  // 猜电影
#import "DYZiXun.h"

@interface DYHomeTableViewCell ()

/** DYJianXunView简讯 */
@property (weak, nonatomic) DYJianXunView *jianxunView;
/** DYTouTiao 图集 */
@property (weak, nonatomic) DYTuJi *tujiView;
/** DYXinPianView新片 */
@property (weak, nonatomic) DYXinPianView *xinpinView;
/** DYBangDanView 榜单 */
@property (weak, nonatomic) DYBangDanView *bangdanView;
/** DYYingPingView 影评 */
@property (weak, nonatomic) DYYingPingView *yingpingView;
/** DYTouTiao 头条 */
@property (weak, nonatomic) DYTouTiao *toutiaoView;
/** DYCaiDianYingView 猜电影 */
@property (weak, nonatomic) DYCaiDianYingView *caidianyingView;
@end

static NSString * const identifer = @"DYHomeViewControllerCell";

@implementation DYHomeTableViewCell

+ (instancetype)homeCellWithTableView:(UITableView *)tableView {
    DYHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[DYHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 简讯
        DYJianXunView *jianxunView = [DYJianXunView jianXunView];
        [self.contentView addSubview:jianxunView];
        self.jianxunView = jianxunView;
        // 头条
        DYTouTiao *toutiaoView = [DYTouTiao touTiaoView];
        [self.contentView addSubview:toutiaoView];
        self.toutiaoView = toutiaoView;
        // 影评
        DYYingPingView *yingpingView = [DYYingPingView yingPingView];
        [self.contentView addSubview:yingpingView];
        self.yingpingView = yingpingView;
        // 新片
        DYXinPianView *xinpinView = [DYXinPianView xinPinView];
        [self.contentView addSubview:xinpinView];
        self.xinpinView = xinpinView;
        // 榜单
        DYBangDanView *bangdanView = [DYBangDanView bangDanView];
        [self.contentView addSubview:bangdanView];
        self.bangdanView = bangdanView;
        // 图集
        DYTuJi *tujiView = [DYTuJi tuJiView];
        [self.contentView addSubview:tujiView];
        self.tujiView = tujiView;
        // 猜电影
        DYCaiDianYingView *caidianyingView = [DYCaiDianYingView caidianyingView];
        [self.contentView addSubview:caidianyingView];
        self.caidianyingView = caidianyingView;
    }
    return self;
}

- (void)setZixun:(DYZiXun *)zixun {
    _zixun = zixun;
    if ([zixun.tag isEqualToString:@"简讯"]) {
        // 简讯
        self.jianxunView.hidden = NO;
        self.jianxunView.zixun = zixun;
        // 头条
        self.toutiaoView.hidden = YES;
        // 影评
        self.yingpingView.hidden = YES;
        // 新片
        self.xinpinView.hidden = YES;
        // 榜单
        self.bangdanView.hidden = YES;
        // 图集
        self.tujiView.hidden = YES;
        // 猜电影
        self.caidianyingView.hidden = YES;
    } else if ([zixun.tag isEqualToString:@"头条"]) {
        // 简讯
        self.jianxunView.hidden = YES;
        // 头条
        self.toutiaoView.hidden = NO;
        self.toutiaoView.zixun = zixun;
        // 影评
        self.yingpingView.hidden = YES;
        // 新片
        self.xinpinView.hidden = YES;
        // 榜单
        self.bangdanView.hidden = YES;
        // 图集
        self.tujiView.hidden = YES;
        // 猜电影
        self.caidianyingView.hidden = YES;
    } else if ([zixun.tag isEqualToString:@"影评"]) {
        // 简讯
        self.jianxunView.hidden = YES;
        // 头条
        self.toutiaoView.hidden = YES;
        // 影评
        self.yingpingView.hidden = NO;
        self.yingpingView.zixun = zixun;
        // 新片
        self.xinpinView.hidden = YES;
        // 榜单
        self.bangdanView.hidden = YES;
        // 图集
        self.tujiView.hidden = YES;
        // 猜电影
        self.caidianyingView.hidden = YES;
    } else if ([zixun.tag isEqualToString:@"图集"]) {
        // 简讯
        self.jianxunView.hidden = YES;
        // 头条
        self.toutiaoView.hidden = YES;
        // 影评
        self.yingpingView.hidden = YES;
        // 新片
        self.xinpinView.hidden = YES;
        // 榜单
        self.bangdanView.hidden = YES;
        // 图集
        self.tujiView.hidden = NO;
        self.tujiView.zixun = zixun;
        // 猜电影
        self.caidianyingView.hidden = YES;
    } else if ([zixun.tag isEqualToString:@"欧美新片"] || [zixun.tag isEqualToString:@"日韩新片"]) {
        // 简讯
        self.jianxunView.hidden = YES;
        // 头条
        self.toutiaoView.hidden = YES;
        // 影评
        self.yingpingView.hidden = YES;
        // 新片
        self.xinpinView.hidden = NO;
        self.xinpinView.zixun = zixun;
        // 榜单
        self.bangdanView.hidden = YES;
        // 图集
        self.tujiView.hidden = YES;
        // 猜电影
        self.caidianyingView.hidden = YES;
    } else if ([zixun.tag isEqualToString:@"猜电影"]) {
        // 简讯
        self.jianxunView.hidden = YES;
        // 头条
        self.toutiaoView.hidden = YES;
        // 影评
        self.yingpingView.hidden = YES;
        // 新片
        self.xinpinView.hidden = YES;
        // 榜单
        self.bangdanView.hidden = YES;
        // 图集
        self.tujiView.hidden = YES;
        // 猜电影
        self.caidianyingView.hidden = NO;
        self.caidianyingView.zixun = zixun;
    } else if ([zixun.tag isEqualToString:@"榜单"] || [zixun.tag isEqualToString:@"电影榜单"] || [zixun.tag isEqualToString:@"电视榜单"] || [zixun.tag isEqualToString:@"爆笑片单"]) {
        // 简讯
        self.jianxunView.hidden = YES;
        // 头条
        self.toutiaoView.hidden = YES;
        // 影评
        self.yingpingView.hidden = YES;
        // 新片
        self.xinpinView.hidden = YES;
        // 榜单
        self.bangdanView.hidden = NO;
        self.bangdanView.zixun = zixun;
        // 图集
        self.tujiView.hidden = YES;
        // 猜电影
        self.caidianyingView.hidden = YES;
    }
}

@end
