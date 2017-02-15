//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import "ADRFlickrSearchPhotoStorage.h"
#import "ADRFlickrPhoto.h"
#import "ADRFlickrSearchPhotoStorageDelegate.h"
#import "ADRFlickrNetworkService.h"
#import "ADRFlickrPhotoResourceProtocol.h"
#import "ADRFlickrPhotoBuilder.h"


static NSUInteger const kPageSize = 100;

@interface ADRFlickrSearchPhotoStorage ()

@property (nonatomic, strong, readonly, nonnull)    ADRFlickrNetworkService                 *flickrService;
@property (nonatomic, assign, readwrite)            NSUInteger                              currentPage;

@property (nonatomic, strong, readonly, nonnull)    NSCache<NSNumber*, NSNumber*>           *indexCache;
@property (nonatomic, strong, readonly, nonnull)    NSCache<NSNumber*, ADRFlickrPhoto*>     *photoCache;
@property (nonatomic, strong, readonly, nonnull)    NSCache<NSURL *, UIImage*>              *imageCache;
@property (nonatomic, strong, readonly, nonnull)    NSCache<NSURL *, NSNumber*>             *urlCache;

@property (nonatomic, assign, readwrite) NSUInteger photosCount;
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
        _currentPage = 0;

        _indexCache = [[NSCache alloc] init];
        _photoCache = [[NSCache alloc] init];
        _imageCache = [[NSCache alloc] init];
        _urlCache = [[NSCache alloc] init];

    }
    return self;
}

- (ADRFlickrPhoto *)photoByIndex:(NSUInteger)index
{
    if (index >= self.currentPage * kPageSize)
    {
        [self loadMorePhotos];
    }

    NSNumber *photoIdNumber = [self.indexCache objectForKey:@(index)];

    if (!photoIdNumber)
    {
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

    [self.urlCache setObject:@(index) forKey:[photo imageURL]];

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
    self.currentPage = 0;
}

- (void)loadMorePhotos
{
    self.currentPage++;
    [self.flickrService.photoResource searchPhotosForString:self.searchString page:self.currentPage photosPerPage:kPageSize completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error)
        {
            NSLog(@"error: %@", error);
            return;
        }

        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (httpResponse.statusCode > 200)
        {
            NSLog(@"http error with code: %ld description: %@", (long)httpResponse.statusCode, [NSHTTPURLResponse localizedStringForStatusCode:httpResponse.statusCode]);
            return;
        }


        NSArray<ADRFlickrPhoto *> *photos = [ADRFlickrPhotoBuilder photosFromJSONData:data];

        NSRange addedRange = NSMakeRange(self.photosCount, photos.count);

        [photos enumerateObjectsUsingBlock:^(ADRFlickrPhoto *photo, NSUInteger idx, BOOL *stop) {
            if ((NSNull *)photo == [NSNull null])
            {
                return;
            }

            [self.indexCache setObject:@(photo.identifier) forKey:@(self.photosCount)];
            [self.photoCache setObject:photos[idx] forKey:@(photos[idx].identifier)];
            self.photosCount++;
        }];

        [self.delegate didReceivePhotosForIndexesInRange:addedRange];
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
            NSLog(@"http error with code: %ld description: %@", (long)httpResponse.statusCode, [NSHTTPURLResponse localizedStringForStatusCode:httpResponse.statusCode]);
            return;
        }

        if (![NSFileManager.defaultManager fileExistsAtPath:fileUrl.path])
        {
            NSLog(@"error file doesnt exists at url: %@", url);
            return;
        }

        UIImage *image = [UIImage imageWithContentsOfFile:fileUrl.path];
        if (!image)
        {
            NSLog(@"error couldn't create file from url: %@", url);
            return;
        }

        [self.imageCache setObject:image forKey:url];

        [self.delegate didReceiveImageForPhotoWithIndex:[self.urlCache objectForKey:url].unsignedIntegerValue];
    }];
}

@end
