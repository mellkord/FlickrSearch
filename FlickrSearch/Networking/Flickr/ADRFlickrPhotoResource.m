//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import "ADRFlickrPhotoResource.h"
#import "ADRNetworkService.h"

static NSString *const kMethodQueryKey       = @"method";
static NSString *const kMethodQueryValue     = @"flickr.photos.search";
static NSString *const kTextQueryKey         = @"text";
static NSString *const kPageQueryKey         = @"page";
static NSString *const kItemsPerPageQueryKey = @"per_page";

@implementation ADRFlickrPhotoResource

- (NSURLSessionTask *)searchPhotosForString:(NSString *)searchString page:(NSUInteger)page photosPerPage:(NSUInteger)photosPerPage completion:(ADRNetworkClientCompletionBlock)completion;
{
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:self.networkService.baseURL resolvingAgainstBaseURL:YES];
    urlComponents.queryItems = @[[NSURLQueryItem queryItemWithName:kMethodQueryKey value:kMethodQueryValue]];
    urlComponents.queryItems = [urlComponents.queryItems arrayByAddingObject:[NSURLQueryItem queryItemWithName:kTextQueryKey value:searchString]];
    urlComponents.queryItems = [urlComponents.queryItems arrayByAddingObject:[NSURLQueryItem queryItemWithName:kPageQueryKey value:[NSString stringWithFormat:@"%lu", page]]];
    urlComponents.queryItems = [urlComponents.queryItems arrayByAddingObject:[NSURLQueryItem queryItemWithName:kItemsPerPageQueryKey value:[NSString stringWithFormat:@"%lu", photosPerPage]]];

    [self.networkService addParametersToURLComponents:urlComponents];

    NSURLRequest *request = [NSURLRequest requestWithURL:urlComponents.URL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10 * 1000];

    return [self.networkService.networkCLient executeRequest:request completion:completion];
}

- (NSURLSessionTask *)getInfoForPhotoId:(NSString *)photoId completion:(ADRNetworkClientCompletionBlock)completion
{
    DDLogError(@"Not implemented yet");
    return nil;
}

- (NSURLSessionTask *)getSizesForPhotoId:(NSString *)photoId completion:(ADRNetworkClientCompletionBlock)completion
{
    DDLogError(@"Not implemented yet");
    return nil;
}

- (NSURLSessionTask *)getFavoritesForPhotoId:(NSString *)photoId completion:(ADRNetworkClientCompletionBlock)completion
{
    DDLogError(@"Not implemented yet");
    return nil;
}

- (NSURLSessionTask *)getImageWithURL:(NSURL *)url downloadCompletion:(ADRNetworkClientDownloadCompletionBlock)downloadCompletion
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:10 * 1000];
    return [self.networkService.networkCLient executeRequest:request downloadCompletion:downloadCompletion];
}

@end