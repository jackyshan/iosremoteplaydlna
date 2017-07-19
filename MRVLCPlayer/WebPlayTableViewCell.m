//
//  SearchDLNATableViewCell.m
//  MRVLCPlayer
//
//  Created by jackyshan on 2017/7/12.
//  Copyright © 2017年 Alloc. All rights reserved.
//

#import "WebPlayTableViewCell.h"

@implementation WebPlayTableViewCell


#pragma mark - 一、生命周期

#pragma mark 1 初始化

+ (instancetype)view
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self commontInit];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self commontInit];
}

- (void)commontInit
{
}

#pragma mark 2 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - 二、代理


#pragma mark - 三、事件处理

#pragma mark - 四、私有方法

#pragma mark - 五、外部接口

#pragma mark - 六 setter and getter

#pragma mark 1 setter


#pragma mark 2 getter


@end
