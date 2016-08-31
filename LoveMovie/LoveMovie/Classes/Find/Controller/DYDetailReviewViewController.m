//
//  DYDetailReviewViewController.m
//  LoveMovie
//
//  Created by xudingyang on 16/8/10.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYDetailReviewViewController.h"
#import "DYDetailReviewHeader.h"
#import <AFNetworking.h>
#import "DYDetailReview.h"
#import <MJExtension.h>

@interface DYDetailReviewViewController ()
@property (weak, nonatomic) IBOutlet UILabel *commentCount;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
/** afn */
@property (strong, nonatomic) AFHTTPSessionManager *manager;
/** DYDetailReview */
@property (strong, nonatomic) DYDetailReview *detailReview;
/** header */
@property (weak, nonatomic) DYDetailReviewHeader *headerView;
@end

@implementation DYDetailReviewViewController

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [[AFHTTPSessionManager alloc] init];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(200, 0, 50, 0);
    DYDetailReviewHeader *view = [DYDetailReviewHeader detailReviewHeader];
    self.headerView = view;
    view.frame = CGRectMake(0, -200, DYScreenWidth, 200);
    self.webView.scrollView.contentOffset = CGPointMake(0, -800);
    [self.webView.scrollView addSubview:view];
    // 下载
    [self loadData];
}

// http://api.m.mtime.cn/Review/Detail.api?reviewId=7958599
- (void)loadData {
    NSMutableSet *mutSet = [NSMutableSet setWithSet:self.manager.responseSerializer.acceptableContentTypes];
    [mutSet addObject:@"text/html"];
    [mutSet addObject:@"application/x-javascript"];
    self.manager.responseSerializer.acceptableContentTypes = mutSet;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"reviewId"] = @(self.reviewID);
    [self.manager GET:@"http://api.m.mtime.cn/Review/Detail.api" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.detailReview = [DYDetailReview mj_objectWithKeyValues:responseObject];
        if (!self.detailReview) return ;
        
        [self setupWebView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DYLog(@"%@", error);
    }];
}

- (void)setupWebView {
    // 下边是评论条的高度40 + 间距10
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    DYDetailReviewHeader *view = [DYDetailReviewHeader detailReviewHeader];
//    view.frame = CGRectMake(0, -200, DYScreenWidth, 200);
    self.headerView.detailReview = self.detailReview;
    self.headerView.movieName = self.movieName;
//    self.webView.scrollView.contentOffset = CGPointMake(0, -800);
//    [self.webView.scrollView addSubview:view];

    NSMutableString *htmlString = [NSMutableString string];
    [htmlString appendString:@"<!doctype html>"];
    [htmlString appendString:@"<head>"];
    [htmlString appendString:@"<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0,minimum-scale=1.0, maximum-scale=1.0\"/>"];
    
    NSMutableString *cssString = [NSMutableString string];
    [cssString appendString:@"<style type=\"text/css\">"];
    [cssString appendString:@".img-responsive {"];
    [cssString appendString:@"text-align: center;"];
    [cssString appendString:@"max-width: 98% !important;"];
    [cssString appendString:@"height: auto"];
    [cssString appendString:@"}"];
    [cssString appendString:@"</style>"];
    
    [htmlString appendString:cssString];
    [htmlString appendString:@"</head>"];
    
    [htmlString appendString:@"<body>"];
    [htmlString appendString:self.detailReview.content];
    
    // 把图片周边的乱七八糟的东西干掉
    htmlString = (NSMutableString *)[htmlString stringByReplacingOccurrencesOfString:@"<span>" withString:@""];
    htmlString = (NSMutableString *)[htmlString stringByReplacingOccurrencesOfString:@"</span>" withString:@""];
    htmlString = (NSMutableString *)[htmlString stringByReplacingOccurrencesOfString:@"<p><br></p>" withString:@""];
    htmlString = (NSMutableString *)[htmlString stringByReplacingOccurrencesOfString:@"<p><b>" withString:@""];
    htmlString = (NSMutableString *)[htmlString stringByReplacingOccurrencesOfString:@"<br><br></b></p>" withString:@""];
    htmlString = (NSMutableString *)[htmlString stringByReplacingOccurrencesOfString:@"<p><img" withString:@"<img"];
    htmlString = (NSMutableString *)[htmlString stringByReplacingOccurrencesOfString:@"\"></p>" withString:@"\">"];
    
    htmlString = (NSMutableString *)[htmlString stringByReplacingOccurrencesOfString:@"<img src=" withString:@"<img class=\"img-responsive\" src="];
    
    // 干掉其他不显示的
    htmlString = (NSMutableString *)[htmlString stringByReplacingOccurrencesOfString:@"<embed" withString:@"<!--"];
    htmlString = (NSMutableString *)[htmlString stringByReplacingOccurrencesOfString:@"</embed>" withString:@"-->"];

    htmlString = (NSMutableString *)[htmlString stringByReplacingOccurrencesOfString:@"<p>" withString:@"<p style=\"text-indent: 2em;\">"];
    
    [htmlString appendString:@"</body>"];
    [htmlString appendString:@"</html>"];
    
    
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
    [self.webView loadHTMLString:htmlString baseURL:baseURL];
    self.commentCount.text = [NSString stringWithFormat:@"%zd", self.detailReview.commentCount];
}

- (IBAction)clickComment {
    DYLog(@"fff");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
