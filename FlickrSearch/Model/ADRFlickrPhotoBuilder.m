//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import "ADRFlickrPhotoBuilder.h"
#import "NSArray+BlocksKit.h"
#import "ADRFlickrPhoto.h"


@implementation ADRFlickrPhotoBuilder

+ (NSArray<ADRFlickrPhoto *> *)photosFromJSONData:(NSData *)jsonData
{
    NSError *jsonParseError = nil;
    NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&jsonParseError];

    if (!responseDict)
    {
        return nil;
    }

    NSDictionary *photosDict = responseDict[@"photos"];

    if (!photosDict)
    {
        return nil;
    }

    NSArray *photosArray = photosDict[@"photo"];

    if (!photosArray)
    {
        return nil;
    }

    NSArray<ADRFlickrPhoto *> *photos = [photosArray bk_map:^ADRFlickrPhoto*(NSDictionary *photoDict) {
        NSUInteger identifier = ((NSNumber *)photosDict[@"id"]).unsignedIntegerValue;

        if (identifier == 0)
        {
            return nil;
        }

        NSUInteger server = ((NSNumber *)photosDict[@"server"]).unsignedIntegerValue;

        if (server == 0)
        {
            return nil;
        }

        NSUInteger farm = ((NSNumber *)photosDict[@"farm"]).unsignedIntegerValue;

        if (farm == 0)
        {
            return nil;
        }

        NSString *owner = photosDict[@"owner"];

        if (!owner)
        {
            return nil;
        }

        NSString *secret = photosDict[@"secret"];

        if (!secret)
        {
            return nil;
        }

        NSString *title = photosDict[@"title"];

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