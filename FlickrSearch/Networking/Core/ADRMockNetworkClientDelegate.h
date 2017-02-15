//
// Created by dmitrii.aitov@philips.com on 12/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import <Foundation/Foundation.h>

///Protocol describing delegate for mocked network client
@protocol ADRMockNetworkClientDelegate <NSObject>
@required

/// Provide data for specified request
/// @param request
/// @return data which should be passed to client
- (NSData *)dataForRequest:(NSURLRequest *)request;

/// Provide responce for specified request
/// @param request
/// @return responce object which should be passed to client
- (NSURLResponse *)responseForRequest:(NSURLRequest *)request;

/// Provide error for specified request
/// @param request
/// @return error object which should be passed to client
- (NSError *)errorForRequest:(NSURLRequest *)request;

/// Provide progress for specified download request
/// @param request download request
/// @return progress which should be passed to client
- (float)progressRorRequest:(NSURLRequest *)request;

/// Provide file url for specified download request
/// @param request download request
/// @return file url which should be passed to client
- (NSURL *)urlForRequest:(NSURLRequest *)request;

@end
