//
//  ViewController.h
//  Assistance
//
//  Created by wenpeiding on 09/06/2020.
//  Copyright © 2020 wenpeiding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import "MBProgressHUD/MBProgressHUD+PO.h"
#import <MJRefresh.h>
//#import <SDWebImage.h>
#import "Model/FriendModel.h"

@interface ViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource, FriendDelegate>{
    UIButton *addBtn;
    int kScreenHeight;
    int kScreenWidth;
    int btnY;
}
@property (strong, nonatomic) IBOutlet UIBarButtonItem *mDelete;

@property (nonatomic,strong) FriendModel *model;
@property (strong, nonatomic) IBOutlet UIRefreshControl *spinner;


@end

