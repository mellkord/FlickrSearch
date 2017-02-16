//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import "ADRFlickrSearchHistoryViewModel.h"
#import "ADRSearchHistoryStorage.h"
#import "ADRSearchHistoryItem.h"
#import "AppDelegate.h"
#import "ADRFlickrSearchHistoryTableCellViewModel.h"

@interface ADRFlickrSearchHistoryViewModel ()

@property (nonatomic, strong, readonly, nonnull) ADRSearchHistoryStorage *historyStorage;

@end

@implementation ADRFlickrSearchHistoryViewModel

- (instancetype)init
{
    self = [super init];

    if (self)
    {
        AppDelegate *appDelegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
        _historyStorage = appDelegate.historyStorage;
    }

    return self;
}

- (NSString *)screenTitle
{
    return NSLocalizedString(@"history_screen_title", @"History screen title");
}

- (NSUInteger)historyCount
{
    return self.historyStorage.searchHistories.count;
}

- (NSObject <ADRSearchHistoryTableCellViewModelProtocol> *)modelForHistoryCellAtIndex:(NSUInteger)index
{
    return [[ADRFlickrSearchHistoryTableCellViewModel alloc] initWithSearchString:[self searchStringForHistoryWithIndex:index]
                                                                       dateString:[self dateStringForHistoryWithIndex:index]
                                                                            index:index];
}


- (NSString *)searchStringForHistoryWithIndex:(NSUInteger)index
{
    return self.historyStorage.searchHistories[index].searchString;
}

- (NSString *)dateStringForHistoryWithIndex:(NSUInteger)index
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMM dd, yyyy HH:mm"];

    return [format stringFromDate:self.historyStorage.searchHistories[index].searchDate];
}


@end
