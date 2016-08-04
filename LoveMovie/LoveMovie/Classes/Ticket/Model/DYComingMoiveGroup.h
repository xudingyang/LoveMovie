//
//  DYComingMoiveGroup.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/18.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DYComingMoiveGroup : NSObject

/** keyMonth 记录月份 */
@property (assign, nonatomic) NSInteger keyMonth;

/** comingMoives 放置当月的电影 */
@property (strong, nonatomic) NSArray *comingMoives;

@end
