//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ADRSearchScreenViewModelProtocol;

@interface ADRSearchViewController : UIViewController

- (nullable instancetype)initWithViewModel:(nonnull NSObject<ADRSearchScreenViewModelProtocol> *)viewModel;

@end
