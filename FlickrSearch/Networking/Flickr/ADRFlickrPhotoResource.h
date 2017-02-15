//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADRNetworkResource.h"
#import "ADRFlickrPhotoResourceProtocol.h"

///Flickr.com photo resource
@interface ADRFlickrPhotoResource : ADRNetworkResource <ADRFlickrPhotoResourceProtocol>

///Made init and new unavailable to avoid creation without mandatory parameters
+ (nullable instancetype)new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

@end
