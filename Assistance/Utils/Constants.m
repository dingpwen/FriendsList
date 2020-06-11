//
//  Constants.m
//  Assistance
//
//  Created by wenpeiding on 09/06/2020.
//  Copyright © 2020 wenpeiding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

NSString *const friendListUrl = @"http://172.16.200.206:5000/friend/list";
NSString *const friendAddUrl = @"http://172.16.200.206:5000/friend/add";
NSString *const friendDelUrl = @"http://172.16.200.206:5000/friend/delete";
static NSString *const tokenKey = @"userToken";
static NSString *const defautToken = @"28AGS15pRCVkuiO3ZYz7lWG+zBUEIHHxS3kjHqdcyd4=";

NSString *getUserToken(BOOL generated){
    NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:tokenKey];
    if(generated && token.length == 0) {
        token = defautToken;
    }
    return token;
}

void saveUserToken(NSString *token) {
    [[NSUserDefaults standardUserDefaults]setObject:token forKey:tokenKey];
}
