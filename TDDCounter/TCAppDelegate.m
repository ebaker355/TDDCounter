//
//  TCAppDelegate.m
//  TDDCounter
//
//  Created by Eric Baker on 06/05/13.
//  Copyright (c) 2013 DuneParkSoftware, LLC. All rights reserved.
//

#import "TCAppDelegate.h"
#import "TCCounterViewController.h"
#import "TCCounter.h"

@implementation TCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    TCCounter *counter = [[TCCounter alloc] init];
    [self.window setRootViewController:[[TCCounterViewController alloc] initWithCounter:counter]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
