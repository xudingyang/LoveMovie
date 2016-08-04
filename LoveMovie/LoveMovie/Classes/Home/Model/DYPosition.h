//
//  DYPosition.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/24.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DYPosition : NSObject
/**
 *          {
 "typeName":"导演",
 "typeNameEn":"Director",
 "persons":Array[2]
 },
 */
/** typeName 职位名称 */
@property (copy, nonatomic) NSString *typeName;
/** typeNameEn 职位英文名称 */
@property (copy, nonatomic) NSString *typeNameEn;
/** persons 放置preson模型 */
@property (strong, nonatomic) NSArray *persons;

@end
