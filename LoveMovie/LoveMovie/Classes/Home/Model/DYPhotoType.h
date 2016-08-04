//
//  DYPhotoType.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/24.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DYPhotoType : NSObject
/**
 *      "imageTypes":[
 {
 "type":-1,
 "typeName":"显示所有"
 },
 */
/** type */
@property (assign, nonatomic) NSInteger type;
/** typeName */
@property (copy, nonatomic) NSString *typeName;

@end
