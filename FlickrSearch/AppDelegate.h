//
//  AppDelegate.h
//  FlickrSearch
//
//  Created by dmitrii.aitov@philips.com on 15/02/17.
//  Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ADRSearchHistoryStorage;
@class ADRFlickrNetworkService;


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic, nonnull) UIWindow *window;

///Shared search history storage objects
@property (nonatomic, strong, readonly, nonnull) ADRSearchHistoryStorage *historyStorage;

///Shared flickr network service
@property (nonatomic, strong, readonly, nonnull) ADRFlickrNetworkService *flickrNetworkService;

@end
