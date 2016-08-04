//
//  DYSqureButton.m
//  百思不得姐
//
//  Created by xudingyang on 16/4/28.
//  Copyright © 2016年 xudingyang. All rights reserved.
//

#import "DYSqureButton.h"
#import "DYGoodItem.h"
#import "UIButton+WebCache.h"

@implementation DYSqureButton

- (void)setSquare:(DYGoodItem *)square{
    _square = square;
    [self setTitle:square.iconTitle forState:UIControlStateNormal];
    [self sd_setImageWithURL:[NSURL URLWithString:square.image] forState:UIControlStateNormal];
}

// 图片在上，文字在下的按钮
- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.x = self.width * 0.2;
    self.imageView.y = self.width * 0.1;
    
    self.imageView.width = self.width - 2 * self.imageView.x;
    self.imageView.height = self.imageView.width;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.imageView.height;

}

//- (void)setHighlighted:(BOOL)highlighted{
//    // 消除高亮状态
//}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
    }
    return self;
}

@end
