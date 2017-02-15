//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADRSearchResultsScreenViewModelProtocol.h"
#import "ADRFlickrSearchPhotoStorageDelegate.h"

@class ADRFlickrSearchPhotoStorage;

///Flickr.com photo search results view model
@interface ADRFlickrSearchResultsViewModel : NSObject <ADRSearchResultsScreenViewModelProtocol, ADRFlickrSearchPhotoStorageDelegate>

/// Initialization methods for ADRFlickrSearchResultsViewModel
/// @param searchString search string
/// @param storage photo storage
/// @return new instance of ADRFlickrSearchResultsViewModel
- (nullable instancetype)initWithSearchString:(nonnull NSString *)searchString photoStorage:(nonnull ADRFlickrSearchPhotoStorage *)storage;

///Made init and new unavailable to avoid creation without mandatory parameters
+ (nullable instancetype)new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

@end
