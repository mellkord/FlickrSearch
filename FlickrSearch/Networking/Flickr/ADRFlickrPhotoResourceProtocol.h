//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADRNetworkClientProtocol.h"

///Protocol describing API of photo resource of flickr.com
@protocol ADRFlickrPhotoResourceProtocol
@required

/// Search photos on flickr.com by provided search string
/// @param searchString search string
/// @param page current page to fetch
/// @param photosPerPage number of photos per page
/// @param completion block to execute after request finish execution
/// @return instance of session task associated with search
- (NSURLSessionTask *)searchPhotosForString:(NSString *)searchString page:(NSUInteger)page photosPerPage:(NSUInteger)photosPerPage completion:(ADRNetworkClientCompletionBlock)completion;

/// Get information about photo on flickr.com by provided photo identifier
/// @param photoId identifier of photo
/// @param completion block to execute after request finish execution
/// @return instance of session task associated with request
- (NSURLSessionTask *)getInfoForPhotoId:(NSString *)photoId completion:(ADRNetworkClientCompletionBlock)completion;

/// Get urls to different sizes of photo on flickr.com by provided photo identifier
/// @param photoId identifier of photo
/// @param completion block to execute after request finish execution
/// @return instance of session task associated with request
- (NSURLSessionTask *)getSizesForPhotoId:(NSString *)photoId completion:(ADRNetworkClientCompletionBlock)completion;

/// Get identifiers of people who favorite photo on flickr.com by provided photo identifier
/// @param photoId identifier of photo
/// @param completion block to execute after request finish execution
/// @return instance of session task associated with request
- (NSURLSessionTask *)getFavoritesForPhotoId:(NSString *)photoId completion:(ADRNetworkClientCompletionBlock)completion;

/// Download image from flickr.com by specified url
/// @param url url of image to download
/// @param downloadCompletion block to execute after request finish execution
/// @return instance of session task associated with download request
- (NSURLSessionTask *)getImageWithURL:(NSURL *)url downloadCompletion:(ADRNetworkClientDownloadCompletionBlock)downloadCompletion;

@end
