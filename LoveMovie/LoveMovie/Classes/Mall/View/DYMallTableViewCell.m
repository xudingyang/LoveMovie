//
//  DYMallTableViewCell.m
//  LoveMovie
//
//  Created by xudingyang on 16/6/3.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYMallTableViewCell.h"
#import "DYGoodsModel.h"
#import "DYGoodsModelItem.h"
#import <UIImageView+WebCache.h>

@interface DYMallTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *typeTitle;
@property (weak, nonatomic) IBOutlet UIImageView *topImage;
@property (weak, nonatomic) IBOutlet UIImageView *firstImage;
@property (weak, nonatomic) IBOutlet UIImageView *midImage;
@property (weak, nonatomic) IBOutlet UIImageView *rightImage;
@property (weak, nonatomic) IBOutlet UILabel *firstName;
@property (weak, nonatomic) IBOutlet UILabel *midName;
@property (weak, nonatomic) IBOutlet UILabel *rightName;


@end


@implementation DYMallTableViewCell

- (void)setGoodsModel:(DYGoodsModel *)goodsModel {
    _goodsModel = goodsModel;
    self.typeTitle.text = goodsModel.name;
    [self.topImage sd_setImageWithURL:[NSURL URLWithString:goodsModel.image]];
    if (goodsModel.subList.count == 1) {
        DYGoodsModelItem *item = goodsModel.subList[0];
        [self.firstImage sd_setImageWithURL:[NSURL URLWithString:item.image]];
        self.firstName.text = item.title;
    }
    if (goodsModel.subList.count == 2) {
        DYGoodsModelItem *item = goodsModel.subList[0];
        [self.firstImage sd_setImageWithURL:[NSURL URLWithString:item.image]];
        self.firstName.text = item.title;
        
        DYGoodsModelItem *item1 = goodsModel.subList[1];
        [self.midImage sd_setImageWithURL:[NSURL URLWithString:item1.image]];
        self.midName.text = item1.title;
    }
    if (goodsModel.subList.count >= 3) {
        DYGoodsModelItem *item = goodsModel.subList[0];
        [self.firstImage sd_setImageWithURL:[NSURL URLWithString:item.image]];
        self.firstName.text = item.title;
        
        DYGoodsModelItem *item1 = goodsModel.subList[1];
        [self.midImage sd_setImageWithURL:[NSURL URLWithString:item1.image]];
        self.midName.text = item1.title;
        
        DYGoodsModelItem *item2 = goodsModel.subList[2];
        [self.rightImage sd_setImageWithURL:[NSURL URLWithString:item2.image]];
        self.rightName.text = item2.title;
    }
    
}


- (void)setFrame:(CGRect)frame {
    
    frame.size.height -= 20;
    frame.origin.y += 20;
    
    [super setFrame:frame];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
