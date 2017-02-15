//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADRNetworkService.h"

@protocol ADRFlickrPhotoResourceProtocol;

///Service which describes functionality of flickr.com REST API
@interface ADRFlickrNetworkService : ADRNetworkService

@property (nonatomic, strong, readonly, nonnull) NSObject<ADRFlickrPhotoResourceProtocol> *photoResource;

/// Create new instance of ADRFlickrNetworkService
/// @param apiKey key to access flick.com REST API
/// @param networkClient low level generic network client to execute requests
/// @return new instance of ADRFlickrNetworkService
- (nullable instancetype)initWithAPIKey:(nonnull NSString *)apiKey networkClient:(nonnull NSObject<ADRNetworkClientProtocol> *)networkClient;

///Made init and new unavailable to avoid creation without mandatory parameters
+ (nullable instancetype)new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

@end