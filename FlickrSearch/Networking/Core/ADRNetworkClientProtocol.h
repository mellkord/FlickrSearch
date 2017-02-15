//
// Created by dmitrii.aitov@philips.com on 12/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import <Foundation/Foundation.h>

///
typedef void (^ADRNetworkClientCompletionBlock)(NSData *, NSURLResponse *, NSError *);

///
typedef void (^ADRNetworkClientDownloadCompletionBlock)(NSURL *, NSURLResponse *, NSError *);

///
typedef void (^ADRNetworkClientProgressBlock)(float);

///
@protocol ADRNetworkClientProtocol <NSObject>
@required

///
/// @param request
/// @param completion
/// @return
- (NSURLSessionTask *)executeRequest:(NSURLRequest *)request completion:(ADRNetworkClientCompletionBlock)completion;

///
/// @param request
/// @param data
/// @param completion
/// @return
- (NSURLSessionTask *)executeRequest:(NSURLRequest *)request data:(NSData *)data completion:(ADRNetworkClientCompletionBlock)completion;

///
/// @param request
/// @param downloadCompletion
/// @return
- (NSURLSessionTask *)executeRequest:(NSURLRequest *)request downloadCompletion:(ADRNetworkClientDownloadCompletionBlock)downloadCompletion;

///
/// @param request
/// @param progress
/// @param downloadCompletion
/// @return
- (NSURLSessionTask *)executeRequest:(NSURLRequest *)request progress:(ADRNetworkClientProgressBlock)progress downloadCompletion:(ADRNetworkClientDownloadCompletionBlock)downloadCompletion;

@end