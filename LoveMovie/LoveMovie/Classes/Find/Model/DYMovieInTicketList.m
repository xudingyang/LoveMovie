//
//  DYMovieInTicketList.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/21.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYMovieInTicketList.h"

@implementation DYMovieInTicketList
{
    CGFloat _cellHeight;
    CGFloat _cellCloseHeight;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"chineseName" : @"name",
             @"englishName" : @"nameEn",
             @"movieID" : @"id"
             };
}


- (NSInteger)weekBoxOfficeNum{
    NSString *str = self.weekBoxOffice;
    str = [[str componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""];
    return [str integerValue];
}

- (NSInteger)totalBoxOfficeNum{
    NSString *str = self.totalBoxOffice;
    str = [[str componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""];
    return [str integerValue];
}


// 按照文字来计算cell的真实高度
- (CGFloat)cellHeight{
    
    CGSize maxSize = CGSizeMake(DYScreenWidth - 42, MAXFLOAT);
    CGFloat remarkH = [self.remark boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size.height;
    
    _cellHeight = remarkH + 189;
    return _cellHeight;
}

- (CGFloat)cellCloseHeight{
    // 两行的高度 50
    CGSize maxSize = CGSizeMake(DYScreenWidth - 42, 50);
    CGFloat remarkH = [self.remark boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size.height;
    
    _cellCloseHeight = remarkH + 189;
    
    return _cellCloseHeight;
}

- (NSString *)showDateArea{
    return [NSString stringWithFormat:@"%@%@上映", self.releaseDate, self.releaseLocation];
}

@end
