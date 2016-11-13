//
//  WYNewsListDetailController.m
//  网易新闻
//
//  Created by mac on 16/11/13.
//  Copyright © 2016年 macd. All rights reserved.
//

#import "WYNewsListDetailController.h"
#import "WYChanelView.h"


@interface WYNewsListDetailController ()

@end

@implementation WYNewsListDetailController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUIup];
}

- (void)setUIup
{
    self.view.backgroundColor = [UIColor brownColor];
    WYChanelView * cv = [WYChanelView chanelView];
    
    [self.view addSubview:cv];
    [cv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(38);
    }];
}


@end

















