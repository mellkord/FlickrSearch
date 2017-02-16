//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>

@class ADRFlickrPhoto;
@protocol ADRFlickrSearchPhotoStorageDelegate;
@class ADRFlickrNetworkService;

///Class which store photo object in memory and downloaded images
@interface ADRFlickrSearchPhotoStorage : NSObject

///Storage delegate
@property (nonatomic, weak, readwrite, nullable) NSObject<ADRFlickrSearchPhotoStorageDelegate> *delegate;

///String used for search
@property (nonatomic, copy, readonly, nonnull) NSString *searchString;

///Total count of photo objects
@property (nonatomic, assign, readonly) NSUInteger photosCount;

/// Initialization method of ADRFlickrSearchPhotoStorage
/// @param searchString string used for search
/// @param flickrService flickr API service
/// @param delegate storage delegate
/// @return new instance of ADRFlickrSearchPhotoStorage
- (nullable instancetype)initWithSearchString:(nonnull NSString *)searchString
                                flickrService:(nonnull ADRFlickrNetworkService *)flickrService
                                     delegate:(nullable NSObject<ADRFlickrSearchPhotoStorageDelegate> *)delegate;

/// Photo object by index
/// @param index index
/// @return Photo object or nil
- (nullable ADRFlickrPhoto *)photoByIndex:(NSUInteger)index;

/// Photo object by identifier
/// @param identifier identifier
/// @return Photo object or nil
- (nullable ADRFlickrPhoto *)photoByIdentifier:(NSUInteger)identifier;

/// Image by index
/// @param index index
/// @return Image or nil
- (nullable UIImage *)imageByIndex:(NSUInteger)index;

/// Image by photo identifier
/// @param identifier identifier
/// @return Image or nil
- (nullable UIImage *)imageByPhotoIdentifier:(NSUInteger)identifier;

/// Image by URL
/// @param url url
/// @return Image or nil
- (nullable UIImage *)imageByURL:(nonnull NSURL*)url;

///Made init and new unavailable to avoid creation without mandatory parameters
+ (nullable instancetype)new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

@end