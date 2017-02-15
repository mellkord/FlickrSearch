//
// Created by dmitrii.aitov@philips.com on 12/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ADRNetworkService;

///Class representing single network resource
@interface ADRNetworkResource : NSObject

///NetworkService service associated with resource
@property (nonatomic, weak, readonly, nullable) ADRNetworkService *networkService;

/// Initialization method of network resource
/// @param networkService service associated with resource
/// @return new instance of network service
- (nullable instancetype)initWithService:(nonnull ADRNetworkService *)networkService;

@end
