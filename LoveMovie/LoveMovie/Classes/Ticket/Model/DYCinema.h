//
//  DYCinema.h
//  LoveMovie
//
//  Created by xudingyang on 16/6/2.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DYCinema : NSObject

/** cinemaId */
@property (assign, nonatomic) NSInteger cinemaId;
/** cinameName */
@property (copy, nonatomic) NSString *cinameName;
/** address */
@property (copy, nonatomic) NSString *address;
/** minPrice */
@property (assign, nonatomic) NSInteger minPrice;
/** longitude经度 */
@property (assign, nonatomic) CGFloat longitude;
/** latitude纬度 */
@property (assign, nonatomic) CGFloat latitude;

@end
