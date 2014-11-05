//
//  AppDelegate.m
//  collectionViewDemo
//
//  Created by jyl on 14-11-5.
//  Copyright (c) 2014年 jyl. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "CircleLayout.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window=[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.viewController=[[ViewController alloc] initWithCollectionViewLayout:[[CircleLayout alloc] init]];

    self.window.rootViewController=self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}
@end
