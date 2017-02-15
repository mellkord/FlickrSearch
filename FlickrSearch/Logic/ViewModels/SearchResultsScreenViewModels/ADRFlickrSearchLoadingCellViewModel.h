//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import <Foundation/Foundation.h>

///TODO Docs
@interface ADRFlickrSearchLoadingCellViewModel : NSObject

@property (nonatomic, assign, readonly, getter=isLoading) BOOL loading;
@property (nonatomic, copy, readonly, nullable) NSString *errorMessage;

- (nullable instancetype)initWithErrorMessage:(nullable NSString *)errorMessage;

@end