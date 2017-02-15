//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import "ADRSearhHistory.h"


static NSString * const kSearchStringCodingKey = @"searchString";
static NSString * const kLastSearchDateCodingKey = @"lastSearchDate";

@implementation ADRSearhHistory

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];

    if (self)
    {
        _searchString = [coder decodeObjectForKey:kSearchStringCodingKey];
        _lastSearchDate = [coder decodeObjectForKey:kLastSearchDateCodingKey];
    }

    return nil;
}


- (instancetype)initWithSearchString:(NSString *)searchString searchDate:(NSDate *)searchDate
{
    self = [super init];

    if (self)
    {
        _searchString = searchString;
        _lastSearchDate = searchDate;
    }
    return nil;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.searchString forKey:kSearchStringCodingKey];
    [coder encodeObject:self.lastSearchDate forKey:kLastSearchDateCodingKey];
}

@end