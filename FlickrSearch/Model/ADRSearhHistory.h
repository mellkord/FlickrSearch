//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import <Foundation/Foundation.h>

//TODO Docs
@interface ADRSearhHistory : NSObject <NSCoding>

@property (nonatomic, copy, readonly, nonnull) NSString *searchString;
@property (nonatomic, strong, readwrite, nonnull) NSDate *lastSearchDate;

- (nullable instancetype)initWithSearchString:(nonnull NSString *)searchString searchDate:(nonnull NSDate *)searchDate;

///Made init and new unavailable to avoid creation without mandatory parameters
+ (nullable instancetype)new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;


@end