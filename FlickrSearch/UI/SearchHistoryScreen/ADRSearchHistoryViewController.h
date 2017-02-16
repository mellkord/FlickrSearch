//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ADRSearchHistoryScreenViewModelProtocol;

///Search history view controller
@interface ADRSearchHistoryViewController : UITableViewController

/// Initialization method of ADRSearchHistoryViewController
/// @param viewModel search history view controller view model
/// @return new instance of ADRSearchHistoryViewController
- (nullable instancetype)initWithViewModel:(nonnull NSObject<ADRSearchHistoryScreenViewModelProtocol> *)viewModel;

///Made init and new unavailable to avoid creation without mandatory parameters
+ (nullable instancetype)new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

@end
