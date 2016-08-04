//
//  DYMovieDetailVC.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/21.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYMovieDetailVC.h"
#import "DYMovieHeader.h"
#import "DYNavigationController.h"
#import "DYVideoPhotoesView.h"
#import "DYVideo.h"
#import "DYPotoes.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "DYPhotoType.h"
#import "DYCreditsView.h"
#import "DYPosition.h"
#import "DYRelatedNewsView.h"
#import "DYEvents.h"
#import "DYEventsView.h"
#import "DYRelatedNews.h"
#import "DYCommentView.h"
#import "DYComment.h"
#import "DYNetFriendCommentView.h"
#import "DYNetFriendComment.h"
#import "DYCommentData.h"
#import "DYNetFriendCommentVC.h"
#import "DYNoHighlitedButton.h"

@interface DYMovieDetailVC () <UIScrollViewDelegate>

/** 容器scrollView */
@property (weak, nonatomic) UIScrollView *contentScrollView;
/** contenSizeY scrollView在y方向上的滚动距离 */
@property (assign) CGFloat contenSizeY;
/** 视频数组 */
@property (strong, nonatomic) NSArray *videos;
/** 剧照数组 */
@property (strong, nonatomic) NSArray *potoes;
/** 剧照类型数组 */
@property (strong, nonatomic) NSArray *potoTypes;
/** 演职员数组 */
@property (strong, nonatomic) NSArray *positions;
/** manager */
@property (strong, nonatomic) AFHTTPSessionManager *manager;

/** commentCount */
@property (assign, nonatomic) NSInteger commentCount;
@end

@implementation DYMovieDetailVC



#pragma mark - 懒加载manager
- (AFHTTPSessionManager *)manager{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DYGlobalBackgroundColor;
    [self setupContentScrollView];
    
    NSMutableSet *mutSet = [NSMutableSet setWithSet:self.manager.responseSerializer.acceptableContentTypes];
    [mutSet addObject:@"application/x-javascript"];
    [mutSet addObject:@"text/html"];
    self.manager.responseSerializer.acceptableContentTypes = mutSet;
}

#pragma mark - 设置contentScrollView
- (void)setupContentScrollView{
    UIScrollView *contentScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:contentScrollView];
    contentScrollView.backgroundColor = [UIColor redColor];
    
    self.contentScrollView = contentScrollView;
    self.automaticallyAdjustsScrollViewInsets = NO;
    contentScrollView.delegate = self;
    
    [self addHeader];
    [self addVediosPhotoes];
    [self addCredisView];
    [self addRelatedNewsEvents];
    [self addReviewsView];
    [self addNetFriendComment];
}

#pragma mark - 因为有些view是需要等网络请求下来后才能确定高度，所以要等view都布局好之后，才能确定contentSize
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.contentScrollView.contentSize = CGSizeMake(0, self.contenSizeY);
}

#pragma mark - 添加header（电影头部）
- (void)addHeader{
    DYMovieHeader *header = [DYMovieHeader movieHeader];
    header.frame = CGRectMake(0, 0, DYScreenWidth, 350);
    self.contenSizeY += 350 + 20;
    [self.contentScrollView addSubview:header];
    header.movieName.text = self.movieName;
    header.iconUrl = self.iconUrl;
    header.movieEnName.text = self.movieEnName;
    header.movieLength.text = self.movieLength;
    self.navigationItem.title = self.movieName;
    if (self.movieScore <= 0) {
        header.movieScore.hidden = YES;
    } else {
        header.movieScore.hidden = NO;
        header.movieScore.text = [NSString stringWithFormat:@"%.1f", self.movieScore];
    }
    header.movieType.text = self.movieType;
    header.showDateArea.text = self.showDateArea;
    header.isTicket = self.isTicket;
}

// http://api.m.mtime.cn/Movie/Video.api?movieId=209122&pageIndex=1
// http://api.m.mtime.cn/Movie/ImageAll.api?movieId=209122
#pragma mark - 添加剧照视频
- (void)addVediosPhotoes{
    DYVideoPhotoesView *videoPotoesView = [DYVideoPhotoesView videoPhotoesView];
    videoPotoesView.frame = CGRectMake(0, self.contenSizeY, self.contentScrollView.width, 220);
    self.contenSizeY += 220 + 20;
    [self.contentScrollView addSubview:videoPotoesView];
    
    // 请求视频数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"movieId"] = @(self.movieID);
    params[@"pageIndex"] = @(1);
    [self.manager GET:@"http://api.m.mtime.cn/Movie/Video.api" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.videos = [DYVideo mj_objectArrayWithKeyValuesArray:responseObject[@"videoList"]];
        if (self.videos.count == 0) {
            return ;
        }
        videoPotoesView.video = self.videos[0];
        videoPotoesView.videoCount.text = [NSString stringWithFormat:@"%@", responseObject[@"totalCount"]];
        videoPotoesView.movieID = self.movieID;
        videoPotoesView.movieName = self.movieName;
        videoPotoesView.movieEnName = self.movieEnName;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     
    }];
    
    // 请求照片数据
    NSMutableDictionary *pars = [NSMutableDictionary dictionary];
    pars[@"movieId"] = @(self.movieID);
    [self.manager GET:@"http://api.m.mtime.cn/Movie/ImageAll.api" parameters:pars progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.potoes = [DYPotoes mj_objectArrayWithKeyValuesArray:responseObject[@"images"]];
        self.potoTypes = [DYPhotoType mj_objectArrayWithKeyValuesArray:responseObject[@"imageTypes"]];
        if (self.potoes.count == 0) {
            return ;
        }
        videoPotoesView.poto = self.potoes[0];
        videoPotoesView.potoCount.text = [NSString stringWithFormat:@"%zd", self.potoes.count];
        videoPotoesView.photoes = self.potoes;
        videoPotoesView.photoTypes = self.potoTypes;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     
    }];
    
    
}

// http://api.m.mtime.cn/Movie/MovieCreditsWithTypes.api?movieId=209122
#pragma mark - 添加演职员
- (void)addCredisView{
    DYCreditsView *credisView = [DYCreditsView creditsView];
    credisView.frame = CGRectMake(0, self.contenSizeY, self.contentScrollView.width, 380);
    self.contenSizeY += 400;
    [self.contentScrollView addSubview:credisView];
    // 请求数据
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"movieId"] = @(self.movieID);
    [self.manager GET:@"http://api.m.mtime.cn/Movie/MovieCreditsWithTypes.api" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.positions = [DYPosition mj_objectArrayWithKeyValuesArray:responseObject[@"types"]];
        credisView.positions = self.positions;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

// http://api.m.mtime.cn/Movie/extendMovieDetail.api?MovieId=209122
#pragma mark - 添加相关新闻和事件
- (void)addRelatedNewsEvents{
    DYRelatedNewsView *relatedNewsView = [DYRelatedNewsView relatedNewsView];
    [self.contentScrollView addSubview:relatedNewsView];
    relatedNewsView.frame = CGRectMake(0, self.contenSizeY, self.contentScrollView.width, 230);
    self.contenSizeY += 250;
    
    DYEventsView *eventsView = [DYEventsView eventsView];
    [self.contentScrollView addSubview:eventsView];
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"MovieId"] = @(self.movieID);
    [self.manager GET:@"http://api.m.mtime.cn/Movie/extendMovieDetail.api" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *newsArray = [DYRelatedNews mj_objectArrayWithKeyValuesArray:responseObject[@"news"]];
        if (newsArray.count != 0) {
            DYRelatedNews *news = newsArray[0];
            relatedNewsView.relatedNews = news;
        }
        DYEvents *event = [DYEvents mj_objectWithKeyValues:responseObject[@"events"]];
            
        eventsView.frame = CGRectMake(0, self.contenSizeY, self.contentScrollView.width, event.viewHeight);
        self.contenSizeY += event.viewHeight + 20;
        eventsView.event = event;
        
        UIView *footerView = [[UIView alloc] init];
        footerView.frame = CGRectMake(0, self.contenSizeY, self.contentScrollView.width, 60);
        self.contenSizeY += 60 + 20;
        [self.contentScrollView addSubview:footerView];
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        button1.x = 0;
        button1.y = 0;
        button1.width = footerView.width * 0.5;
        button1.height = footerView.height;
        [button1 setTitle:@"制作发行" forState:UIControlStateNormal];
        [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button1 setImage:[UIImage imageNamed:@"homepage_mallentry_ ranking"] forState:UIControlStateNormal];
        button1.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        button1.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        button1.titleLabel.font = [UIFont systemFontOfSize:25];
        [button1 addTarget:self action:@selector(button1Click) forControlEvents:UIControlEventTouchUpInside];
        button1.backgroundColor = [UIColor whiteColor];
        [footerView addSubview:button1];
        
        UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        button2.y = 0;
        button2.x = footerView.width * 0.5;
        button2.height = footerView.height;
        button2.width = footerView.width * 0.5;
        [button2 setTitle:@"更多资料" forState:UIControlStateNormal];
        [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button2 setImage:[UIImage imageNamed:@"homepage_mallentry_ notice"] forState:UIControlStateNormal];
        button2.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        button2.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
         button2.titleLabel.font = [UIFont systemFontOfSize:25];
        [button2 addTarget:self action:@selector(button2Click) forControlEvents:UIControlEventTouchUpInside];
        button2.backgroundColor = [UIColor whiteColor];
        [footerView addSubview:button2];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
     
}

- (void)button1Click{
    
}

- (void)button2Click{
    
}

// http://api.m.mtime.cn/Movie/HotLongComments.api?movieId=209122&pageIndex=1
#pragma mark - 添加影评
- (void)addReviewsView{
    DYCommentView *commentView = [DYCommentView commentView];
    commentView.frame = CGRectMake(0, self.contenSizeY, self.contentScrollView.width, 230);
    self.contenSizeY += 230 + 20;
    [self.contentScrollView addSubview:commentView];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"movieId"] = @(self.movieID);
    params[@"pageIndex"] = @(1);
    [self.manager GET:@"http://api.m.mtime.cn/Movie/HotLongComments.api" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *temp = [DYComment mj_objectArrayWithKeyValuesArray:responseObject[@"comments"]];
        if (temp.count == 0) {
            return ;
        }
        DYComment *comment = temp[0];
        commentView.comment = comment;
        commentView.commentsCount.text = [NSString stringWithFormat:@"%@", responseObject[@"totalCount"]];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

// http://api.m.mtime.cn/Showtime/HotMovieComments.api?movieId=209122&pageIndex=1
#pragma mark - 添加网友短评
- (void)addNetFriendComment{
    UIView *view = [[UIView alloc] init];
    view.x = 0;
    view.y = self.contenSizeY;
    view.width = self.contentScrollView.width;
    view.height = 445 + 192 * 3;
    self.contenSizeY += 45 + 192 * 3 + 20;
    [self.contentScrollView addSubview:view];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, view.width, 45);
    [view addSubview:button];
    button.backgroundColor = [UIColor whiteColor];
    [button addTarget:self action:@selector(netFriendCommentClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [[UILabel alloc] init];
    label.x = 15;
    label.y = 15;
    label.font = [UIFont boldSystemFontOfSize:20];
    [view addSubview:label];
    
    UILabel *rightLabel = [[UILabel alloc] init];
    rightLabel.text = @">";
    rightLabel.textColor = [UIColor darkGrayColor];
    [rightLabel sizeToFit];
    rightLabel.x = view.width - rightLabel.width - 20;
    rightLabel.height = 30;
    rightLabel.y = 15;
    [view addSubview:rightLabel];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"movieId"] = @(self.movieID);
    params[@"pageIndex"] = @(1);
    [self.manager GET:@"http://api.m.mtime.cn/Showtime/HotMovieComments.api" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DYCommentData *data = [DYCommentData mj_objectWithKeyValues:responseObject[@"data"]];
        label.text = [NSString stringWithFormat:@"%zd条网友短评", data.totalCount];
        self.commentCount = data.totalCount;
        [label sizeToFit];
        label.height = 30;
        
        NSArray *cmts = data.cts;
        NSInteger count = cmts.count > 3 ? 3 : cmts.count;
        CGFloat labelY = 40;
        for (int i = 0; i < count; i++) {
            DYNetFriendCommentView *netFriendView = [DYNetFriendCommentView netFriendCommentView];
            [view addSubview:netFriendView];
            DYNetFriendComment *comment = cmts[i];
            netFriendView.netFriendComment = comment;
            netFriendView.frame = CGRectMake(0, labelY, view.width, comment.viewHeight);
            labelY += comment.viewHeight;
        }
//        view.height = labelY;
//        self.contenSizeY += labelY + 20;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
- (void)netFriendCommentClick{
    if (self.commentCount == 0) {
        return;
    }
    DYNetFriendCommentVC *vc = [[DYNetFriendCommentVC alloc] init];
    vc.movieID = self.movieID;
    [self.navigationController pushViewController:vc animated:YES];
}

// 这是为了保证，模态的控制器退出后，本控制器顶部保持原样
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self scrollViewDidScroll:self.contentScrollView];
}

#pragma mark - <UITableViewDelegate>控制颜色渐变
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGPoint offset = scrollView.contentOffset;
    CGFloat alphaScale = offset.y / 80.0;
    
    DYNavigationController *nav = (DYNavigationController *)self.navigationController;
    nav.navBarBgView.alpha = alphaScale;
    
    // 让下边有弹簧效果，上边没有。这里注意值传递的问题。scrollView.contentOffset不能换成上边的offset
    if (scrollView.contentOffset.y <= 0) {
        CGPoint TmpOffset = scrollView.contentOffset;
        TmpOffset.y = 0;
        scrollView.contentOffset = TmpOffset;
    }
}

- (void)dealloc{
    [self.manager invalidateSessionCancelingTasks:YES];
}

@end
