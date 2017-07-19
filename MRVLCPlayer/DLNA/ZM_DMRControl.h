//
//  ZM_DMRControlModel.h
//  PlatinumDemo
//
//  Created by GVS on 16/11/24.
//  Copyright © 2016年 GVS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZM_EventParamsResponse.h"
#import "ZM_DeviceInfoModel.h"
//#import "PltMicroMediaController.h"
@protocol ZM_DMRProtocolDelegate <NSObject>

@optional
/**
 发现并添加DMR(媒体渲染器)
 */
-(void)onDMRAdded;



/**
 移除DMR
 */
-(void)onDMRRemoved;


/**
 无DMR被选中
 */
-(void)noDMRBeSelected;



-(void)getCurrentAVTransportActionResponse:(ZM_CurrentAVTransportActionResponse *)response;

-(void)getTransportInfoResponse:(ZM_TransportInfoResponse *)response;

-(void)previousResponse:(ZM_EventResultResponse *)response;

-(void)nextResponse:(ZM_EventResultResponse *)response;

-(void)DMRStateViriablesChanged:(NSArray <ZM_EventParamsResponse *> *)response;

-(void)playResponse:(ZM_EventResultResponse *)response;

-(void)pasuseResponse:(ZM_EventResultResponse *)response;

-(void)stopResponse:(ZM_EventResultResponse *)response;

-(void)setAVTransponrtResponse:(ZM_EventResultResponse *)response;

-(void)setVolumeResponse:(ZM_EventResultResponse *)response;

-(void)getVolumeResponse:(ZM_VolumResponse *)response;


@end

@interface ZM_DMRControl : NSObject

@property (nonatomic, strong)id <ZM_DMRProtocolDelegate> delegate;
/***************************
 *
 * 媒体控制器相关(DMC)
 ***************************/

/**
 启动媒体控制器
 */
-(void)start;


/**
 重启媒体控制器
 */
-(void)restart;


/**
 停止
 */
-(void)stop;

-(BOOL)isRunning;
/*****************************
 *
 * 媒体服务器相关(DMS)
 *****************************/

/**
 获取附近媒体服务器

 */
-(NSArray <ZM_ServerDeviceModel *> *)getActiveServers;


/**
 根据uuid选择一个媒体服务器

 @param uuid uuid
 */
-(void)chooseServerWithUUID:(NSString *)uuid;


/**
 获取当前的媒体服务器

 @return 返回
 */
-(ZM_ServerDeviceModel *)getCurrentServer;


/***************************
 *
 *媒体渲染器(DMR)
 ***************************/


/**
    获取附近媒体渲染器(DMR)

 @return 返回数组
 */
-(NSArray <ZM_RenderDeviceModel *> *)getActiveRenders;

/**
 使用uuid选择一个媒体渲染器

 @param uuid 传入uuid
 */
-(void)chooseRenderWithUUID:(NSString *)uuid;


/**
 获取当前的媒体渲染器

 @return <#return value description#>
 */
-(ZM_RenderDeviceModel *)getCurrentRender;

/**
 播放
 */
-(void)renderPlay;


/**
 暂停
 */
-(void)renderPause;


/**
 媒体渲染器停止
 */
-(void)renderStop;


/**
 下一首／下一集
 */
-(void)renderNext;


/**
 上一首／上一集
 */
-(void)renderPrevious;

/**
 设置当前播放URI

 @param uriStr URI
 @param didl DIDL
 */
-(void)renderSetAVTransportWithURI:(NSString *)uriStr metaData:(NSString *)didl;

/**
 设置Next播放URI
 
 @param uriStr URI
 */
-(void)renderSetNextAVTransportWithURI:(NSString *)uriStr;
- (BOOL)canRendererSetNextURI;
/**
 设置音量

 @param volume 传入音量
 */
-(void)renderSetVolume:(int)volume;


/**
 获取当前音量
 */
-(void)renderGetVolome;

/**
 获取当前动作 OnGetCurrentTransportActionsResult
 */
-(void)getCurrentTransportAction;


/**
 获取当前信息 回调 OnGetTransportInfoResult
 */
-(void)getTransportInfo;
@end
