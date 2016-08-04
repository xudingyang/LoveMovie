//
//  DYIndicatorView.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/15.
//  Copyright © 2016年 许定阳. All rights reserved.
//

/** 按钮文字不处于选中状态的color || 指示器被选中时，按钮文字也是这个颜色 */
#define DYBtnTitleNormalColor [UIColor colorWithRed:210/255.0 green:213/255.0 blue:215/255.0 alpha:1.0]
/** 按钮文字处于选中状态的color */
#define DYBtnTitleSelectedColor [UIColor colorWithRed:4/255.0 green:117/255.0 blue:194/255.0 alpha:1]

/** 指示器没被点击时候的颜色 */
#define DYIndicatorNormalColor [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.8]
/** 指示器被点击时候的颜色 */
#define DYIndicatorPresedColor [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.5]

//#warning 这里注意，不要漏掉括号，不然下边做除法计算index的时候，永远得0。坑的是自己。检查了一下午，卧槽！
/** 指示器的宽度，按钮的宽度也是这个 */
#define DYIndicatorWidth (self.frame.size.width / self.titles.count)
/** 指示器的高度，按钮的高度*/
#define DYIndicatorHeight self.frame.size.height


#import "DYIndicatorView.h"

@interface DYIndicatorView ()

/** UIView *indicatorView 指示器的view*/
@property (weak, nonatomic) UIView *indicatorView;
/** currentBtn 标记当前选中的按钮 */
@property (weak, nonatomic) UIButton *currentBtn;
/** buttons 存放按钮 */
@property (strong, nonatomic) NSMutableArray *buttons;


@end

@implementation DYIndicatorView

#pragma mark - 懒加载buttons
- (NSMutableArray *)buttons{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

+ (instancetype)indicatorView{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setTitles:(NSArray *)titles{
    _titles = titles;
    [self setupIndicatorView];
}

- (void)setupIndicatorView{
    // 背景图片(外界边框)
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_register"]];
    imageView.frame = self.bounds;
    [self insertSubview:imageView atIndex:0];
    
    // 指示器要加在按钮后边，不然会挡住按钮的文字。这样，当点击的点位于指示器范围内的时候，就需要指定不让按钮接收事件，而是给指示器接收事件
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = DYIndicatorNormalColor;
    // indicator初始位置(跟第一个按钮重合)
    indicatorView.frame = CGRectMake(0, 0, DYIndicatorWidth, DYIndicatorHeight);
    [self addSubview:indicatorView];
    self.indicatorView = indicatorView;
    
    // 添加按钮
    CGFloat btnW = DYIndicatorWidth;
    CGFloat btnH = DYIndicatorHeight;
    CGFloat btnY = 0;
    for (NSInteger i = 0; i < self.titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat btnX = btnW * i;
        button.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        [button setTitle:self.titles[i] forState:UIControlStateNormal];
        [button setTitleColor:DYBtnTitleSelectedColor forState:UIControlStateSelected];
        [button setTitleColor:DYBtnTitleNormalColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        [self.buttons addObject:button];
    }
    // 默认选中第一个按钮
    [self didSelectedButton:self.buttons[0]];
}

#pragma mark - 当点击范围在指示器范围内时，不把事件传给按钮，直接让指示器接收
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    // 转换参照系
    // 将point的参照系由  self转为指示器。因为下边的pointInside判断是以指示器为参照系的，所以这里要转换坐标系。
    // 如果不转换坐标系，那么就会把self里的坐标放到_indicatorView来比较。这样显然不对。
    CGPoint indicatorPoint = [self convertPoint:point toView:self.indicatorView];
    
    // - (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event;方法默认返回YES，表示此视图不处理该事件，事件继续往后边传递。所以这里直接拦截，不往后传递了，就在self处理。
    // 这里表示如果该事件在_indicatorView内，就不往后边传递了，直接在_indicatorView处理
    if ([self.indicatorView pointInside:indicatorPoint withEvent:event]) {
        return self;
    } else {
        return [super hitTest:point withEvent:event];
    }
}

#pragma mark 本view的触摸事件处理，当在indicatorView范围内时候，交给indicatorView处理。只是事件交给它处理，移动的距离以及手指坐标，还是以本view为参照系的。上边一个方法转换参数，只是为了判断手指是否在指示器内(这是UIView的事件处理方法，点击按钮的时候，不会来到这个方法，因为按钮得到事件的优先级高于父控件UIView)
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self indicatorBeganSelected];
}

#pragma mark - 移动的时候，更改indicatorView的坐标。这里本来是用的手势来处理，但是拖拽手势超出self范围后，还是可以拖拽，这点不好处理。
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    CGPoint previousPoint = [touch previousLocationInView:self];
    // x方向上拖动的范围（因为，是用后一个减前一个，所以这里有正负号之分）
    CGFloat delta = currentPoint.x - previousPoint.x;
    CGRect frame = self.indicatorView.frame;
    // 拖动的范围在 0 ~ (总宽 - 一个按钮宽) 之间
    //    if (delta >= 0 && delta <= (self.buttons.count - 1) * DYIndicatorWidth) {
    //        frame.origin.x += delta;
    //    }
    // 上边的判断方式是错的，很明显从右往左拖的时候，delta为负数。
    if (frame.origin.x + delta >= 0 && frame.origin.x + delta <= (self.buttons.count - 1) * DYIndicatorWidth) {
        frame.origin.x = frame.origin.x + delta;
    }
    self.indicatorView.frame = frame;
}

#pragma mark - 停止拖动以后，判断indicator所在的位置
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    // 滚到位置的数组下标(只要中心点过了按钮边界，就跳到下一个按钮)  中心点x / 按钮的宽度
    NSInteger index = self.indicatorView.center.x / DYIndicatorWidth;
    [self didSelectedButton:self.buttons[index]];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self touchesEnded:touches withEvent:event];
}

#pragma mark - 按钮监听
- (void)buttonClick:(UIButton *)button{
    [self didSelectedButton:button];
}

- (void)didSelectedButton:(UIButton *)button{
    NSInteger index = [self.buttons indexOfObject:button];
    if (self.currentBtn == button) {
        [self indicatorEndSelected];
        self.indicatorView.frame = CGRectMake(DYIndicatorWidth * index, 0, DYIndicatorWidth, DYIndicatorHeight);
        return;
    }
    
    [self.currentBtn setTitleColor:DYBtnTitleNormalColor forState:UIControlStateSelected];
    button.selected = YES;
    self.currentBtn = button;
    // 根据按钮确定indicator的frame
    [UIView animateWithDuration:0.15 animations:^{
        self.indicatorView.frame = CGRectMake(DYIndicatorWidth * index, 0, DYIndicatorWidth, DYIndicatorHeight);
    } completion:^(BOOL finished) {
        [self indicatorEndSelected];
    }];
    
    if ([self.delegate respondsToSelector:@selector(indicatorViewDidSelectedButtonTitle:)]) {
        [self.delegate indicatorViewDidSelectedButtonTitle:button.titleLabel.text];
    }
}

#pragma mark - 点击指示器的时候：当前按钮文字变色，指示器透明度更改
- (void)indicatorBeganSelected{
    [self.currentBtn setTitleColor:DYBtnTitleNormalColor forState:UIControlStateSelected];
    self.indicatorView.backgroundColor = DYIndicatorPresedColor;
}

#pragma mark - 松开指示器
- (void)indicatorEndSelected{
    [self.currentBtn setTitleColor:DYBtnTitleSelectedColor forState:UIControlStateSelected];
    self.indicatorView.backgroundColor = DYIndicatorNormalColor;
}

@end

