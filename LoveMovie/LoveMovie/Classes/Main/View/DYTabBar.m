//
//  DYTabBar.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/10.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYTabBar.h"

@implementation DYTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"v10_bottom_line"]];
    [self addSubview:imageView];
    imageView.frame = CGRectMake(0, 0, self.width, 1);
    
    for (UITabBarItem *item in self.items) {
        item.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
