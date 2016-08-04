//
//  DYEventsView.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/24.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DYEvents;

@interface DYEventsView : UIView

/** DYEvents模型 */
@property (strong, nonatomic) DYEvents *event;

+ (instancetype)eventsView;

@end
