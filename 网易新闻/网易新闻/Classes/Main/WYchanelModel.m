//
//  WYchanelModel.m
//  网易新闻
//
//  Created by mac on 16/11/13.
//  Copyright © 2016年 macd. All rights reserved.
//

#import "WYchanelModel.h"

@implementation WYchanelModel

- (NSString *)description
{
    return [self yy_modelDescription];
}
+ (NSArray *)chanelModel
{
    // 1.获取本地数据
    NSURL * url = [[NSBundle mainBundle]URLForResource:@"topic_news.json" withExtension:nil];
    NSData * data = [NSData dataWithContentsOfURL:url];
    
    // 2.反序列化
    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    // 3.获取需要数组
    NSArray * array = dict[@"tList"];
    
    // 4.字典转模型
    NSArray * chanelModel = [NSArray yy_modelArrayWithClass:[self class] json:array];
    
    // 5.返回模型
    return [chanelModel sortedArrayUsingComparator:^NSComparisonResult(WYchanelModel * obj1, WYchanelModel * obj2) {
        return [obj1.tid compare:obj2.tid];
    }];
}
@end
















