//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import "ADRFlickrNetworkService.h"
#import "ADRFlickrPhotoResourceProtocol.h"
#import "ADRFlickrPhotoResource.h"


static NSString *const kApiKeyQueryKey = @"api_key";
static NSString *const kFormatQueryKey = @"format";
static NSString *const kCallbackQueryKey = @"nojsoncallback";
static NSString *const kFormatQueryValue = @"json";
static NSString *const kCallbackQueryValue = @"1";

///Base url to flickr.com REST API
static NSURL *kFlickrBaseURL = nil;

@interface ADRFlickrNetworkService ()

///Key to access flick.com REST API
@property (nonatomic, copy, readonly, nonnull) NSString *apiKey;

@end

@implementation ADRFlickrNetworkService

+ (void)initialize
{
    if(!kFlickrBaseURL)
    {
        kFlickrBaseURL = [[NSURL alloc] initWithString:@"https://api.flickr.com/services/rest/"];
    }
}

- (instancetype)initWithAPIKey:(NSString *)apiKey networkClient:(NSObject <ADRNetworkClientProtocol> *)networkClient
{
    self = [super initWithBaseURL:kFlickrBaseURL networkClient:networkClient];

    if (self)
    {
        _apiKey = apiKey;
    }

    return self;
}

- (void)addParametersToURLComponents:(NSURLComponents *)urlComponents
{
    ///TODO move string to constants
    urlComponents.queryItems = [urlComponents.queryItems arrayByAddingObject:[NSURLQueryItem queryItemWithName:kApiKeyQueryKey value:self.apiKey]];
    urlComponents.queryItems = [urlComponents.queryItems arrayByAddingObject:[NSURLQueryItem queryItemWithName:kFormatQueryKey value:kFormatQueryValue]];
    urlComponents.queryItems = [urlComponents.queryItems arrayByAddingObject:[NSURLQueryItem queryItemWithName:kCallbackQueryKey value:kCallbackQueryValue]];
}

- (void)addHeadersToURLRequest:(NSMutableURLRequest *)urlRequest
{

}

- (NSObject <ADRFlickrPhotoResourceProtocol> *)photoResource
{
    static ADRFlickrPhotoResource *photoResource = nil;
    if (!photoResource)
    {
        photoResource = [[ADRFlickrPhotoResource alloc] initWithService:self];
    }

    return photoResource;
}