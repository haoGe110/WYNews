/*
  问题1. UINavigationController 和 UITabBarController的关系.
 
 */

#import "WYMainController.h"

@interface WYMainController ()

@end

@implementation WYMainController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addChildViewControllers];
}

- (void)addChildViewControllers
{
    // 数组包装UITabBarController的所有子控制器的信息
    NSArray *array = @[
                       @{@"clsName": @"WYNewsListDetailController", @"title": @"新闻", @"imageName": @"news"},
                       @{@"clsName": @"UIViewController", @"title": @"阅读", @"imageName": @"reader"},
                       @{@"clsName": @"UIViewController", @"title": @"视频", @"imageName": @"media"},
                       @{@"clsName": @"UIViewController", @"title": @"话题", @"imageName": @"bar"},
                       @{@"clsName": @"UIViewController", @"title": @"我", @"imageName": @"me"},
                       ];
    
    NSMutableArray * marr = [NSMutableArray array];
    
    
    // 遍历数组,将每个控制器添加到可变数组
    for (NSDictionary * dict in array) {
        [marr addObject:[self childViewControllerWithDict:dict]];
    }
    
    // 设置UITabBarController 的子控制器
    self.viewControllers = marr.copy;
}

// 创建每一个子控制器
- (UIViewController *)childViewControllerWithDict:(NSDictionary *)dict
{
    // 1. 创建子控制器
    NSString * str = dict[@"clsName"];
    Class  cls = NSClassFromString(str);
    
    NSAssert(cls != nil, @"传入类名错误");
    
    UIViewController * vc = [cls new];
    
    // 2. 设置子控制器的标题
    NSString * title = dict[@"title"];
    vc.title = title;
    
    
    // 3. 设置子控制器的图片
    NSString * norImage = [NSString stringWithFormat:@"tabbar_icon_%@_normal", dict[@"imageName"]];
    vc.tabBarItem.image = [UIImage imageNamed:norImage];
    
    NSString *imageNameHL = [NSString stringWithFormat:@"tabbar_icon_%@_highlight", dict[@"imageName"]];
    // 设置了一个选中状态图片的渲染模式
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:imageNameHL] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 4. 添加导航控制器
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];
   
    return nav;
}

@end





















