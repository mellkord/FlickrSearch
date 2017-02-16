//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import "ADRFlickrSearchResultsViewModel.h"
#import "ADRFlickrSearchPhotoStorage.h"
#import "ADRFlickrPhoto.h"
#import "ADRFlickrSearchLoadingCellViewModel.h"
#import "ADRFlickrSearchImageCellViewModel.h"

@interface ADRFlickrSearchResultsViewModel ()

@property (nonatomic, copy, readwrite, nonnull) NSString *searchString;
@property (nonatomic, strong, readonly, nonnull) ADRFlickrSearchPhotoStorage *storage;

@end

@implementation ADRFlickrSearchResultsViewModel
@synthesize collectionView = _collectionView;

- (instancetype)initWithSearchString:(NSString *)searchString photoStorage:(ADRFlickrSearchPhotoStorage *)storage
{
    self = [super init];

    if (self)
    {
        _searchString = searchString;
        _storage = storage;
        _storage.delegate = self;
    }

    return self;
}

- (ADRFlickrSearchImageCellViewModel *)modelForImageCellAtIndex:(NSUInteger)index
{
    ADRFlickrPhoto *photo = [self.storage photoByIndex:index];

    if (!photo)
    {
        return nil;
    }

    UIImage *image = [self.storage imageByIndex:index];

    if (!image)
    {
        image = [UIImage imageNamed:@"Downloading"];
    }

    return [[ADRFlickrSearchImageCellViewModel alloc] initWithPhoto:photo image:image];
}

- (ADRFlickrSearchLoadingCellViewModel *)modelForLoadingCell
{
    return [[ADRFlickrSearchLoadingCellViewModel alloc] initWithErrorMessage:nil];
}

- (NSUInteger)photosCount
{
    return self.storage.photosCount;
}

- (void)didReceivePhotosForIndexesInRange:(NSRange)range
{
    [self.collectionView reloadData];
}

- (void)didReceiveImageForPhotoWithIndex:(NSUInteger)index
{
    [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:index inSection:0]]];
}

@end