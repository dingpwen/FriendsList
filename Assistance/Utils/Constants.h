//
//  Constants.h
//  Assistance
//
//  Created by wenpeiding on 09/06/2020.
//  Copyright © 2020 wenpeiding. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

FOUNDATION_EXPORT NSString *const friendListUrl;
FOUNDATION_EXPORT NSString *const friendAddUrl;
FOUNDATION_EXPORT NSString *const friendDelUrl;
FOUNDATION_EXPORT NSString *const userAddUrl;
FOUNDATION_EXPORT NSString *const goalTokenKey;
FOUNDATION_EXPORT NSString *const selfTokenKey;

extern NSString *getUserToken(BOOL generated);
extern void saveUserToken(NSString *token);
extern NSString *getNowTimeTimestamp(void);

#endif /* Constants_h */
