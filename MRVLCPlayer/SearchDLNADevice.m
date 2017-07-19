//
//  SearchDLNADevice.m
//  MRVLCPlayer
//
//  Created by jackyshan on 2017/7/12.
//  Copyright © 2017年 Alloc. All rights reserved.
//

#import "SearchDLNADevice.h"
#import "ZM_DMRControl.h"
#import "ZM_SingletonControlModel.h"

@interface SearchDLNADevice()<ZM_DMRProtocolDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray<ZM_RenderDeviceModel *> *devices;

@end

@implementation SearchDLNADevice

#pragma mark - 一、生命周期

#pragma mark 1 初始化

+ (instancetype)view {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commontInit];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    [self commontInit];
}

- (void)commontInit {
    self.backgroundColor = [UIColor colorWithRed:0x00/255 green:0x00/255 blue:0x00/255 alpha:0.2];
    
    [_loading startAnimating];
    
    [[[ZM_SingletonControlModel sharedInstance] DMRControl] setDelegate:self];
    //启动DMC去搜索设备
    if (![[[ZM_SingletonControlModel sharedInstance] DMRControl] isRunning]) {
        [[[ZM_SingletonControlModel sharedInstance] DMRControl] start];
    }
}

#pragma mark 2 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.frame = [[UIScreen mainScreen] bounds];
}

#pragma mark - 二、代理
#pragma mark - ZM_DMRProtocolDelegate
- (void)onDMRAdded {
    NSLog(@"%s",__FUNCTION__);
    
    _devices = [[NSMutableArray alloc] initWithArray:[[[ZM_SingletonControlModel sharedInstance] DMRControl] getActiveRenders]];
    [_tableView reloadData];
    [_loading stopAnimating];
}

/**
 移除DMR
 */
-(void)onDMRRemoved
{
    NSLog(@"%s",__FUNCTION__);
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _devices.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdentifier"];
        cell.textLabel.minimumScaleFactor = 6;
    }
    
    //    cell.textLabel.text = [_urlArr[indexPath.row] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    cell.textLabel.text = _devices[indexPath.row].name;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"开始连接设备");
    
    [[[ZM_SingletonControlModel sharedInstance] DMRControl] chooseRenderWithUUID:[_devices[indexPath.row]uuid]];
    ZM_RenderDeviceModel *model = [[[ZM_SingletonControlModel sharedInstance] DMRControl] getCurrentRender];
    
    NSLog(@"连接设备设备名%@，设备地址%@", model.name, model.descriptionURL);

    NSLog(@"开始播放%@", _mediaURL);
    
    if ([[[ZM_SingletonControlModel sharedInstance] DMRControl] getCurrentRender]) {
        [[[ZM_SingletonControlModel sharedInstance] DMRControl] renderSetAVTransportWithURI:_mediaURL.absoluteString metaData:nil];
        [[[ZM_SingletonControlModel sharedInstance] DMRControl] renderPlay];
    }
    [self dismiss];
    _dlnaPlayBlock();
}


#pragma mark - 三、事件处理

#pragma mark - 四、私有方法
- (IBAction)clickAction:(id)sender {
    [self dismiss];
}


#pragma mark - 五、外部接口
- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)dismiss {
    [self removeFromSuperview];
    [[[ZM_SingletonControlModel sharedInstance] DMRControl] stop];
}

#pragma mark - 六 setter and getter

#pragma mark 1 setter

#pragma mark 2 getter

@end
