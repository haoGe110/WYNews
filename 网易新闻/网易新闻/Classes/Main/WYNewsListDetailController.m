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

@interface WYNewsListDetailController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@property(nonatomic,weak)UIPageViewController *pageViewController;

/*
    定义一个属性来记录分页控制器视图的滚动视图,已达到获取contentOffset的变化
 */
@property(nonatomic,weak)UIScrollView * pageScroll;

/*
 当前显示的列表控制器
 */
@property(nonatomic,weak)WYNewsListViewController * currentListVC;

/*
 将要显示的列表控制器
 */
@property(nonatomic,weak)WYNewsListViewController * nextListVC;

/*
    频道视图,控制器通过它来给频道视图传值
 */
@property(nonatomic,weak)WYChanelView * chanelView;
@end

@implementation WYNewsListDetailController
{
    NSArray <WYchanelModel *> * _chanelList;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 1.先加载频道数据
    _chanelList = [WYchanelModel chanelModel];
//    NSLog(@"%@",_chanelList);
    
    // 2.搭建主控制器的界面
    [self setUIup];

    // 3.将频道数据传递给频道视图
    _chanelView.chanelModel = _chanelList;
    
    
}

- (void)setUIup
{
    self.view.backgroundColor = [UIColor brownColor];
    
    // 0. 取消自动调整滚动视图间距
    self.automaticallyAdjustsScrollViewInsets = NO;

    WYChanelView * cv = [WYChanelView chanelView];
    
    [self.view addSubview:cv];
    [cv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(38);
    }];
    _chanelView = cv;
    
    [cv addTarget:self action:@selector(selectedLabel:) forControlEvents:UIControlEventValueChanged];
    [self setPageController];
}

// 添加分页控制器
- (void)setPageController
{
    // 1. 创建分页控制器,指定样式 和 方向
    UIPageViewController *pc = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    // 2. 设置分页控制器的`子控制器（新闻列表控制器）`
    WYNewsListViewController *vc = [[WYNewsListViewController alloc]initWithChanelID:_chanelList[0].tid index:0];
    
//    _currentListVC = vc;
    
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

    pc.dataSource = self;
    pc.delegate = self;
    _pageViewController = pc;
    
    if ([pc.view.subviews[0] isKindOfClass:[UIScrollView class]]) {
        _pageScroll = pc.view.subviews[0];
    }}


/*
    注意:cv是频道视图,在频道视图里面,频道视图有一个_selecIndex属性来记录选中标签的tag值,所以这里cv.selecIndex值 就代表选中标签 在模型数组中的位置,也就可以获得tid
 
 */
- (void)selectedLabel:(WYChanelView *)cv
{
    
    if (_currentListVC.chanelIndex == cv.selecIndex) {
        return;
    }
    // 1.设置选中标签的显示比例(变大)
    [_chanelView chanelLabelWithIndex:cv.selecIndex scale:1.0];
    
    // 2.设置之前标签的显示比例(变小)
//    NSLog(@"********** %@,%@,,,%@",_pageViewController.childViewControllers,_pageViewController.childViewControllers[1].chanelIndex,_currentListVC);
    
    NSLog(@" 上一个 控制器是 %ld", _currentListVC.chanelIndex);
    [_chanelView chanelLabelWithIndex:_currentListVC.chanelIndex scale:0];

    WYNewsListViewController * vc = [[WYNewsListViewController alloc]initWithChanelID:_chanelList[cv.selecIndex].tid index:cv.selecIndex];
    
    UIPageViewControllerNavigationDirection  dir;
    if (cv.selecIndex < _currentListVC.chanelIndex) {
        dir = UIPageViewControllerNavigationDirectionReverse;
    }else{
        dir = UIPageViewControllerNavigationDirectionForward;
    }
    
    [_pageViewController setViewControllers:@[vc] direction:dir animated:YES completion:nil];
    
   _currentListVC = vc ;

}

#pragma mark -------- pageViewController 的代理方法

// 将要展现一个控制器的时候,调用此方法
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<WYNewsListViewController *> *)pendingViewControllers
{
    _currentListVC = pageViewController.viewControllers[0];
    _nextListVC = pendingViewControllers[0];
    
//    NSLog(@"当前控制器编号是  %ld",_currentListVC.chanelIndex);
//    NSLog(@"下一个控制器编号是  %ld",_nextListVC.chanelIndex);

//    [_pageScroll addObserver:self forKeyPath:@"contentOffset" options:0 context:NULL];
    [_pageScroll addObserver:self forKeyPath:@"contentOffset" options:0 context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    CGFloat offsetX = ABS(_pageScroll.contentOffset.x - 375);
    
//    NSLog(@"====> %f",offsetX);
    CGFloat scale = offsetX / 375;
    
//    if (scale >= 0.5) {
    
        [_chanelView chanelLabelWithIndex:_currentListVC.chanelIndex scale:1-scale];
        [_chanelView chanelLabelWithIndex:_nextListVC.chanelIndex scale:scale];
    // 根据索引调整频道标签的比例
}


// 完成展现一个控制器的时候,调用次方法
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    [_pageScroll removeObserver:self forKeyPath:@"contentOffset" context:NULL];
}


#pragma mark ----- 实现数据源方法,要注意更改当前控制器的类

// 返回前一个控制器
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(WYNewsListViewController *)viewController
{
    _currentListVC = viewController;
    NSLog(@"------->>>> %ld",_currentListVC.chanelIndex);

    NSInteger idx = viewController.chanelIndex;
    idx--;
    if (idx < 0) {
        NSLog(@"这已经是最后一个控制器了");
        return nil;
    }
    
    WYNewsListViewController * vc = [[WYNewsListViewController alloc]initWithChanelID:_chanelList[idx].tid index:idx];
    return vc;
}

// 返回后一个控制器
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(WYNewsListViewController *)viewController
{
    _currentListVC = viewController;
    NSLog(@"+++++++>>>> %ld",_currentListVC.chanelIndex);
    NSInteger idx = viewController.chanelIndex;
    idx++;
    if (idx >= _chanelList.count) {
        NSLog(@"这已经是最后一个控制器了");
        return nil;
    }
    
    WYNewsListViewController * vc = [[WYNewsListViewController alloc]initWithChanelID:_chanelList[idx].tid index:idx];
    return vc;

}
@end

















