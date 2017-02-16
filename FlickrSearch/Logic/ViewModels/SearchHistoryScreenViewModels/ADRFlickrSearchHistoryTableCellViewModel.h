//
// Created by dmitrii.aitov@philips.com on 16/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADRSearchHistoryTableCellViewModelProtocol.h"


@interface ADRFlickrSearchHistoryTableCellViewModel : NSObject <ADRSearchHistoryTableCellViewModelProtocol>

/// Initialization method of ADRFlickrSearchHistoryTableCellViewModel
/// @param searchString string used for serch
/// @param dateString search date string
/// @param index index of history item
/// @return new instance of ADRFlickrSearchHistoryTableCellViewModel
- (nullable instancetype)initWithSearchString:(nonnull NSString *)searchString
                                   dateString:(nonnull NSString *)dateString
                                        index:(NSUInteger)index;

///Made init and new unavailable to avoid creation without mandatory parameters
+ (nullable instancetype)new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

@end