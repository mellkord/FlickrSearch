//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ADRSearchHistoryItem;

///Search history storage
@interface ADRSearchHistoryStorage : NSObject

///All search history items
@property (nonatomic, strong, readonly, nonnull) NSArray<ADRSearchHistoryItem *> *searchHistories;

/// Adds history item to storage and persist it in file
/// @param searchHistory search history item
- (void)addSearchHistory:(nonnull ADRSearchHistoryItem *)searchHistory;

/// Removes history item from storage and persist changes in file
/// @param searchHistory search history item
- (void)removeSearchHistory:(nonnull ADRSearchHistoryItem *)searchHistory;

/// Update history items from local storage
- (void)updateHistory;

@end
