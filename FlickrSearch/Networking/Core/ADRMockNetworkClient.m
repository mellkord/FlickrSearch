//
// Created by dmitrii.aitov@philips.com on 12/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import "ADRMockNetworkClient.h"


@implementation ADRMockNetworkClient

#pragma mark ADRNetworkClientProtocol methods
- (NSURLSessionTask *)executeRequest:(NSURLRequest *)request completion:(ADRNetworkClientCompletionBlock)completion
{
    return nil;
}

- (NSURLSessionTask *)executeRequest:(NSURLRequest *)request data:(NSData *)data completion:(ADRNetworkClientCompletionBlock)completion
{
    return nil;
}

- (NSURLSessionTask *)executeRequest:(NSURLRequest *)request downloadCompletion:(ADRNetworkClientDownloadCompletionBlock)completion
{
    return nil;
}

- (NSURLSessionTask *)executeRequest:(NSURLRequest *)request progress:(ADRNetworkClientProgressBlock)progress downloadCompletion:(ADRNetworkClientDownloadCompletionBlock)completion
{
    return nil;
}

@end
