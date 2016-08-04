//
//  DYPotoes.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/24.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DYPotoes : NSObject
/**
 *      "images":[
 {
 "id":7218405,
 "image":"http://img31.mtime.cn/pi/2016/05/04/190058.70605821_1000X1000.jpg",
 "type":1
 },
 */
/** image url */
@property (copy, nonatomic) NSString *image;
/** type 根据type的不同，归类到对应的子栏去 */
@property (assign, nonatomic) NSInteger type;

@end
