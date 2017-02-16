//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import "ADRSearchHistoryItem.h"


static NSString * const kSearchStringCodingKey = @"searchString";
static NSString * const kSearchDateCodingKey = @"searchDate";

@implementation ADRSearchHistoryItem

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];

    if (self)
    {
        _searchString = [coder decodeObjectForKey:kSearchStringCodingKey];
        _searchDate = [coder decodeObjectForKey:kSearchDateCodingKey];
    }

    return self;
}


- (instancetype)initWithSearchString:(NSString *)searchString searchDate:(NSDate *)searchDate
{
    self = [super init];

    if (self)
    {
        _searchString = searchString;
        _searchDate = searchDate;
    }

    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.searchString forKey:kSearchStringCodingKey];
    [coder encodeObject:self.searchDate forKey:kSearchDateCodingKey];
}

- (BOOL)isEqual:(id)object
{
    return [self isEqualToSearchHistory:(ADRSearchHistoryItem *)object];
}

- (BOOL)isEqualToSearchHistory:(ADRSearchHistoryItem *)searchHistory
{
    if (searchHistory == self)
    {
        return YES;
    }

    if ([searchHistory class] != [self class])
    {
        return NO;
    }

    if (![searchHistory.searchString isEqualToString:self.searchString])
    {
        return NO;
    }

    if (![searchHistory.searchDate isEqualToDate:self.searchDate])
    {
        return NO;
    }

    return YES;
}

- (NSUInteger)hash
{
    return self.searchString.hash ^ self.searchDate.hash;
}

@end