//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>

@class ADRFlickrPhoto;
@protocol ADRFlickrSearchPhotoStorageDelegate;
@class ADRFlickrNetworkService;

///TODO docs
@interface ADRFlickrSearchPhotoStorage : NSObject

@property (nonatomic, weak, readwrite, nullable) NSObject<ADRFlickrSearchPhotoStorageDelegate> *delegate;
@property (nonatomic, copy, readonly, nonnull) NSString *searchString;
@property (nonatomic, assign, readonly) NSUInteger photosCount;


- (nullable instancetype)initWithSearchString:(nonnull NSString *)searchString
                                flickrService:(nonnull ADRFlickrNetworkService *)flickrService
                                     delegate:(nullable NSObject<ADRFlickrSearchPhotoStorageDelegate> *)delegate;

- (nullable ADRFlickrPhoto *)photoByIndex:(NSUInteger)index;
- (nullable ADRFlickrPhoto *)photoByIdentifier:(NSUInteger)identifier;
- (nullable UIImage *)imageByIndex:(NSUInteger)index;
- (nullable UIImage *)imageByPhotoIdentifier:(NSUInteger)identifier;
- (nullable UIImage *)imageByURL:(nonnull NSURL*)url;

@end