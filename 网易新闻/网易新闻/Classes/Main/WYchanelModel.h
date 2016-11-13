//
//  WYchanelModel.h
//  网易新闻
//
//  Created by mac on 16/11/13.
//  Copyright © 2016年 macd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYchanelModel : NSObject
//  频道分类
@property(nonatomic,copy)NSString * tname;

//  频道ID
@property(nonatomic,copy)NSString * tid;

// 返回频道模型数组
+ (NSArray *)chanelModel;
@end
