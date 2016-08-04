//
//  DYVideo.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/24.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYVideo.h"

@implementation DYVideo

- (NSString *)lengthStr{

    NSInteger second = self.length % 60;
    NSInteger minite = self.length / 60;
    return [NSString stringWithFormat:@"%zd分%zd秒", minite, second];
}

@end
