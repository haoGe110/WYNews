//
//  CZNetworkManager.h
//  网易新闻
//
//  Created by mac on 16/11/11.
//  Copyright © 2016年 macd. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface CZNetworkManager : AFHTTPSessionManager

// 全局访问点
+ (instancetype)sharedManager;

// 加载网易新闻内容
- (void)newsListWithChannel:(NSString *)channel start:(NSInteger)start completion:(void(^)(NSArray * array, NSError * error))completion;
@end
