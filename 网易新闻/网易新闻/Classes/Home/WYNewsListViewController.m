//
//  WYNewsListViewController.m
//  网易新闻
//
//  Created by mac on 16/11/7.
//  Copyright © 2016年 macd. All rights reserved.
//

#import "WYNewsListViewController.h"

static  NSString * cellId = @"cellId";
@interface WYNewsListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,weak)UITableView * tableView;
@end

@implementation WYNewsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUIup];
}
- (void)setUIup
{
    self.view.backgroundColor = [UIColor brownColor];
    
    UITableView * tv = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:tv];
    
    [tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    // 注册原型cell
    [tv registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    
    tv.delegate = self;
    tv.dataSource = self;
    
    // 记录
    _tableView = tv;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.textLabel.text = @(indexPath.row).description;
    
    return cell;
}
@end
















