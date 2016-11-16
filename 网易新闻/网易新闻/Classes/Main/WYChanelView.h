//
//  WYChanelView.h
//  网易新闻
//
//  Created by mac on 16/11/13.
//  Copyright © 2016年 macd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYchanelModel.h"
@interface WYChanelView : UIControl

// 频道模型数组
@property(nonatomic,strong)NSArray <WYchanelModel *> * chanelModel;

//  选中的标签索引
@property(nonatomic,assign,readonly)NSInteger selecIndex;


// 创建视图类方法,方便控制器加载;
+ (instancetype)chanelView;
@end
