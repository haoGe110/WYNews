//
//  CZNetworkManager.m
//  网易新闻
//
//  Created by mac on 16/11/11.
//  Copyright © 2016年 macd. All rights reserved.
//

#import "CZNetworkManager.h"

@implementation CZNetworkManager

+ (instancetype)sharedManager
{
    static CZNetworkManager * instance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,^{
    
        NSURL * baseUrl = [NSURL URLWithString:@"http://c.m.163.com/nc/article/"];
        instance = [[self alloc]initWithBaseURL:baseUrl];
       
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    });
    
    return instance;
}

//  封装AFN;
- (void)GETRequest:(NSString *)URLString parameters:(NSDictionary *)parameters completion:(void(^)(id json, NSError *error))completion{

    [self GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        completion(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil,error);
    }];
}

- (void)newsListWithChannel:(NSString *)channel start:(NSInteger)start completion:(void (^)(NSArray *, NSError *))completion
{
    NSString * string = [NSString stringWithFormat:@"list/%@/%zd-20.html",channel,start];
    
    [self GETRequest:string parameters:nil completion:^(id json, NSError *error) {
        
        NSArray * array = json[channel];
        completion(array,error);
    }];
}
@end





















