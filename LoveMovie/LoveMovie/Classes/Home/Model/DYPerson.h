//
//  DYPerson.h
//  LoveMovie
//
//  Created by xudingyang on 16/5/24.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DYPerson : NSObject
/**
 *                 {
 "id":903229,
 "name":"安东尼·罗素",
 "nameEn":"Anthony Russo",
 "image":"http://img31.mtime.cn/ph/2014/03/14/152324.64956342_1280X720X2.jpg"
 },

 {
 "id":911885,
 "name":"克里斯·埃文斯",
 "nameEn":"Chris Evans",
 "image":"http://img31.mtime.cn/ph/2014/04/30/114119.90484279_1280X720X2.jpg",
 "personate":"史蒂夫·罗杰斯 / 美国队长",
 "personateCn":"史蒂夫·罗杰斯 / 美国队长",
 "personateEn":"Steve Rogers / Captain America",
 "roleCover":"http://img31.mtime.cn/mg/2016/04/13/165134.89624906_120X120X4.jpg"
 },
 */
/** name 中文名 */
@property (copy, nonatomic) NSString *name;
/** nameEn 英文名 */
@property (copy, nonatomic) NSString *nameEn;
/** image url */
@property (copy, nonatomic) NSString *image;
/** 戏中头像url */
@property (copy, nonatomic) NSString *roleCover;
/** 戏中角色名 */
@property (copy, nonatomic) NSString *personate;


/**
 *  辅助属性
 */
/** personType */
@property (copy, nonatomic) NSString *personType;
@end
