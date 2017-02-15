//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import <Foundation/Foundation.h>

///Representation of Flickr.com photo object
@interface ADRFlickrPhoto : NSObject

///Identifier of photo
@property (nonatomic, assign, readonly)         NSUInteger  identifier;

///Owner identifier
@property (nonatomic, copy, readonly, nonnull)  NSString    *owner;

///Photo secret
@property (nonatomic, copy, readonly, nonnull)  NSString    *secret;

///Server where photo is located
@property (nonatomic, assign, readonly)         NSUInteger  server;

///Farm where photo is located
@property (nonatomic, assign, readonly)         NSUInteger  farm;

///Title of photo
@property (nonatomic, copy, readonly, nonnull)  NSString    *title;

/// Initialization method of flickr photo
/// @param identifier identifier of photo
/// @param title title of photo
/// @param owner owner of photo
/// @param secret secret of photo
/// @param server server where photo is located
/// @param farm farm where photo is located
/// @return new instance of photo object
- (nullable instancetype)initWithIdentifier:(NSUInteger)identifier
                                      title:(nonnull NSString *)title
                                      owner:(nonnull NSString *)owner
                                     secret:(nonnull NSString *)secret
                                     server:(NSUInteger)server
                                       farm:(NSUInteger)farm;

/// Calculate image url based on all object parameters
/// @return image url associated with this photo object
- (nullable NSURL*)imageURL;

///Made init and new unavailable to avoid creation without mandatory parameters
+ (nullable instancetype)new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

@end