//
//  WYNewsListDetailController.m
//  网易新闻
//
//  Created by mac on 16/11/13.
//  Copyright © 2016年 macd. All rights reserved.
//

#import "WYNewsListDetailController.h"
#import "WYChanelView.h"
#import "WYchanelModel.h"

@interface WYNewsListDetailController ()
@property(nonatomic,weak)WYChanelView * chanelView;
@end

@implementation WYNewsListDetailController
{
    NSArray <WYchanelModel *> * _chanelList;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUIup];
    _chanelList = [WYchanelModel chanelModel];
    NSLog(@"%@",_chanelList);
    _chanelView.chanelModel = _chanelList;

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
    _chanelView = cv;
}


@end

















