//
//  AppDelegate.h
//  Assistance
//
//  Created by wenpeiding on 09/06/2020.
//  Copyright © 2020 wenpeiding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

