//
// Created by dmitrii.aitov@philips.com on 12/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import "ADRNetworkResource.h"
#import "ADRNetworkService.h"


@implementation ADRNetworkResource

- (instancetype)initWithService:(ADRNetworkService *)networkService
{
    self = [super init];

    if (self)
    {
        _networkService = networkService;
    }

    return self;
}

@end