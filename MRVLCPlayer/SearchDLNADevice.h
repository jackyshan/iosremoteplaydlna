//
//  SearchDLNADevice.h
//  MRVLCPlayer
//
//  Created by jackyshan on 2017/7/12.
//  Copyright © 2017年 Alloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchDLNADevice : UIView

@property (nonatomic,strong,nonnull) NSURL *mediaURL;

@property (nonatomic,strong) void (^ _Nullable dlnaPlayBlock)();


- (void)show;

- (void)dismiss;

+ (instancetype _Nullable )view;

@end
