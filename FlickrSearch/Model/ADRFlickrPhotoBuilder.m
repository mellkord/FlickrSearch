//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import "ADRFlickrPhotoBuilder.h"
#import "NSArray+BlocksKit.h"
#import "ADRFlickrPhoto.h"


static NSString *const kPhotosDictionaryKey = @"photos";
static NSString *const kPhotosArrayKey = @"photo";
static NSString *const kPhotoIdentifierKey = @"id";
static NSString *const kServerKey = @"server";
static NSString *const kFarmKey = @"farm";
static NSString *const kOwnerKey = @"owner";
static NSString *const kPhotoSecretKey = @"secret";
static NSString *const kPhotoTitleKey = @"title";

@implementation ADRFlickrPhotoBuilder
//TODO move all string to constants section
+ (NSArray<ADRFlickrPhoto *> *)photosFromJSONData:(NSData *)jsonData
{
    NSError *jsonParseError = nil;
    NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&jsonParseError];

    if (!responseDict)
    {
        return nil;
    }

    NSDictionary *photosDict = responseDict[kPhotosDictionaryKey];

    if (!photosDict)
    {
        return nil;
    }

    NSArray *photosArray = photosDict[kPhotosArrayKey];

    if (!photosArray)
    {
        return nil;
    }

    NSArray<ADRFlickrPhoto *> *photos = [photosArray bk_map:^ADRFlickrPhoto*(NSDictionary *photoDict) {
        NSUInteger identifier = ((NSString *)photoDict[kPhotoIdentifierKey]).longLongValue;

        if (identifier == 0)
        {
            return nil;
        }

        NSUInteger server = ((NSString *)photoDict[kServerKey]).longLongValue;

        if (server == 0)
        {
            return nil;
        }

        NSUInteger farm = ((NSNumber *)photoDict[kFarmKey]).unsignedIntegerValue;

        if (farm == 0)
        {
            return nil;
        }

        NSString *owner = photoDict[kOwnerKey];

        if (!owner)
        {
            return nil;
        }

        NSString *secret = photoDict[kPhotoSecretKey];

        if (!secret)
        {
            return nil;
        }

        NSString *title = photoDict[kPhotoTitleKey];

        if (!title)
        {
            return nil;
        }

        return [[ADRFlickrPhoto alloc] initWithIdentifier:identifier title:title owner:owner secret:secret server:server farm:farm];
    }];

    return photos;
}

+ (NSArray<ADRFlickrPhoto *> *)photosFromXMLData:(NSData *)xmlData
{
    NSLog(@"Not implemented yet");
    return nil;
}

@end