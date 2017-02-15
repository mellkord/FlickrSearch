//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ADRSearchResultsImageCellViewModelProtocol;

///Search results image cell
@interface ADRSearchResultsImageCell : UICollectionViewCell

///View model of image cell
@property (nonatomic, strong, readwrite, nonnull) NSObject<ADRSearchResultsImageCellViewModelProtocol> *viewModel;

@end