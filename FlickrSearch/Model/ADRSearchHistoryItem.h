//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import <Foundation/Foundation.h>

///Object represents one item in search history
@interface ADRSearchHistoryItem : NSObject <NSCoding>

///Search string which was used during search
@property (nonatomic, copy, readonly, nonnull) NSString *searchString;

///Date and time of search
@property (nonatomic, strong, readwrite, nonnull) NSDate *searchDate;

/// Initialization method of ADRSearchHistoryItem
/// @param searchString string which was used during search
/// @param searchDate date and time of search
/// @return new instance of ADRSearchHistoryItem
- (nullable instancetype)initWithSearchString:(nonnull NSString *)searchString searchDate:(nonnull NSDate *)searchDate;

/// Return YES if two items are equal
/// @param searchHistory history item
/// @return YES if equal NO otherwise
- (BOOL)isEqualToSearchHistory:(nonnull ADRSearchHistoryItem *)searchHistory;

///Made init and new unavailable to avoid creation without mandatory parameters
+ (nullable instancetype)new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;


@end