//
// Created by dmitrii.aitov@philips.com on 12/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import <Foundation/Foundation.h>

///GET/POST request compleation block
typedef void (^ADRNetworkClientCompletionBlock)(NSData *, NSURLResponse *, NSError *);

///GET Download request compleation block
typedef void (^ADRNetworkClientDownloadCompletionBlock)(NSURL *, NSURLResponse *, NSError *);

///Dowload progress block
typedef void (^ADRNetworkClientProgressBlock)(float);

///Protocol of basic network client
@protocol ADRNetworkClientProtocol <NSObject>
@required

/// Execute provided request GET
/// @param request to execute
/// @param completion block which should be executed at the end of request
/// @return new instance of task accociated with request
- (NSURLSessionTask *)executeRequest:(NSURLRequest *)request completion:(ADRNetworkClientCompletionBlock)completion;

/// Execute provided request POST
/// @param request to execute
/// @param data to send to network location
/// @param completion block which should be executed at the end of request
/// @return new instance of task accociated with request
- (NSURLSessionTask *)executeRequest:(NSURLRequest *)request data:(NSData *)data completion:(ADRNetworkClientCompletionBlock)completion;

/// Execute provided request GET save to file
/// @param request to execute
/// @param downloadCompletion block which should be executed at the end of download request
/// @return new instance of task accociated with request
- (NSURLSessionTask *)executeRequest:(NSURLRequest *)request downloadCompletion:(ADRNetworkClientDownloadCompletionBlock)downloadCompletion;

/// Execute provided request GET save to file
/// @param request to execute
/// @param progress block which should be executed on update of progress
/// @param downloadCompletion block which should be executed at the end of download request
/// @return new instance of task accociated with request
- (NSURLSessionTask *)executeRequest:(NSURLRequest *)request progress:(ADRNetworkClientProgressBlock)progress downloadCompletion:(ADRNetworkClientDownloadCompletionBlock)downloadCompletion;

@end
