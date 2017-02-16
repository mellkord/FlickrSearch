//
// Created by dmitrii.aitov@philips.com on 12/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import "ADRNetworkService.h"
#import "ADRNetworkClientProtocol.h"

@implementation ADRNetworkService

- (instancetype)init {
    NSAssert(NO, @"Should use initWithBaseURL:networkClient instead");
    return nil;
}

- (instancetype)initWithBaseURL:(NSURL *)baseURL networkClient:(NSObject<ADRNetworkClientProtocol> *)networkClient
{
    self = [super init];

    if (self)
    {
        _baseURL = baseURL;
        _networkCLient = networkClient;
    }

    return self;
}

- (void)addParametersToURLComponents:(NSURLComponents *)urlComponents;
{
    NSAssert(NO, @"Child class should override this method");
}

- (void)addHeadersToURLRequest:(NSMutableURLRequest *)urlRequest
{
    NSAssert(NO, @"Child class should override this method");
}


@end
