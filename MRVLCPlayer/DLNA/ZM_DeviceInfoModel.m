//
//  ZM_DeviceInfoModel.m
//  PlatinumDemo
//
//  Created by GVS on 16/11/24.
//  Copyright © 2016年 GVS. All rights reserved.
//

#import "ZM_DeviceInfoModel.h"

@implementation ZM_DeviceInfoModel
-(instancetype)initWithName:(NSString *)name andUUID:(NSString *)uuid
{
    if (self = [super init]) {
        self.name = name;
        self.uuid = uuid;
    }
    return self;
}
@end

@implementation ZM_ServerDeviceModel


@end

@implementation ZM_RenderDeviceModel

-(instancetype)initWithName:(NSString *)name UUID:(NSString *)uuid Manufacturer:(NSString *)manufacturer ModelName:(NSString *)modelName ModelNumber:(NSString *)modelNumber SerialNumber:(NSString *)serialNumber DescriptionURL:(NSString *)descriptionURL
{
    if (self = [super init]) {
        self.manufacturer = manufacturer;
        self.modelName = modelName;
        self.modelNumber = modelNumber;
        self.serialNumber = serialNumber;
        self.descriptionURL = descriptionURL;
    }
    return self;
}

@end
