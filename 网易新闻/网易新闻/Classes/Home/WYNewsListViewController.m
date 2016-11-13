//
//  WYNewsListViewController.m
//  网易新闻
//
//  Created by mac on 16/11/7.
//  Copyright © 2016年 macd. All rights reserved.
//

#import "WYNewsListViewController.h"
#import "WYNewsModel.h"
#import "WYNormalCell.h"
#import <UIImageView+WebCache.h>

static  NSString * cellId = @"cellId";
@interface WYNewsListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)NSArray <WYNewsModel *>* newsList;
@end

@implementation WYNewsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUIup];
    [self loadData];
}

- (void)loadData
{
    [[CZNetworkManager sharedManager] newsListWithChannel:@"T1348649079062" start:0 completion:^(NSArray *array, NSError *error) {
        
        NSLog(@"%@",array);
        
        NSMutableArray * marr = [NSMutableArray array];
        for (NSDictionary * dict in array) {
            
            WYNewsModel * model = [[WYNewsModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            
            [marr addObject:model];
        }
        
        _newsList = marr.copy;
        [self.tableView reloadData];
    }];
}

- (void)setUIup
{
    self.view.backgroundColor = [UIColor brownColor];
    
    UITableView * tv = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    tv.estimatedRowHeight = 100;
    tv.rowHeight = UITableViewAutomaticDimension;

    [self.view addSubview:tv];
    
    [tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    // 注册原型cell
    [tv registerNib:[UINib nibWithNibName:@"WYNormalCell" bundle:nil] forCellReuseIdentifier:cellId];
    
    tv.delegate = self;
    tv.dataSource = self;
    
    // 记录
    _tableView = tv;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _newsList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WYNormalCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    WYNewsModel * model = _newsList[indexPath.row];
    cell.titleLabel.text =model.title;
    cell.sourcceLabel.text = model.source;
    cell.numLabel.text = @(model.replyCount).description;

    NSURL * url = [NSURL URLWithString:model.imgsrc];
    
    [cell.imagView sd_setImageWithURL:url];
    return cell;
}
@end
















