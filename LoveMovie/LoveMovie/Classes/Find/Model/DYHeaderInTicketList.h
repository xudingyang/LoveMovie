//
//  DYHeaderInTicketList.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/21.
//  Copyright © 2016年 许定阳. All rights reserved.
//  票房cell的模型里的toplist模型：放置票房单位信息。
//  Top100里的header

#import <Foundation/Foundation.h>

@interface DYHeaderInTicketList : NSObject

/** topListID 在票房里面没用，在top100里面的id */
@property (assign, nonatomic) NSInteger topListID;  // id

/** 票房里的单位。top100里面的副标题 */
@property (copy, nonatomic) NSString *summary;

/** name票房里的地区名。 top100里面的标题 */
@property (copy, nonatomic) NSString *name;

/** totalCount 总的条数 */
@property (assign, nonatomic) NSInteger totalCount;

@end
