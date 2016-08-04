//
//  DYTop100HeaderView.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/21.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DYHeaderInTicketList;

@interface DYTop100HeaderView : UIView
/** DYHeaderInTicketList */
@property (strong, nonatomic) DYHeaderInTicketList *headerList;

+ (instancetype)top100HeaderView;

@end
