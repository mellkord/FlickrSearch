//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>

@class ADRFlickrPhoto;

///TODO Docs
@interface ADRFlickrSearchImageCellViewModel : NSObject

@property (nonatomic, copy, readonly, nonnull) NSString *title;
@property (nonatomic, strong, readonly, nonnull) UIImage *image;

- (nullable instancetype)initWithPhoto:(nonnull ADRFlickrPhoto *)photo image:(nonnull UIImage *)image;

@end