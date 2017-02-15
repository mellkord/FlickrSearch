//
//  AppDelegate.m
//  FlickrSearch
//
//  Created by dmitrii.aitov@philips.com on 15/02/17.
//  Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import "AppDelegate.h"
#import "ADRSearchViewController.h"
#import "ADRFlickrSearchViewModel.h"


@interface AppDelegate ()

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    ADRFlickrSearchViewModel *searchViewModel = [[ADRFlickrSearchViewModel alloc] init];
    ADRSearchViewController *searchViewController = [[ADRSearchViewController alloc] initWithViewModel:searchViewModel];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:searchViewController];

    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];

    return YES;
}

@end
