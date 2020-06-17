//
//  CameraViewController.m
//  Assistance
//
//  Created by wenpeiding on 16/06/2020.
//  Copyright © 2020 wenpeiding. All rights reserved.
//

#import "CameraViewController.h"

@interface CameraViewController ()

@end

@implementation CameraViewController

void Matrix_Rotate_90(uint8_t *src,uint8_t *dst,int M ,int N){
    for(int i=0;i<M;i++)
        for(int j=0;j<N;j++){
            dst[i*N+j]=src[(N-1-j)*M+i];
        }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.preview = [[CameraPrivew alloc]init];
    self.preview.delegate = self;
    CALayer *layer = [self.preview cameraLayer];
    layer.frame = CGRectMake(0, 100, self.view.frame.size.width, 400);
    [self.view.layer addSublayer:layer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)captureOutput:(AVCaptureOutput *)output didDropSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection{
    CVImageBufferRef imageBufferRef = CMSampleBufferGetImageBuffer(sampleBuffer);
    size_t width = CVPixelBufferGetWidth(imageBufferRef);
    size_t height = CVPixelBufferGetHeight(imageBufferRef);
    
    CVPixelBufferLockBaseAddress(imageBufferRef, 0);//lock with unlock
    //huidu tu chuli
    unsigned char * image_ptr = CVPixelBufferGetBaseAddressOfPlane(imageBufferRef, 0);
    unsigned char* gray = (unsigned char *)malloc(sizeof(unsigned char) * width * height * 4);
    Matrix_Rotate_90(image_ptr, gray, (int)width, (int)height);
    
    CVPixelBufferUnlockBaseAddress(imageBufferRef, 0);
}


-(UIImage*)convertSampleBufferToImage:(CMSampleBufferRef)sampleBuffer{
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    
    CVPixelBufferLockBaseAddress(imageBuffer, 0);//lock with unlock
    
    unsigned char * image_ptr = CVPixelBufferGetBaseAddress(imageBuffer);
    size_t bytePerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(image_ptr, width, height, 8, bytePerRow, colorSpace, kCGBitmapByteOrder32Little|kCGImageAlphaPremultipliedFirst);
    
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGContextRelease(context);
    
    CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
    
    return image;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
