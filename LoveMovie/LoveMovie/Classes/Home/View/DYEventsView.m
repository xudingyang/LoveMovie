//
//  DYEventsView.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/24.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYEventsView.h"
#import "DYEvents.h"

@interface DYEventsView ()
/** title 标题 */
@property (weak, nonatomic) UILabel *titleLabel;
/** UILabel *rightArrow */
@property (weak, nonatomic) UILabel *rightArrow;
@end

@implementation DYEventsView

+ (instancetype)eventsView{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        // 标题
        UILabel *titleLabel = [[UILabel alloc] init];
        [self addSubview:titleLabel];
        titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.titleLabel = titleLabel;
        
        // 右箭头
        UILabel *rightArrow= [[UILabel alloc] init];
        [self addSubview:rightArrow];
        self.rightArrow.textColor = [UIColor darkGrayColor];
        self.rightArrow = rightArrow;
    }
    return self;
}

- (void)setEvent:(DYEvents *)event{
    _event = event;
    self.titleLabel.text = event.title;
    self.titleLabel.x = 15;
    self.titleLabel.y = 15;
    [self.titleLabel sizeToFit];
    
    self.rightArrow.y = 15;
    self.rightArrow.font = [UIFont systemFontOfSize:23];
    self.rightArrow.text = @">";
    [self.rightArrow sizeToFit];
    self.rightArrow.x = self.width - self.rightArrow.width - 20;

    CGFloat labelY = 50;
    for (int i = 0; i < event.list.count; i++) {
        // 正文
        UILabel *labelText = [[UILabel alloc] init];
        labelText.text = event.list[i];
        CGFloat textHeight = [self heightOfText:labelText.text];
        labelText.x = 50;
        labelText.y = labelY;
        labelText.width = self.width - 65;
        labelText.font = [UIFont systemFontOfSize:16];
        labelText.height = textHeight;
        labelText.numberOfLines = 0;
        [self addSubview:labelText];
        
        // 标号
        UILabel *labelNum = [[UILabel alloc] init];
        labelNum.textColor = [UIColor whiteColor];
        labelNum.backgroundColor = DYRGBColor(30, 126, 192);
        labelNum.text = [NSString stringWithFormat:@"%zd", i + 1];
        labelNum.x = 15;
        labelNum.y = labelY;
        labelNum.size = CGSizeMake(30, 30);
        labelNum.layer.cornerRadius = 15;
        labelNum.layer.masksToBounds = YES;
        labelNum.font = [UIFont systemFontOfSize:16];
        labelNum.textAlignment = NSTextAlignmentCenter;
        [self addSubview:labelNum];
        
        labelY = labelY + textHeight + 20;
    }
    
    // 添加一个按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = self.bounds;
    [self addSubview:btn];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnClick{
    DYLog(@"呵呵呵");
}

- (CGFloat)heightOfText:(NSString *)text{
    CGSize maxSize = CGSizeMake(self.width - 65, MAXFLOAT);
    CGFloat height = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size.height;
    return height;
}
@end
