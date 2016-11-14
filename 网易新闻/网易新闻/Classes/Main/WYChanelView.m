//
//  WYChanelView.m
//  网易新闻
//
//  Created by mac on 16/11/13.
//  Copyright © 2016年 macd. All rights reserved.
//

#import "WYChanelView.h"
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
    for (WYchanelModel * model in chanelModel) {
        UILabel * l = [UILabel cz_labelWithText:model.tname fontSize:14 color:[UIColor redColor]];

        l.frame = CGRectMake(x, 0, l.bounds.size.width, height);
        x += l.bounds.size.width + margin;
        [_scrollView addSubview:l];

    }
    
}

@end












