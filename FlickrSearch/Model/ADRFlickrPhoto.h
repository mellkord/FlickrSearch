//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import <Foundation/Foundation.h>

///TODO Docs
@interface ADRFlickrPhoto : NSObject

@property (nonatomic, assign, readonly)         NSUInteger  identifier;
@property (nonatomic, copy, readonly, nonnull)  NSString    *owner;
@property (nonatomic, copy, readonly, nonnull)  NSString    *secret;
@property (nonatomic, assign, readonly)         NSUInteger  server;
@property (nonatomic, assign, readonly)         NSUInteger  farm;
@property (nonatomic, copy, readonly, nonnull)  NSString    *title;

- (nullable instancetype)initWithIdentifier:(NSUInteger)identifier
                                      title:(nonnull NSString *)title
                                      owner:(nonnull NSString *)owner
                                     secret:(nonnull NSString *)secret
                                     server:(NSUInteger)server
                                       farm:(NSUInteger)farm;

- (nullable NSURL*)imageURL;

+ (nullable instancetype)new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

@end