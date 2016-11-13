//
//  WYNormalCell.m
//  网易新闻
//
//  Created by mac on 16/11/11.
//  Copyright © 2016年 macd. All rights reserved.
//

#import "WYNormalCell.h"
#import <UIImageView+WebCache.h>


@implementation WYNormalCell

- (void)setListModel:(WYNewsModel *)listModel
{
    _titleLabel.text =listModel.title;
    _sourcceLabel.text = listModel.source;
    _numLabel.text = @(listModel.replyCount).description;
    
    NSURL *imageURL = [NSURL URLWithString:listModel.imgsrc];
    [_imagView sd_setImageWithURL:imageURL];
    
    // 设置多图 － 如果没有不会进入循环
    NSInteger idx = 0;
    for (NSDictionary *dict in listModel.imgextra) {
        
        // 1. 获取url字符串
        NSURL *url = [NSURL URLWithString:dict[@"imgsrc"]];
        
        // 2. 设置图像
        UIImageView *iv = _extraIcon[idx++];
        
        [iv sd_setImageWithURL:url];
        
    }

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
