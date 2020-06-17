//
//  MBProgressHUD+PO.m
//  Assistance
//
//  Created by wenpeiding on 15/06/2020.
//  Copyright © 2020 wenpeiding. All rights reserved.
//

#import "MBProgressHUD+PO.h"

@implementation MBProgressHUD (PO)

+ (void)show:(NSString *)message icon:(NSString *)iconPath toview:(UIView *)view {
    if(view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:true];
    hud.label.text = message;
    hud.label.textColor = [UIColor colorWithDisplayP3Red:33 green:33 blue:33 alpha:1.0];
    hud.label.font = [UIFont systemFontOfSize:17];
    hud.userInteractionEnabled = NO;
    
    // 设置图片
    hud.bezelView.backgroundColor = [UIColor grayColor];    //背景颜色
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", iconPath]]];
    
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:1.5];
    
}

+ (void)showSuccess:(NSString *)success{
    [self showSuccess:success toview:nil];
}

+ (void)showSuccess:(NSString *)success toview:(UIView *) view{
    if(view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    [self show:success icon:@"success.png" toview:view];
}

+ (void)showError:(NSString *)error{
    [self showError:error toview:nil];
    
}

+ (void)showError:(NSString *)error toview:(UIView *) view{
    if(view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    [self show:error icon:@"error.png" toview:view];
    
}

+ (MBProgressHUD *)showMessage:(NSString *)message{
    return [self showMessage:message toview:nil];
}

+ (MBProgressHUD *)showMessage:(NSString *)message toview:(UIView *)view;{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = YES;
    
    return hud;
}


+ (void)hideHD {
    [self hideHDForView:nil];
}
+ (void)hideHDForView:(UIView *) view{
    if(!view) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    [self hideHUDForView:view animated:true];
}

@end
