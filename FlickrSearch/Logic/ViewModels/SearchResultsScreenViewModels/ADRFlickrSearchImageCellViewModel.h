//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>
#import "ADRSearchResultsImageCellViewModelProtocol.h"

@class ADRFlickrPhoto;

///Flickr.com result image cell view model
@interface ADRFlickrSearchImageCellViewModel : NSObject <ADRSearchResultsImageCellViewModelProtocol>

/// Initialization method of ADRFlickrSearchImageCellViewModel
/// @param photo model object represents one photo
/// @param image image connected to this photo
/// @return new instance of ADRFlickrSearchImageCellViewModel
- (nullable instancetype)initWithPhoto:(nonnull ADRFlickrPhoto *)photo image:(nonnull UIImage *)image;

///Made init and new unavailable to avoid creation without mandatory parameters
+ (nullable instancetype)new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

@end