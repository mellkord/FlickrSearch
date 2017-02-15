//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>

///Protocol for image cell of search results
@protocol ADRSearchResultsImageCellViewModelProtocol <NSObject>

///Title of photo
@property (nonatomic, copy, readonly, nonnull) NSString *title;

///Image of photo
@property (nonatomic, strong, readonly, nonnull) UIImage *image;

@end