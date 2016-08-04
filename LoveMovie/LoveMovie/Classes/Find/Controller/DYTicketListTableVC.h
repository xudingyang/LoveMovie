//
//  DYTicketListTableVC.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/20.
//  Copyright © 2016年 许定阳. All rights reserved.
//  单个地区的票房榜，DYGlobalTicketListVC的子控制器

#import <UIKit/UIKit.h>

@interface DYTicketListTableVC : UITableViewController

/** 票房地区 */
@property (assign, nonatomic) DYAreaNumber areaNumber;

@end
