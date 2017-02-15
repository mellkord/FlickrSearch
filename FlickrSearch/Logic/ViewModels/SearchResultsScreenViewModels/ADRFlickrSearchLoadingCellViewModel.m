//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import "ADRFlickrSearchLoadingCellViewModel.h"


@interface ADRFlickrSearchLoadingCellViewModel ()

@property (nonatomic, assign, readwrite, getter=isLoading) BOOL loading;
@property (nonatomic, copy, readwrite, nullable) NSString *errorMessage;

@end

@implementation ADRFlickrSearchLoadingCellViewModel

- (instancetype)initWithErrorMessage:(NSString *)errorMessage
{
    self = [super init];

    if (self)
    {
        if (!errorMessage)
        {
            _loading = YES;
        }
        else
        {
            _errorMessage = errorMessage;
        }
    }

    return nil;
}


@end