//
//  CameraPrivew.m
//  Assistance
//
//  Created by wenpeiding on 15/06/2020.
//  Copyright © 2020 wenpeiding. All rights reserved.
//

#import "CameraPrivew.h"

@interface CameraPrivew()

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoDataOutput *dataOutput;

@end


@implementation CameraPrivew

static const char *queueLabel = "videoDataOutput";

- (instancetype)init{
    self = [super init];
    if(self) {
        [self initCameraSession];
    }
    return self;
}

#pragma mark init camera
- (void)initCameraSession{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if(error){
        NSLog(@"Fail to create input device!error:%@", error);
        return;
    }
    
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPreset1920x1080];
    if(![_session canAddInput:input]){
        NSLog(@"can not add input!");
        return;
    }
    [_session addInput:input];
    
    AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc]init];
    if(![_session canAddOutput:output]){
        NSLog(@"");
        
    }
    [_session addOutput:output];
    self.dataOutput = output;
    
    dispatch_queue_t outQueue = dispatch_queue_create(queueLabel, DISPATCH_QUEUE_SERIAL);
    [self.dataOutput setSampleBufferDelegate:self.delegate queue:outQueue];
    self.dataOutput.alwaysDiscardsLateVideoFrames = NO;
    
    NSNumber *BGRA32PixelFormat = [NSNumber numberWithInt:kCVPixelFormatType_32BGRA];
    //设置像素输出格式
    //NSDictionary *rgbOutputSetting = [NSDictionary dictionaryWithObject:BGRA32PixelFormat forKey:(id)kCVPixelBufferPixelFormatTypeKey];
    NSDictionary *yuvOutputSetting = @{(id)kCVPixelBufferPixelFormatTypeKey: @(kCVPixelFormatType_420YpCbCr8PlanarFullRange)};
    [self.dataOutput setVideoSettings:/*rgbOutputSetting*/yuvOutputSetting];
    
}

- (CALayer *)cameraLayer{
    if(_cameraLayer == nil){
        _cameraLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.session];
    }
    return _cameraLayer;
}


-(void)start{
    if(_session) {
        [_session startRunning];
    }
}

- (void)stop{
    if(_session) {
        [_session stopRunning];
    }
}

@end
