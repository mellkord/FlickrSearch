//
// Created by dmitrii.aitov@philips.com on 16/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ADRSearchHistoryTableCellViewModelProtocol;

///Search history screen view model
@protocol ADRSearchHistoryScreenViewModelProtocol <NSObject>

///Title of the screen
@property (nonatomic, copy, readonly, nonnull) NSString *screenTitle;

///Total count of search history items
@property (nonatomic, assign, readonly) NSUInteger historyCount;

/// Cell view model by index
/// @param index index of cell
/// @return new instance of cell view model
- (nullable NSObject<ADRSearchHistoryTableCellViewModelProtocol> *)modelForHistoryCellAtIndex:(NSUInteger)index;

@end
