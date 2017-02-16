//
// Created by dmitrii.aitov@philips.com on 16/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import "ADRFlickrSearchHistoryTableCellViewModel.h"

@interface ADRFlickrSearchHistoryTableCellViewModel ()

@property (nonatomic, copy, readwrite, nonnull) NSString *searchString;
@property (nonatomic, copy, readwrite, nonnull) NSString *dateString;
@property (nonatomic, strong, readwrite, nonnull) UIColor *backgroundColor;

@end

@implementation ADRFlickrSearchHistoryTableCellViewModel

- (instancetype)initWithSearchString:(NSString *)searchString dateString:(NSString *)dateString index:(NSUInteger)index
{
    self = [super init];

    if (self)
    {
        _searchString = searchString;
        _dateString = dateString;
        _backgroundColor = (index % 2 == 0)
                ?[UIColor colorWithRed:255.0f/255.0f green:0.0f/255.0f blue:132.0f/255.0f alpha:0.1f]
                :[UIColor colorWithRed:0.0f/255.0f green:99.0f/255.0f blue:219.0f/255.0f alpha:0.1f];
    }

    return self;
}

@end