//
//  FriendEntity.h
//  Assistance
//
//  Created by wenpeiding on 10/06/2020.
//  Copyright © 2020 wenpeiding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendEntity : NSObject
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, strong) NSData *imageData;
@property (nonatomic,assign) BOOL isLoading;
@end
