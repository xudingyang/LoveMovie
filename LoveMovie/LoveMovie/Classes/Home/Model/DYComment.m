//
//  DYComment.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/25.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYComment.h"
#import "NSString+DYExt.h"

@implementation DYComment

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"commentID" : @"id"};
}


- (NSString *)publishDate{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.modifyTime];
    NSDate *perkingTime = [NSDate dateWithTimeInterval:- 8 * 60 *60 sinceDate:date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *str = [fmt stringFromDate:perkingTime];
    
    return str;
}

- (CGFloat)viewHeight{
    CGFloat viewHeight = 0;
    CGSize maxSize = CGSizeMake(DYScreenWidth - 35, 60);
    
    CGFloat textHeight = [[NSString trimedSpaceReturnWithString:self.content]   boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size.height;
    viewHeight = textHeight + 170;
    return viewHeight;
}

@end
