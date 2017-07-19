//
//  ZM_DeviceInfoModel.h
//  PlatinumDemo
//
//  Created by GVS on 16/11/24.
//  Copyright © 2016年 GVS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZM_DeviceInfoModel : NSObject
//设备uuid
@property(nonatomic, copy)NSString * uuid;
//设备名称
@property(nonatomic, copy)NSString * name;
-(instancetype)initWithName:(NSString *)name andUUID:(NSString *)uuid;
@end


@interface ZM_ServerDeviceModel : ZM_DeviceInfoModel

@end

@interface ZM_RenderDeviceModel : ZM_DeviceInfoModel
//生产商
@property (nonatomic, retain) NSString *manufacturer;
//型号名
@property (nonatomic, retain) NSString *modelName;
//型号编号
@property (nonatomic, retain) NSString *modelNumber;
//设备生产串号
@property (nonatomic, retain) NSString *serialNumber;
//设备地址
@property (nonatomic, copy) NSString * descriptionURL;


-(instancetype)initWithName:(NSString *)name UUID:(NSString *)uuid Manufacturer:(NSString *)manufacturer ModelName:(NSString *)modelName ModelNumber:(NSString *)modelNumber SerialNumber:(NSString *)serialNumber DescriptionURL:(NSString *)descriptionURL;
@end
