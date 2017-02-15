//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADRSearchResultsLoadingCellViewModelProtocol.h"

///Flickr.com search result loading cell viewmodel
@interface ADRFlickrSearchLoadingCellViewModel : NSObject <ADRSearchResultsLoadingCellViewModelProtocol>

/// Initialization method of ADRFlickrSearchLoadingCellViewModel
/// @param errorMessage error message
/// @return new instance of ADRFlickrSearchLoadingCellViewModel
- (nullable instancetype)initWithErrorMessage:(nullable NSString *)errorMessage;

///Made init and new unavailable to avoid creation without mandatory parameters
+ (nullable instancetype)new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

@end