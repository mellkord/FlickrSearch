//
// Created by dmitrii.aitov@philips.com on 12/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import <Foundation/Foundation.h>

///
@protocol ADRMockNetworkClientDelegate <NSObject>
@required

///
/// @param request
/// @return
- (NSData *)dataForRequest:(NSURLRequest *)request;

///
/// @param request
/// @return
- (NSURLResponse *)responseForRequest:(NSURLRequest *)request;

///
/// @param request
/// @return
- (NSError *)errorForRequest:(NSURLRequest *)request;

///
/// @param request
/// @return
- (float)progressRorRequest:(NSURLRequest *)request;

///
/// @param request
/// @return
- (NSURL *)urlForRequest:(NSURLRequest *)request;

@end