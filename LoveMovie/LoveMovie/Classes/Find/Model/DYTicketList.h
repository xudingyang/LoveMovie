//
//  DYTicketList.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/21.
//  Copyright © 2016年 许定阳. All rights reserved.
//  票房cell的模型。排行榜cell子条

#import <Foundation/Foundation.h>
@class DYMovieInTicketList;
@class DYHeaderInTicketList;

@interface DYTicketList : NSObject

/**  就一个字典，没有字典数组
 {
 "topList":Object{...},
 "movies":Array[10],
 "totalCount":10,
 "pageCount":1,
 "nextTopList":{
 "toplistId":2016,
 "toplistItemType":-1,
 "toplistType":1
 },
 "previousTopList":{
 "toplistId":2015,
 "toplistItemType":-1,
 "toplistType":1
 }
 }
 */

/** movies */
@property (strong, nonatomic) NSArray *movies;

/** header */
@property (strong, nonatomic) DYHeaderInTicketList *header;

/*************************
 *  top100的模型
 *************************/
/** pageCount根据这个加载下一页 */
@property (assign, nonatomic) NSInteger pageCount;
/** totalCount总条数 */
@property (assign, nonatomic) NSInteger totalCount;

//{
//    
//    "topList":{
//        "id":1349,
//        "name":"英国电影学会影史LGBT电影30佳",
//        "summary":"《卡罗尔》荣登榜首"
//    },
//    "movies":Array[20],
//    "totalCount":30,  //总共30条数据
//    "pageCount":2,    //分两页请求
//    "nextTopList":{
//        "toplistId":1342,
//        "toplistItemType":0,
//        "toplistType":0
//    },
//    "previousTopList":{
//        "toplistId":2018,
//        "toplistItemType":-1,
//        "toplistType":1
//    }
//}
@end
