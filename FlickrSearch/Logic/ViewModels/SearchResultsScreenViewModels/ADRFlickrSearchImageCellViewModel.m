//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import "ADRFlickrSearchImageCellViewModel.h"
#import "ADRFlickrPhoto.h"

@interface ADRFlickrSearchImageCellViewModel ()

@property (nonatomic, copy, readwrite, nonnull) NSString *title;
@property (nonatomic, strong, readwrite, nonnull) UIImage *image;

@end

@implementation ADRFlickrSearchImageCellViewModel

- (instancetype)initWithPhoto:(ADRFlickrPhoto *)photo image:(UIImage *)image
{
    self = [super init];

    if (self)
    {
        _title = photo.title;
        _image = image;
    }

    return self;
}

@end