//
//  DYTop100HeaderView.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/21.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYTop100HeaderView.h"
#import "DYHeaderInTicketList.h"

@interface DYTop100HeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;

@end

@implementation DYTop100HeaderView

+ (instancetype)top100HeaderView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)setHeaderList:(DYHeaderInTicketList *)headerList{
    _headerList = headerList;
    self.titleLabel.text = headerList.name;
    self.summaryLabel.text = headerList.summary;
}

// 这里就要求，给本类的实例赋模型之后，才能设置尺寸，不然setFrame里拿不到真实文字
- (void)setFrame:(CGRect)frame{
    
    // 50是确保不超过两行
    CGSize maxSize = CGSizeMake(DYScreenWidth - 40, 50);
    // summary文字的高度
    CGFloat summaryH = [self.summaryLabel.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size.height;
    // 标题文字的高度
    CGFloat titleH = [self.titleLabel.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20]} context:nil].size.height;
    frame.size.height = summaryH + titleH + 20 * 3;
    [super setFrame:frame];
}

@end
