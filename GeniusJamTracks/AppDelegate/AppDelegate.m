//
//  AppDelegate.m
//  GeniusJamTracks
//
//  22/04/2020
//  Copyright © 2020 JB Solutions. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"transpose"] == nil) {
        [[NSUserDefaults standardUserDefaults] setValue:@"C (Default)" forKey:@"transpose"];
    }
    return YES;
}





@end
