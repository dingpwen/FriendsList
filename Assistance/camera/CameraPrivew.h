//
//  CameraPrivew.h
//  Assistance
//
//  Created by wenpeiding on 15/06/2020.
//  Copyright © 2020 wenpeiding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <VideoToolbox/VideoToolbox.h>

@interface CameraPrivew : NSObject

@property (nonatomic, strong) CALayer *cameraLayer;
@property (nonatomic, weak) id<AVCaptureVideoDataOutputSampleBufferDelegate> delegate;
- (void)start;
- (void)stop;
@end
