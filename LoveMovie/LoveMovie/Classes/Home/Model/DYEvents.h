//
//  DYEvents.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/24.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DYEvents : NSObject
/**
 *      "events":{
 "eventCount":20,
 "list":Array[3],
 "title":"该片你该了解的20件事"
 },
 */
/** eventCount 新闻条数 */
@property (assign, nonatomic) NSInteger eventCount;
/** 新闻数组（字符串数组） */
@property (strong, nonatomic) NSArray *list;
/** title 新闻标题 */
@property (copy, nonatomic) NSString *title;


/****************************
 *  辅助属性
 ****************************/
/** 该view的高度 */
@property (assign, nonatomic, readonly) CGFloat viewHeight;

@end
