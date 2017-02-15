//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import "UIKit/UIKit.h"

@protocol ADRSearchResultsScreenViewModelProtocol;

///Search results view controller
@interface ADRSearchResultsViewController : UICollectionViewController

/// Initialization method of search results view controller
/// @param viewModel view model of search results view controller
/// @return new instance of ADRSearchResultsViewController
- (nullable instancetype)initWithViewModel:(nonnull NSObject<ADRSearchResultsScreenViewModelProtocol> *)viewModel;

///Made init and new unavailable to avoid creation without mandatory parameters
+ (nullable instancetype)new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

@end
