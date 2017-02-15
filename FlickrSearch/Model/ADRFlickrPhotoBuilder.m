//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import "ADRFlickrPhotoBuilder.h"


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

    //map from BlocksKit
    return nil;
}

+ (NSArray<ADRFlickrPhoto *> *)photosFromXMLData:(NSData *)xmlData
{
    NSLog(@"Not implemented yet");
    return nil;
}

@end