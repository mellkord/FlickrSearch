//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import "ADRFlickrSearchViewModel.h"


@implementation ADRFlickrSearchViewModel

- (NSString *)searchTextFieldPlaceholder
{
    return NSLocalizedString(@"search_text_field_placeholder", @"Placeholder for search text field");
}

- (NSString *)searchButtonTitle
{
    return NSLocalizedString(@"search_button_title", @"Title of search button");
}

- (NSString *)historyButtonTitle
{
    return NSLocalizedString(@"search_button_title", @"Title of history button");
}

- (BOOL)historyButtonEnable
{
    //TODO check local storage
    return NO;
}

- (BOOL)historyButtonVisiable
{
    //TODO check local storage
    return NO;
}

- (UIColor *)backgroundColor
{
    return UIColor.whiteColor;
}

@end