//
//  KKAppDelegate.m
//  KKCSSLayout
//
//  Created by CocoaPods on 03/26/2015.
//  Copyright (c) 2014 Peter Mackay. All rights reserved.
//

#import "KKAppDelegate.h"

@implementation KKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Main" owner:nil options:nil];
    
    NSAssert([nib[0] isKindOfClass:[UIViewController class]], @"Expected a view controller.");
    UIViewController *mainViewController = nib[0];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = navigationController;
    
    [self.window makeKeyAndVisible];

    return YES;
}

@end
