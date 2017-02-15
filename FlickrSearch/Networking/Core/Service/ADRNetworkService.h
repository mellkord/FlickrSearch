//
// Created by dmitrii.aitov@philips.com on 12/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ADRNetworkClientProtocol;

///Clss represents network API
@interface ADRNetworkService : NSObject

///Base url of network service
@property (nonatomic, strong, readonly, nonnull) NSURL *baseURL;

///Abstraction on top NSURLSession API
@property (nonatomic, strong, readonly, nonnull) NSObject<ADRNetworkClientProtocol> *networkCLient;

/// Initialization method of network service
/// @param baseURL base url of network service
/// @param networkClient abstraction on top NSURLSession API
/// @return new instance of network service
- (nullable instancetype)initWithBaseURL:(nonnull NSURL *)baseURL networkClient:(nonnull NSObject<ADRNetworkClientProtocol> *)networkClient;

/// Add parameters to query part of url
/// @param urlComponents shared url components instance in/out
- (void)addParametersToURLComponents:(nonnull NSURLComponents *)urlComponents;

/// Add http headers to request
/// @param urlRequest shared url request instance in/out
- (void)addHeadersToURLRequest:(nonnull NSMutableURLRequest *)urlRequest;


///Made new and init unavailable to avoid call without mandatory parameters
+ (nullable instancetype)new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

@end
