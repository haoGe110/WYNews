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
#import "WYNewsListViewController.h"

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
    
    [self setPageController];
}

// 添加分页控制器
- (void)setPageController
{
    // 1. 创建分页控制器,指定样式 和 方向
    UIPageViewController *pc = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    // 2. 设置分页控制器的`子控制器（新闻列表控制器）`
    WYNewsListViewController *vc = [WYNewsListViewController new];
    
    [pc setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // 3. 将分页控制器当作子控制器添加到当前控制器
    [self addChildViewController:pc];
    
    // 4. 添加视图，并且完成自动布局
    [self.view addSubview:pc.view];
    
    [pc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.chanelView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    // 5. 完成子控制器的添加
    [pc didMoveToParentViewController:self];

}
@end

















