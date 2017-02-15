//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ADRFlickrSearchPhotoStorage;
@class ADRFlickrSearchImageCellViewModel;
@class ADRFlickrSearchLoadingCellViewModel;

@interface ADRFlickrSearchResultsViewModel : NSObject

@property (nonatomic, copy, readonly, nonnull) NSString *searchString;
@property (nonatomic, assign, readonly) NSUInteger photosCount;

- (nullable instancetype)initWithSearchString:(nonnull NSString *)searchString photoStorage:(nonnull ADRFlickrSearchPhotoStorage *)storage;

- (nullable ADRFlickrSearchImageCellViewModel *)modelForImageCellAtIndex:(NSUInteger)index;
- (nonnull ADRFlickrSearchLoadingCellViewModel *)modelForLoadingCell;

@end