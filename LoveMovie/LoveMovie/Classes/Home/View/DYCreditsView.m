//
//  DYCreditsView.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/24.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYCreditsView.h"
#import "DYPosition.h"
#import "DYPerson.h"
#import <UIImageView+WebCache.h>
#import "UIImage+DYExt.h"
#import "DYCreditTableVController.h"
#import "DYTabBarController.h"
#import "DYNavigationController.h"

@interface DYCreditsView ()
@property (weak, nonatomic) IBOutlet UILabel *peopleCount;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
/** contentSizeX */
@property (assign, nonatomic) CGFloat contentSizeX;

@end

@implementation DYCreditsView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.contentScrollView.showsVerticalScrollIndicator = NO;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
}

+ (instancetype)creditsView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)setPositions:(NSArray<DYPosition *> *)positions{
    if (positions.count == 0) return;
    _positions = positions;
    NSInteger totalCount = 0;
    DYPosition *director = [[DYPosition alloc] init];
    DYPosition *actor = [[DYPosition alloc] init];
    // 导演
    for (DYPosition *temp in positions) {
        if ([temp.typeName isEqualToString:@"导演"] || [temp.typeNameEn isEqualToString:@"Director"]) {
            director = temp;
        }
        if ([temp.typeName isEqualToString:@"演员"] || [temp.typeNameEn isEqualToString:@"Actor"]) {
            actor = temp;
        }
        totalCount += temp.persons.count;
    }
    self.peopleCount.text = [NSString stringWithFormat:@"%zd位演职员", totalCount];
    
    DYPerson *personDirector = director.persons[0]; // 取出一个导演就够了
    // “导演“两个字
    UIView *directorView = [[UIView alloc] init];
    directorView.frame = CGRectMake(0, 0, 150, 300);
    
    UILabel *directorLabel = [[UILabel alloc] init];
    directorLabel.text = @"导演";
    directorLabel.frame = CGRectMake(15, 0, 120, 30);
    [directorView addSubview:directorLabel];
    // 导演头像
    UIImageView *directorIcon = [[UIImageView alloc] init];
    [directorIcon sd_setImageWithURL:[NSURL URLWithString:personDirector.image] placeholderImage:[UIImage imageNamed:@"actor_default_image_170×254"]];
    directorIcon.frame = CGRectMake(15, 32, 120, 160);
    [directorView addSubview:directorIcon];
    // 姓名
    UILabel *directorNameCn = [[UILabel alloc] init];
    directorNameCn.text = personDirector.name;
    directorNameCn.frame = CGRectMake(15, 194, 120, 20);
    directorNameCn.textAlignment = NSTextAlignmentCenter;
    directorNameCn.font = [UIFont systemFontOfSize:13];
    [directorView addSubview:directorNameCn];
    UILabel *directorNameEn = [[UILabel alloc] init];
    directorNameEn.frame = CGRectMake(15, 216, 120, 20);
    directorNameEn.text = personDirector.nameEn;
    directorNameEn.textAlignment = NSTextAlignmentCenter;
    directorNameEn.font = [UIFont systemFontOfSize:13];
    [directorView addSubview:directorNameEn];
    
    [self.contentScrollView addSubview:directorView];
    
    // 分割线
    UIView *sepratorLine = [[UIView alloc] initWithFrame:CGRectMake(150, 0, 1, 240)];
    sepratorLine.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [self.contentScrollView addSubview:sepratorLine];
    
    // “主演演员四个字”
    UILabel *mainActor = [[UILabel alloc] initWithFrame:CGRectMake(170, 0, 150, 30)];
    mainActor.text = @"主要演员";
    [self.contentScrollView addSubview:mainActor];
    
    // 演员(如果数据小于10，则全显示。如果大于10，显示前10个)
    NSInteger length = 0;
    if (actor.persons.count < 15) {
        length = actor.persons.count;
    } else {
        length = 15;
    }
    
    for (int i = 0; i < length; i++) {
        DYPerson *personActor = actor.persons[i];
        CGFloat viewW = 140;
        CGFloat viewH = 278;
        CGFloat viewY = 32;
        CGFloat viewX = 150 + i * viewW;
        UIView *actorView = [[UIView alloc] initWithFrame:CGRectMake(viewX, viewY, viewW, viewH)];
        [self.contentScrollView addSubview:actorView];
        
        UIImageView *actorIcon = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 120, 120)];
        [actorView addSubview:actorIcon];
        [actorIcon sd_setImageWithURL:[NSURL URLWithString:personActor.image] placeholderImage:[UIImage imageNamed:@"actor_default_image_100x100"]];
        // 中文名字
        UILabel *nameCn = [[UILabel alloc] initWithFrame:CGRectMake(20, 122, 120, 20)];
        nameCn.font = [UIFont systemFontOfSize:13];
        nameCn.textAlignment = NSTextAlignmentCenter;
        nameCn.text = personActor.name;
        [actorView addSubview:nameCn];
        // 英文名字
        UILabel *nameEn = [[UILabel alloc] initWithFrame:CGRectMake(20, 144, 120, 20)];
        nameEn.font = [UIFont systemFontOfSize:13];
        nameEn.textAlignment = NSTextAlignmentCenter;
        nameEn.text = personActor.nameEn;
        [actorView addSubview:nameEn];
        
        // 戏中角色头像
        UIImage *placeHolder = [[UIImage imageNamed:@"actor_default_image_100x100"] circleImage];
        UIImageView *roleIcon = [[UIImageView alloc] initWithFrame:CGRectMake(40, 179, 60, 60)];
        [roleIcon sd_setImageWithURL:[NSURL URLWithString:personActor.roleCover] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            roleIcon.image = image ? [image circleImage] : placeHolder;
        }];
        [actorView addSubview:roleIcon];
        // 戏中角色名
        UILabel *roleName = [[UILabel alloc] initWithFrame:CGRectMake(20, 254, 120, 20)];
        roleName.text = personActor.personate;
        roleName.font = [UIFont systemFontOfSize:13];
        roleName.textAlignment = NSTextAlignmentCenter;
        [actorView addSubview:roleName];
        
        self.contentSizeX = viewX + viewW + 20;
    }
    
    self.contentScrollView.contentSize = CGSizeMake(self.contentSizeX, 0);
}


- (IBAction)topBtnClick {
    if (self.positions.count == 0) {
        return;
    }
    DYCreditTableVController *vc = [[DYCreditTableVController alloc] init];
    DYTabBarController *tabBarVc = (DYTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    DYNavigationController *currentNav = tabBarVc.selectedViewController;
    vc.position = self.positions;
    [currentNav pushViewController:vc animated:YES];
}


@end
