//
//  WYNormalCell.h
//  网易新闻
//
//  Created by mac on 16/11/11.
//  Copyright © 2016年 macd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYNormalCell : UITableViewCell
// 首张图片
@property (weak, nonatomic) IBOutlet UIImageView *imagView;
// 标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

// 来源
@property (weak, nonatomic) IBOutlet UILabel *sourcceLabel;

// 跟帖数量
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

// 多图集合
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *extraIcon;
@end
