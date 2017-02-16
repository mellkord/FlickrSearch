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
#import "ADRSearchHistoryStorage.h"
#import "ADRFlickrNetworkService.h"
#import "ADRNetworkClient.h"

static NSString *const kFlickrAPIKey = @"3e7cc266ae2b0e0d78e279ce8e361736";

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _historyStorage = [[ADRSearchHistoryStorage alloc] init];
    _flickrNetworkService = [[ADRFlickrNetworkService alloc] initWithAPIKey:kFlickrAPIKey networkClient:[[ADRNetworkClient alloc] init]];

    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    ADRFlickrSearchViewModel *searchViewModel = [[ADRFlickrSearchViewModel alloc] init];
    ADRSearchViewController *searchViewController = [[ADRSearchViewController alloc] initWithViewModel:searchViewModel];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:searchViewController];

    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];

    return YES;
}

@end
