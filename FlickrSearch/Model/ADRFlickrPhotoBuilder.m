//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import "ADRFlickrPhotoBuilder.h"
#import "NSArray+BlocksKit.h"
#import "ADRFlickrPhoto.h"


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
        NSUInteger identifier = ((NSString *)photoDict[@"id"]).longLongValue;

        if (identifier == 0)
        {
            return nil;
        }

        NSUInteger server = ((NSString *)photoDict[@"server"]).longLongValue;

        if (server == 0)
        {
            return nil;
        }

        NSUInteger farm = ((NSNumber *)photoDict[@"farm"]).unsignedIntegerValue;

        if (farm == 0)
        {
            return nil;
        }

        NSString *owner = photoDict[@"owner"];

        if (!owner)
        {
            return nil;
        }

        NSString *secret = photoDict[@"secret"];

        if (!secret)
        {
            return nil;
        }

        NSString *title = photoDict[@"title"];

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