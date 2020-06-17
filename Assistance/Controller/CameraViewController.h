//
//  CameraViewController.h
//  Assistance
//
//  Created by wenpeiding on 16/06/2020.
//  Copyright © 2020 wenpeiding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../camera/CameraPrivew.h"

@interface CameraViewController : UIViewController<AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic, strong) CameraPrivew *preview;

@end
