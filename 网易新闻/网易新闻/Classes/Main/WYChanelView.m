//
//  WYChanelView.m
//  网易新闻
//
//  Created by mac on 16/11/13.
//  Copyright © 2016年 macd. All rights reserved.
//

#import "WYChanelView.h"
#import "WYChanelLabel.h"

@interface WYChanelView()


@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
@implementation WYChanelView

+ (instancetype)chanelView;

{
    UINib * nib = [UINib nibWithNibName:@"WYChanelView" bundle:nil];
    return [nib instantiateWithOwner:nil options:nil].lastObject;

}
- (void)setChanelModel:(NSArray<WYchanelModel *> *)chanelModel
{
    _chanelModel = chanelModel;
    
    CGFloat x = 45;
    CGFloat height = 38;
    CGFloat margin = 8;
    
    NSInteger index = 0;
    for (WYchanelModel * model in chanelModel) {
        WYChanelLabel * l = [WYChanelLabel chanelLabeiWithTitle:model.tname];

        l.frame = CGRectMake(x, 0, l.bounds.size.width, height);
        x += l.bounds.size.width + margin;
        
        // 添加点击label的手势
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLabel:)];
        
        [l addGestureRecognizer:tap];
        
        l.tag = index;
        index++;
        [_scrollView addSubview:l];

    }
    _scrollView.contentSize = CGSizeMake(x, height);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    
    [self chanelLabelWithIndex:0 scale:1];

}

// 实现手势的监听方法
- (void)tapLabel:(UITapGestureRecognizer *)recognizer
{
    UILabel * l = (WYChanelLabel *)recognizer.view;
    
    _selecIndex = l.tag;
    // 发送点击事件
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    

}

- (void)chanelLabelWithIndex:(NSInteger)index scale:(float)scale
{
    WYChanelLabel * l = _scrollView.subviews[index];
    
    l.scale = scale;
}
@end












