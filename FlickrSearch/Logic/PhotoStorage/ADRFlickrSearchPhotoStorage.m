//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import "ADRFlickrSearchPhotoStorage.h"
#import "ADRFlickrPhoto.h"
#import "ADRFlickrSearchPhotoStorageDelegate.h"
#import "ADRFlickrNetworkService.h"
#import "ADRFlickrPhotoResourceProtocol.h"


static NSUInteger const kPageSize = 100;

@interface ADRFlickrSearchPhotoStorage ()

@property (nonatomic, strong, readonly, nonnull)    ADRFlickrNetworkService                 *flickrService;
@property (nonatomic, assign, readwrite)            NSUInteger                              currentPage;

@property (nonatomic, strong, readonly, nonnull)    NSCache<NSNumber*, NSNumber*>           *indexCache;
@property (nonatomic, strong, readonly, nonnull)    NSCache<NSNumber*, ADRFlickrPhoto*>     *photoCache;
@property (nonatomic, strong, readonly, nonnull)    NSCache<NSURL *, UIImage*>              *imageCache;

@end


@implementation ADRFlickrSearchPhotoStorage

- (instancetype)initWithSearchString:(NSString *)searchString
                       flickrService:(ADRFlickrNetworkService *)flickrService
                            delegate:(NSObject <ADRFlickrSearchPhotoStorageDelegate> *)delegate
{
    self = [super init];
    if (self)
    {
        _searchString = searchString;
        _flickrService = flickrService;
        _delegate = delegate;
        _currentPage = 1;

        _indexCache = [[NSCache alloc] init];
        _photoCache = [[NSCache alloc] init];
        _imageCache = [[NSCache alloc] init];

    }
    return self;
}

- (ADRFlickrPhoto *)photoByIndex:(NSUInteger)index
{
    NSNumber *photoIdNumber = [self.indexCache objectForKey:@(index)];

    if (!photoIdNumber)
    {
        [self loadMorePhotos];
        return nil;
    }

    return [self photoByIdentifier:photoIdNumber.unsignedLongValue];
}

- (ADRFlickrPhoto *)photoByIdentifier:(NSUInteger)identifier
{
    return [self.photoCache objectForKey:@(identifier)];
}

- (UIImage *)imageByIndex:(NSUInteger)index
{
    ADRFlickrPhoto *photo = [self photoByIndex:index];

    if (!photo)
    {
        return nil;
    }

    return [self imageByURL:[photo imageURL]];
}

- (UIImage *)imageByPhotoIdentifier:(NSUInteger)identifier
{
    ADRFlickrPhoto *photo = [self photoByIdentifier:identifier];

    if (!photo)
    {
        return nil;
    }

    return [self imageByURL:[photo imageURL]];
}

- (UIImage *)imageByURL:(NSURL *)url
{
    UIImage *image = [self.imageCache objectForKey:url];

    if (!image)
    {
        [self loadImageWithURL:url];
    }

    return image;
}


- (void)setSearchString:(NSString *)searchString
{
    _searchString = searchString;

    [self.indexCache removeAllObjects];
    [self.photoCache removeAllObjects];
    [self.imageCache removeAllObjects];
    self.currentPage = 1;
}

- (void)loadMorePhotos
{
    self.currentPage += 1;
    [self.flickrService.photoResource searchPhotosForString:self.searchString completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error)
        {
            NSLog(@"error: %@", error);
            return;
        }

        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (httpResponse.statusCode > 201)
        {
            NSLog(@"http error with code: %d description: %@", httpResponse.statusCode, [NSHTTPURLResponse localizedStringForStatusCode:httpResponse.statusCode]);
            return;
        }

        NSLog(@"ALL FINE Text: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        [self.delegate didReceivePhotosForIndexesInRange:NSMakeRange(0, 5)];
    }];
}

- (void)loadImageWithURL:(NSURL *)url
{
    [self.flickrService.photoResource getImageWithURL:url downloadCompletion:^(NSURL *fileUrl, NSURLResponse *response, NSError *error) {
        if (error)
        {
            NSLog(@"error: %@", error);
            return;
        }

        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (httpResponse.statusCode > 201)
        {
            NSLog(@"http error with code: %d description: %@", httpResponse.statusCode, [NSHTTPURLResponse localizedStringForStatusCode:httpResponse.statusCode]);
            return;
        }

        NSLog(@"ALL FINE Text: %@", fileUrl);
        [self.delegate didReceiveImageForPhotoWithIndex:5];
    }];
}

@end
