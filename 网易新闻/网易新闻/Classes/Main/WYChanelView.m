//
//  WYChanelView.m
//  网易新闻
//
//  Created by mac on 16/11/13.
//  Copyright © 2016年 macd. All rights reserved.
//

#import "WYChanelView.h"

@implementation WYChanelView

+ (instancetype)chanelView;

{
    UINib * nib = [UINib nibWithNibName:@"WYChanelView" bundle:nil];
    return [nib instantiateWithOwner:nil options:nil].lastObject;

}
@end
