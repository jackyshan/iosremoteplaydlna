//
//  ZM_SearchDevice.h
//  PlatinumDemo
//
//  Created by GVS on 16/11/24.
//  Copyright © 2016年 GVS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZM_DMRControl.h"
/**
 用来启动服务的单例类
 */
@interface ZM_SingletonControlModel : NSObject
@property (nonatomic, strong)ZM_DMRControl * DMRControl;
+(ZM_SingletonControlModel *)sharedInstance;
@end
