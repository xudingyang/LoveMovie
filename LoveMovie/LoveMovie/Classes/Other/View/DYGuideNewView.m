//
//  DYGuideNewView.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/13.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#define IMAGES_COUNT 4
#import "DYGuideNewView.h"

@interface DYGuideNewView () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *folwLayout;

/** images数组 */
@property (strong, nonatomic) NSArray *images;

@end

static NSString *identifier = @"guideViewCell";

@implementation DYGuideNewView

- (NSArray *)images{
    if (_images == nil) {
        NSMutableArray *temArray = [NSMutableArray array];
        for (int i = 1; i <= IMAGES_COUNT; i++) {
//            wizard1_568
            NSString *str = [NSString stringWithFormat:@"wizard%d_568", i];
            UIImage *image = [UIImage imageNamed:str];
            [temArray addObject:image];
        }
        _images = temArray;
    }
    return _images;
}

+ (instancetype)guideView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    // 注册cell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    // 设置collectionView
    // cell间距
    self.folwLayout.minimumLineSpacing = 0;
    // 分页效果
    self.collectionView.pagingEnabled = YES;
    // 隐藏滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.frame = [UIScreen mainScreen].bounds;
    // 设置cell尺寸
    self.folwLayout.itemSize = self.bounds.size;
}

#pragma mark - 对外提供的方法
+ (void)showGuideView{
    // 获取当前版本号
    NSString *key = @"CFBundleShortVersionString";
    NSString *currentVesion = [NSBundle mainBundle].infoDictionary[key];
    // 获取存在沙盒里（以前存的）的版本号
    NSString *previousVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    // 如果两者相同，说明是同一版本，不必显示写特性界面。如果不同，则显示
    if (![currentVesion isEqualToString:previousVersion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        DYGuideNewView *guideView = [DYGuideNewView guideView];
        [window addSubview:guideView];
        
        // 存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVesion forKey:key];
        // 及时更新沙盒
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return IMAGES_COUNT;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    UIImage *image = self.images[indexPath.row];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [cell addSubview:imageView];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ((IMAGES_COUNT - 1) == indexPath.row) {
        [self removeFromSuperview];
    }
}
@end
