//
//  WYNewsListViewController.h
//  网易新闻
//
//  Created by mac on 16/11/7.
//  Copyright © 2016年 macd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYNewsListViewController : UIViewController

- (instancetype)initWithChanelID:(NSString *)chanelID index:(NSInteger)index;


// 使用频道代号 和索引创建控制器
/*
 频道代号
 */
@property(nonatomic,strong,readonly)NSString * chanelID;

/*
 频道索引
 */
@property(nonatomic,assign,readonly)NSInteger chanelIndex;

@end
