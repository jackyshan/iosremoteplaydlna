//
//  ZM_EventParamsResponse.m
//  PlatinumDemo
//
//  Created by GVS on 16/11/24.
//  Copyright © 2016年 GVS. All rights reserved.
//

#import "ZM_EventParamsResponse.h"

@implementation ZM_EventParamsResponse
-(instancetype)initWithDeviceUUID:(NSString *)deviceUUID ServiceID:(NSString *)serviceID EventName:(NSString *)eventName EventValue:(NSString *)eventValue
{
    if (self = [super init]) {
        self.deviceUUID = deviceUUID;
        self.serviceID = serviceID;
        self.eventName = eventName;
        self.eventValue = eventValue;
    }
    return self;
}
@end

@implementation ZM_EventResultResponse

-(instancetype)initWithResult:(NSInteger)result DeviceUUID:(NSString *)deviceUUID UserData:(id)userData
{
    if (self = [super init]) {
        self.result = result;
        self.deviceUUID = deviceUUID;
        self.userData = userData;
    }
    return self;
}
@end

@implementation ZM_CurrentAVTransportActionResponse

-(instancetype)initWithResult:(NSInteger)result DeviceUUID:(NSString *)deviceUUID Actions:(NSArray<NSString *> *)actions UserData:(id)userData
{
    if (self = [super initWithResult:result DeviceUUID:deviceUUID UserData:userData]) {
        self.actions = actions;
    }
    return self;
}

@end

@implementation ZM_VolumResponse 

-(instancetype)initWithResult:(NSInteger)result DeviceUUID:(NSString *)deviceUUID UserData:(id)userData Channel:(NSString *)channel Volume:(NSInteger)volume
{
    if (self = [super initWithResult:result DeviceUUID:deviceUUID UserData:userData]) {
        self.channel = channel;
        self.volume = volume;
    }
    return self;
}

@end

@implementation ZM_TransportInfoResponse

-(NSString *)description
{
    return [NSString stringWithFormat:@"cur_transport_status:%@-cur_transport_state:%@-cur_speed:%@",self.cur_transport_status,self.cur_transport_state,self.cur_speed];
}

@end
