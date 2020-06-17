//
//  FriendModel.h
//  Assistance
//
//  Created by wenpeiding on 10/06/2020.
//  Copyright © 2020 wenpeiding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FriendEntity.h"
#import <AFNetworking.h>

@protocol FriendDelegate;

@interface FriendModel : NSObject{
    AFHTTPSessionManager *manager;
}

@property (nonatomic, weak) id<FriendDelegate> delegate;
@property (nonatomic,readonly, strong) NSArray *dataSource;

- (void)loadData:(NSString *)token;
- (void)addOrRemoveFriend:(NSString *)friendToken type:(NSInteger)type;
- (void)addUser:(NSString *)token;

- (FriendEntity *)itemWithIndexPath:(NSInteger)row;

@end


@protocol FriendDelegate<NSObject>

- (void)loadComplete;
- (void)loadError:(NSString *)errorMessage;
- (void)reloadByRow:(NSInteger)row;

@end
