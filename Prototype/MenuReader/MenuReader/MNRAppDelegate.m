//
//  MNRAppDelegate.m
//  MenuReader
//
//  Created by Taylan Pince on 2014-06-07.
//  Copyright (c) 2014 Hipo. All rights reserved.
//

#import "MNRAppDelegate.h"
#import "MNRRootViewController.h"


@implementation MNRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    MNRRootViewController *rootController = [[MNRRootViewController alloc] init];
    
    [_window setRootViewController:rootController];
    [_window setBackgroundColor:[UIColor blackColor]];

    [_window makeKeyAndVisible];
    
    return YES;
}

@end
