//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import <Foundation/Foundation.h>

///TODO Docs
@protocol ADRFlickrSearchPhotoStorageDelegate <NSObject>

- (void)didReceivePhotosForIndexesInRange:(NSRange)range;
- (void)didReceiveImageForPhotoWithIndex:(NSUInteger)index;

@end