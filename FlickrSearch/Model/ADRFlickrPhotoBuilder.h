//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ADRFlickrPhoto;

///Builder of flickr photo object based on data provided
@interface ADRFlickrPhotoBuilder : NSObject

/// Creates array of flickr photo objects based on JSON data
/// @param jsonData data which can be converted to JSON representation of flickr photos
/// @return array of flickr photo objects
+ (nullable NSArray<ADRFlickrPhoto *> *)photosFromJSONData:(nonnull NSData *)jsonData;

/// Creates array of flickr photo objects based on XML data
/// @param xmlData data which can be converted to XML representation of flickr photos
/// @return array of flickr photo objects
+ (nullable NSArray<ADRFlickrPhoto *> *)photosFromXMLData:(nonnull NSData *)xmlData;

@end