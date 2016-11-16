//
//  WYChanelLabel.m
//  网易新闻
//
//  Created by mac on 16/11/13.
//  Copyright © 2016年 macd. All rights reserved.
//

#import "WYChanelLabel.h"

#define selectedSize 18
#define normalSize 14
@implementation WYChanelLabel

+ (instancetype)chanelLabeiWithTitle:(NSString *)title
{
    //1. 根据标签创建一个label
    WYChanelLabel * l = [self cz_labelWithText:title fontSize:selectedSize color:[UIColor blackColor]];
    
    l.userInteractionEnabled = YES;
    //2. 设置居中对齐
    l.textAlignment = NSTextAlignmentCenter;
    
    //3. 设置小字体
    //l.font = [UIFont systemFontOfSize:normalSize];
    
//    l.userInteractionEnabled = YES;
    //4. 返回标签
    return l;
    
}

@end

























