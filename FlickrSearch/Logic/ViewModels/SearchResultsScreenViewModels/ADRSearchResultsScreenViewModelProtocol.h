//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UICollectionView.h>

@protocol ADRSearchResultsImageCellViewModelProtocol;
@protocol ADRSearchResultsLoadingCellViewModelProtocol;

///Protocol for view model of search results screen
@protocol ADRSearchResultsScreenViewModelProtocol <NSObject>

///Search string
@property (nonatomic, copy, readonly, nonnull) NSString *searchString;

///Current number of loaded photos
@property (nonatomic, assign, readonly) NSUInteger photosCount;

///Collection view to update after receiving results from backend
@property (nonatomic, weak, readwrite, nullable) UICollectionView *collectionView;

/// View model object for image cell
/// @param index index of cell
/// @return new instance of image cell view model
- (nullable NSObject<ADRSearchResultsImageCellViewModelProtocol> *)modelForImageCellAtIndex:(NSUInteger)index;

/// View model object for loading cell
/// @return new instance of loading cell view model
- (nonnull NSObject<ADRSearchResultsLoadingCellViewModelProtocol> *)modelForLoadingCell;

@end
