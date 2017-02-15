//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ADRSearchScreenViewModelProtocol;

///Search view controller
@interface ADRSearchViewController : UIViewController

/// Initialization method of search view controller
/// @param viewModel view model of search view controller
/// @return new instance of ADRSearchViewController
- (nullable instancetype)initWithViewModel:(nonnull NSObject<ADRSearchScreenViewModelProtocol> *)viewModel;

///Made init and new unavailable to avoid creation without mandatory parameters
+ (nullable instancetype)new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

@end
