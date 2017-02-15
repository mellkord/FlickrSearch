//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import "ADRFlickrPhotoResource.h"
#import "ADRNetworkService.h"


@implementation ADRFlickrPhotoResource

- (NSURLSessionTask *)searchPhotosForString:(NSString *)searchString completion:(ADRNetworkClientCompletionBlock)completion
{
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:self.networkService.baseURL resolvingAgainstBaseURL:YES];
    urlComponents.queryItems = @[[NSURLQueryItem queryItemWithName:@"method" value:@"flickr.photos.search"]];
    urlComponents.queryItems = [urlComponents.queryItems arrayByAddingObject:[NSURLQueryItem queryItemWithName:@"text" value:searchString]];

    [self.networkService addParametersToURLComponents:urlComponents];

    NSURLRequest *request = [NSURLRequest requestWithURL:urlComponents.URL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];

    return [self.networkService.networkCLient executeRequest:request completion:completion];
}

- (NSURLSessionTask *)getInfoForPhotoId:(NSString *)photoId completion:(ADRNetworkClientCompletionBlock)completion
{
    NSLog(@"Not implemented yet");
    return nil;
}

- (NSURLSessionTask *)getSizesForPhotoId:(NSString *)photoId completion:(ADRNetworkClientCompletionBlock)completion
{
    NSLog(@"Not implemented yet");
    return nil;
}

- (NSURLSessionTask *)getFavoritesForPhotoId:(NSString *)photoId completion:(ADRNetworkClientCompletionBlock)completion
{
    NSLog(@"Not implemented yet");
    return nil;
}

- (NSURLSessionTask *)getImageWithURL:(NSURL *)url downloadCompletion:(ADRNetworkClientDownloadCompletionBlock)downloadCompletion
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:10];
    return [self.networkService.networkCLient executeRequest:request downloadCompletion:downloadCompletion];
}

@end