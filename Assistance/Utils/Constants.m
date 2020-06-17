//
//  Constants.m
//  Assistance
//
//  Created by wenpeiding on 09/06/2020.
//  Copyright © 2020 wenpeiding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import "Constants.h"

NSString *const friendListUrl = @"http://172.16.200.206:5000/friend/list";
NSString *const friendAddUrl = @"http://172.16.200.206:5000/friend/add";
NSString *const friendDelUrl = @"http://172.16.200.206:5000/friend/delete";
NSString *const userAddUrl = @"http://172.16.200.206:5000/user/add";
NSString *const goalTokenKey = @"goal_token";
NSString *const selfTokenKey = @"token";

static NSString *const userTokenFix = @"wveinwpadlakm@I";
static const int userTokenPos = 10;
static NSString *const tokenKey = @"userToken";
static NSString *const defautToken = @"28AGS15pRCVkuiO3ZYz7lWG+zBUEIHHxS3kjHqdcyd4=";

NSString *getNowTimeTimestamp(){
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)([datenow timeIntervalSince1970]*1000)];
    NSLog(@"timestampe:%@", timeSp);
    return timeSp;
}

static NSString* generateToken() {
    NSString *time = getNowTimeTimestamp();
    const char* timeStr = [time UTF8String];
    unsigned char timeDigest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(timeStr, (CC_LONG)strlen(timeStr), timeDigest);
    
    const char *defaultPart = [userTokenFix UTF8String];
    unsigned char defaultDigest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(defaultPart, (CC_LONG)strlen(defaultPart), defaultDigest);
    
    int len = CC_MD5_DIGEST_LENGTH * 2;
    unsigned char digest[len];
    for(int i=0; i<len; ++i){
        if(i < userTokenPos){
            digest[i] = timeDigest[i];
        } else if(i < userTokenPos + CC_MD5_DIGEST_LENGTH) {
            digest[i] = defaultDigest[i - userTokenPos];
        } else {
            digest[i] = timeDigest[i - CC_MD5_DIGEST_LENGTH];
        }
    }
    NSData *data = [NSData dataWithBytes:digest length:len];
    return [data base64EncodedStringWithOptions:0];
}

NSString *getUserToken(BOOL generated){
    NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:tokenKey];
    if(generated && token.length == 0) {
        token = generateToken();
        NSLog(@"generate token:%@", token);
    }
    return token;
}


void saveUserToken(NSString *token) {
    [[NSUserDefaults standardUserDefaults]setObject:token forKey:tokenKey];
}
