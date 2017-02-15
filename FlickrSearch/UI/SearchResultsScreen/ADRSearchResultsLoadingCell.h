//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ADRSearchResultsLoadingCellViewModelProtocol;

///Search results loading cell
@interface ADRSearchResultsLoadingCell : UICollectionViewCell

///View model of loading cell
@property (nonatomic, strong, readwrite, nonnull) NSObject<ADRSearchResultsLoadingCellViewModelProtocol> *viewModel;

@end