//
// Created by dmitrii.aitov@philips.com on 12/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ADRNetworkClientProtocol;

///
@interface ADRNetworkService : NSObject

///
@property (nonatomic, strong, readonly, nonnull) NSURL *baseURL;

///
@property (nonatomic, strong, readonly, nonnull) NSObject<ADRNetworkClientProtocol> *networkCLient;

///
/// @param baseURL
/// @param networkClient
/// @return
- (nullable instancetype)initWithBaseURL:(nonnull NSURL *)baseURL networkClient:(nonnull NSObject<ADRNetworkClientProtocol> *)networkClient;

///
/// @param urlComponents
- (void)addParametersToURLComponents:(nonnull NSURLComponents *)urlComponents;

///
/// @param urlRequest
- (void)addHeadersToURLRequest:(nonnull NSMutableURLRequest *)urlRequest;


///
+ (nullable instancetype)new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

@end