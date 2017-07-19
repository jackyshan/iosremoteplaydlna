//
//  ZM_SearchDevice.m
//  PlatinumDemo
//
//  Created by GVS on 16/11/24.
//  Copyright © 2016年 GVS. All rights reserved.
//

#import "ZM_SingletonControlModel.h"

@implementation ZM_SingletonControlModel
+(ZM_SingletonControlModel *)sharedInstance
{
    static ZM_SingletonControlModel * instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ZM_SingletonControlModel alloc] init];
        
    });
    return instance;
}
-(instancetype)init
{
    if (self = [super init]) {
        _DMRControl = [[ZM_DMRControl alloc] init];
        [_DMRControl start];
        
    }
    return self;
}

@end
