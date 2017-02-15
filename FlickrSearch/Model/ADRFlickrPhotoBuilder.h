//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ADRFlickrPhoto;

///TODO Docs
@interface ADRFlickrPhotoBuilder : NSObject

+ (nullable NSArray<ADRFlickrPhoto *> *)photosFromJSONData:(nonnull NSData *)jsonData;
+ (nullable NSArray<ADRFlickrPhoto *> *)photosFromXMLData:(nonnull NSData *)xmlData;

@end