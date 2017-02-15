//
// Created by dmitrii.aitov@philips.com on 12/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ADRNetworkService;

///
@interface ADRNetworkResource : NSObject

///
@property (nonatomic, weak, readonly, nullable) ADRNetworkService *networkService;

///
/// @param flickrNetworkService
/// @return
- (nullable instancetype)initWithService:(nonnull ADRNetworkService *)networkService;

@end