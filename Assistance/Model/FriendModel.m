//
//  FriendModel.m
//  Assistance
//
//  Created by wenpeiding on 10/06/2020.
//  Copyright © 2020 wenpeiding. All rights reserved.
//

#import "FriendModel.h"
#import "../Utils/Constants.h"

@implementation FriendModel

-(instancetype)init{
    self = [super init];
    NSMutableArray *array = [NSMutableArray array];
    _dataSource = array;
    manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    return self;
}

- (void)loadData:(NSString *)token{
    NSString *url = friendListUrl;
    NSDictionary *params = @{selfTokenKey:token};
    //manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"GET:%@", responseObject);
        //NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:1 error:nil];
        NSDictionary *dic = (NSDictionary*)responseObject;
        NSLog(@"ResDic = %@", dic);
        NSInteger status = [dic[@"status"] integerValue];
        if(status == 200) {
            NSArray *friends = dic[@"friends"];
            [self parseListData:friends];
            if(_delegate) {
                [_delegate loadComplete];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self netError:error];
    }];
    //NSMutableArray *array = [NSMutableArray array];
    //FriendEntity *entity = [FriendEntity alloc];
    //entity.name = @"test1";
    //entity.number = @"15876567878";
    //entity.imageUrl = @"";
    //entity.token = @"gegerhyerhre5u45u45";
    
    //[array addObject:entity];
    //_dataSource = array;
}

- (void)parseListData:(NSArray *)friends {
    NSMutableArray *array = [NSMutableArray array];
    for(int i=0; i<friends.count; ++i) {
        NSDictionary *friend = [friends objectAtIndex:i];
        FriendEntity *entity = [FriendEntity alloc];
        entity.name = friend[@"name"];
        entity.number = friend[@"number"];
        entity.imageUrl = friend[@"imageUrl"];
        entity.token = friend[@"user_token"];
        
        [array addObject:entity];
    }
    _dataSource = array;
}

- (void)netError:(NSError *) error{
    NSLog(@"error:%@", error);
}

- (FriendEntity *)itemWithIndexPath:(NSInteger)row{
    FriendEntity *entity = [_dataSource objectAtIndex:row];
    [self downloadImage:entity row:row];
    return entity;
}

- (void)downloadImage:(FriendEntity *)entity row:(NSInteger)row{
    if(!entity || entity.imageUrl.length == 0 || entity.isLoading){
        return ;
    }
    entity.isLoading = YES;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURL *url = [NSURL URLWithString:entity.imageUrl];
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        if(imageData){
            entity.imageData = imageData;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if(self.delegate) {
                [self.delegate reloadByRow:row];
            }
        });
    });
}

- (void)addOrRemoveFriend:(NSString *)friendToken type:(NSInteger)type{
    NSString *url = (type == 1)?friendAddUrl:friendDelUrl;
    NSString *token = getUserToken(true);
    NSDictionary *params = @{selfTokenKey:token, goalTokenKey:friendToken};
    __block NSString *bToken = token;
    [manager POST:url parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"add response:%@", responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSInteger status = [dic[@"status"] integerValue];
        if(status == 200) {
            [self loadData:bToken];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self netError:error];
    }];
}

@end
