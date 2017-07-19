//
//  ZM_DMRControlModel.m
//  PlatinumDemo
//
//  Created by GVS on 16/11/24.
//  Copyright © 2016年 GVS. All rights reserved.
//

#import "ZM_DMRControl.h"
#import "PltMicroMediaController.h"
#import <Platinum/Platinum.h>
@implementation ZM_DMRControl
{
    PLT_UPnP * upnp;
    PLT_MicroMediaController * controller;
}
/***************************
 *
 * 媒体控制器相关(DMC)
 ***************************/

-(id)init
{
    if (self = [super init]) {
        upnp = new PLT_UPnP();
        PLT_CtrlPointReference ctrlPoint(new PLT_CtrlPoint());
        upnp->AddCtrlPoint(ctrlPoint);
        controller = new PLT_MicroMediaController(ctrlPoint,self);
        
    }
    return self;
}
-(void)dealloc
{
    delete upnp;
    delete controller;
}
/**
 启动媒体控制器
 */
-(void)start
{
    if (!upnp->IsRunning()) {
        upnp->Start();
    }else{
        NSLog(@"UPnP Service is starting!");
    }
}

/**
 重启媒体控制器
 */
-(void)restart
{
    if (upnp->IsRunning()) {
        upnp->Stop();
    }
    upnp->Start();
}


/**
 停止
 */
-(void)stop
{
    if (upnp->IsRunning() && upnp != NULL) {
        upnp->Stop();
    }
}
-(BOOL)isRunning
{
    if (upnp->IsRunning()) {
        return YES;
    }else{
        return NO;
    }
}

/*****************************
 *
 * 媒体服务器相关(DMS)
 *****************************/

/**
 获取附近媒体服务器
 
 */
-(NSArray <ZM_ServerDeviceModel *> *)getActiveServers
{
    return 0;
}


/**
 根据uuid选择一个媒体服务器
 
 @param uuid 传入uuid
 */
-(void)chooseServerWithUUID:(NSString *)uuid
{
    
}


/**
 获取当前的媒体服务器
 
 @return 返回
 */
-(ZM_ServerDeviceModel *)getCurrentServer
{
    return nil;
}


/***************************
 *
 *媒体渲染器(DMR)
 ***************************/


/**
 获取附近媒体渲染器(DMR)
 
 @return 返回数组
 */
-(NSArray <ZM_RenderDeviceModel *> *)getActiveRenders
{
    NSMutableArray<ZM_RenderDeviceModel *> * renderArray = [NSMutableArray array];
    const PLT_StringMap rendersNameTable = controller->getMediaRenderersNameTable();
    NPT_List<PLT_StringMapEntry *>::Iterator entry = rendersNameTable.GetEntries().GetFirstItem();
    while (entry) {
        ZM_RenderDeviceModel * renderModel = [[ZM_RenderDeviceModel alloc] init];
        renderModel.name = [NSString stringWithUTF8String:(const char *)(*entry)->GetValue()];
        renderModel.uuid = [NSString stringWithUTF8String:(const char *)(*entry)->GetKey()];
        
        [renderArray addObject:renderModel];
        ++entry;
    }
    return renderArray;
}

/**
 使用uuid选择一个媒体渲染器
 
 @param uuid 传入uuid
 */
-(void)chooseRenderWithUUID:(NSString *)uuid
{
    if (![uuid isEqualToString:@""]) {
         controller -> chooseMediaRenderer([uuid UTF8String]);
    }else{
        NSLog(@"UUID is nil when CHOOSE Render !");
        
    }
}


/**
 获取当前的媒体渲染器
 
 @return 返回
 */
-(ZM_RenderDeviceModel *)getCurrentRender
{
    PLT_DeviceDataReference device = controller->getCurrentMediaRenderer();
    if (!device.IsNull()) {
        NSString * name = [NSString stringWithUTF8String:device->GetFriendlyName()];
        NSString * uuid = [NSString stringWithUTF8String:device->GetUUID()];
        NSString * manufacturer = [NSString stringWithUTF8String:device->m_Manufacturer];
        NSString * modelName = [NSString stringWithUTF8String:device->m_ModelName];
        NSString * modelNumber = [NSString stringWithUTF8String:device->m_ModelNumber];
        NSString * serialNumber = [NSString stringWithUTF8String:device->m_SerialNumber];
        NSString * descriptionURL = [NSString stringWithUTF8String:device->GetDescriptionUrl()];
        ZM_RenderDeviceModel * renderDevice = [[ZM_RenderDeviceModel alloc] initWithName:name UUID:uuid Manufacturer:manufacturer ModelName:modelName ModelNumber:modelNumber SerialNumber:serialNumber DescriptionURL:descriptionURL];
        return renderDevice;
    }else{
        NSLog(@"Render device is nil in %s",__FUNCTION__);
        return nil;
    }
    
    
}

/**
 播放
 */
-(void)renderPlay
{
    controller->setRendererPlay();
}

/**
 暂停
 */
-(void)renderPause
{
    controller->setRendererPause();
}


/**
 媒体渲染器停止
 */
-(void)renderStop
{
    controller->setRendererStop();
}


/**
 下一首／下一集
 */
-(void)renderNext
{
    controller->setRendererNext();
}


/**
 上一首／上一集
 */
-(void)renderPrevious
{
    controller->setRendererPrevious();
}

/**
 设置当前播放URI
 
 @param uriStr URI
 @param didl DIDL
 */
-(void)renderSetAVTransportWithURI:(NSString *)uriStr metaData:(NSString *)didl
{
    if (didl == nil) {
        didl = @"";
    }
    controller->setRendererAVTransportURI([uriStr UTF8String], [didl UTF8String]);
}

/**
 设置Next播放URI
 
 @param uriStr URI
 */
-(void)renderSetNextAVTransportWithURI:(NSString *)uriStr {
    controller->setRendererNextAVTransportURI([uriStr UTF8String]);
}

- (BOOL)canRendererSetNextURI {
    return controller->canRendererSetNextURI();
}

/**
 设置音量
 
 @param volume 传入音量
 */
-(void)renderSetVolume:(int)volume
{
    if (volume <= 0) {
        volume = 0;
    }
    if (volume >= 100) {
        volume = 100;
    }
    controller->setRendererVolume(volume);
}
-(void)renderGetVolome
{
    controller->getRendererVolume();
}

/**
 获取当前动作 OnGetCurrentTransportActionsResult
 */
-(void)getCurrentTransportAction
{
    controller->getRendererCurrentTransportActions();
}


/**
 获取当前信息 回调 OnGetTransportInfoResult
 */
-(void)getTransportInfo
{
    controller->getRendererTransportInfo();
}
@end
