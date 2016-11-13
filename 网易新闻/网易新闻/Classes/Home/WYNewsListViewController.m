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

static  NSString * normalId = @"normalId";
static  NSString * ExtraId = @"ExtraId";
static  NSString * BigImageId = @"BigImageId";
static  NSString * HeaderId = @"HeaderId";


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
    [tv registerNib:[UINib nibWithNibName:@"WYNormalCell" bundle:nil] forCellReuseIdentifier:normalId];
    [tv registerNib:[UINib nibWithNibName:@"WYNewsExtraImagesCell" bundle:nil] forCellReuseIdentifier:ExtraId];
    [tv registerNib:[UINib nibWithNibName:@"WYNewsBigImageCell" bundle:nil] forCellReuseIdentifier:BigImageId];
    [tv registerNib:[UINib nibWithNibName:@"WYNewsListHeader" bundle:nil] forCellReuseIdentifier:HeaderId];

    
    
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
    WYNewsModel * model = _newsList[indexPath.row];
    
    NSString * cellId;
    if (model.hasHead) {
        cellId = HeaderId;
    } else if (model.imgType) {
        cellId = BigImageId;
    } else if (model.imgextra.count > 0) {
        cellId = ExtraId;
    } else {
        cellId = normalId;
    }
    
    WYNormalCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    cell.listModel = model;
    return cell;
}
@end
















