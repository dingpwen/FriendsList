//
//  ViewController.h
//  Assistance
//
//  Created by wenpeiding on 09/06/2020.
//  Copyright © 2020 wenpeiding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import "Model/FriendModel.h"

@interface ViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource, FriendDelegate>{

}

@property (nonatomic,strong) FriendModel *model;


@end

