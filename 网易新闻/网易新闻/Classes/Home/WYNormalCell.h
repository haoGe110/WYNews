//
//  WYNormalCell.h
//  网易新闻
//
//  Created by mac on 16/11/11.
//  Copyright © 2016年 macd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYNormalCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imagView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourcceLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@end
