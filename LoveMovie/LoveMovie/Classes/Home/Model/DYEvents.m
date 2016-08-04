//
//  DYEvents.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/24.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYEvents.h"

@implementation DYEvents

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"list" : @"NSString"};
}

- (CGFloat)viewHeight{
    CGFloat viewHeight = 0;
    for (NSString *text in self.list) {
        CGFloat textHeight = [self heightOfText:text];
        viewHeight += textHeight + 20;
    }
    viewHeight = viewHeight + 50;
    return viewHeight;
}

- (CGFloat)heightOfText:(NSString *)text{
    CGSize maxSize = CGSizeMake(DYScreenWidth - 65, MAXFLOAT);
    CGFloat height = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size.height;
    return height;
}

@end
