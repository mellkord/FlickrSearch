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

- (instancetype)initWithSearchString:(NSString *)searchString photoStorage:(ADRFlickrSearchPhotoStorage *)storage
{
    self = [super init];

    if (self)
    {
        _searchString = searchString;
        _storage = storage;
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
        image = [UIImage imageNamed:@"downloading_placeholder"];
    }

    return [[ADRFlickrSearchImageCellViewModel alloc] initWithPhoto:photo image:image];
}

- (ADRFlickrSearchLoadingCellViewModel *)modelForLoadingCell
{
    return [[ADRFlickrSearchLoadingCellViewModel alloc] initWithErrorMessage:nil];
}

@end