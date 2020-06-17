//
//  MBProgressHUD+PO.h
//  Assistance
//
//  Created by wenpeiding on 15/06/2020.
//  Copyright © 2020 wenpeiding. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (PO)

+ (void)showSuccess:(NSString *)success;
+ (void)showSuccess:(NSString *)success toview:(UIView *) view;

+ (void)showError:(NSString *)error;
+ (void)showError:(NSString *)error toview:(UIView *) view;

+ (MBProgressHUD *)showMessage:(NSString *)message;
+ (MBProgressHUD *)showMessage:(NSString *)message toview:(UIView *)view;

+ (void)hideHD;
+ (void)hideHDForView:(UIView *) view;
@end
