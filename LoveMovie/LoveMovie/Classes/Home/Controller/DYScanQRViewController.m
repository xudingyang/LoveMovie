//
//  DYScanQRViewController.m
//  LoveMovie
//
//  Created by xudingyang on 16/6/5.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYScanQRViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface DYScanQRViewController () <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, weak) AVCaptureVideoPreviewLayer *layer;

@property (weak, nonatomic) IBOutlet UIImageView *scanView;

@end

@implementation DYScanQRViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 1 创建一个捕捉会话
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    self.session = session;
    // 2 设置输入设备(从哪里把数据输入进来，摄像头)
    // 得到摄像头设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // 得到输入
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    [session addInput:input];
    // 3 设置输出数据的地方（把数据输出到哪里）
    // 扫描到的数据都是元数据，所以这里用元类对象(示例对象-->类对象-->元类对象-->根元类对象)
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [session addOutput:output];
    // 3.1.设置输入元数据的类型(类型是二维码数据)
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    // 4 添加一个扫描图层（把这个图层添加到某个地方，就可以看到扫描的情况。即扫描框）
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    self.layer = layer;
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    layer.frame = CGRectMake(10, 10, 280, 280);
    [self.scanView.layer addSublayer:layer];
    // 5 开始扫描
    [session startRunning];
}

#pragma mark - output的回调方法
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count > 0) {
        // 获取扫描的结果
        AVMetadataMachineReadableCodeObject *object = [metadataObjects lastObject];
        
        UILabel *label = [[UILabel alloc] init];
        [self.scanView addSubview:label];
        label.text = [object stringValue];
        [label sizeToFit];
        label.numberOfLines = 0;
        label.centerX = 150;
        label.centerY = 150;
        // 停止扫描
        [self.session stopRunning];
        // 将预览图层移除
        [self.layer removeFromSuperlayer];
    } else {
        UILabel *label = [[UILabel alloc] init];
        [self.scanView addSubview:label];
        label.text = @"扫描失败";
        [label sizeToFit];
        label.centerX = 150;
        label.centerY = 150;
    }
}

@end
