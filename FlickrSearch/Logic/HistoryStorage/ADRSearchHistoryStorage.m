//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import "ADRSearchHistoryStorage.h"
#import "ADRSearchHistoryItem.h"
#import "BlocksKit.h"


static NSString *const kHistoriesFileName = @"histories.dat";

@interface ADRSearchHistoryStorage ()

@property (nonatomic, strong, readwrite, nonnull) NSArray<ADRSearchHistoryItem *> *searchHistories;
@property (nonatomic, copy, readonly, nonnull) NSString *historiesFilePath;

@end

@implementation ADRSearchHistoryStorage

- (instancetype)init
{
    self = [super init];

    if (self)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = paths.firstObject;

        _historiesFilePath = [documentsDirectory stringByAppendingPathComponent:kHistoriesFileName];
        _searchHistories = [NSKeyedUnarchiver unarchiveObjectWithFile:_historiesFilePath];

        if (!_searchHistories)
        {
            _searchHistories = [[NSArray alloc] init];
        }
    }

    return self;
}

- (void)addSearchHistory:(ADRSearchHistoryItem *)searchHistory
{
    if ([self.searchHistories bk_match:^BOOL(ADRSearchHistoryItem *obj) {
        return [obj isEqualToSearchHistory:searchHistory];
    }])
    {
        return;
    }
    
    self.searchHistories = [self.searchHistories arrayByAddingObject:searchHistory];
    [self save];
}

- (void)removeSearchHistory:(ADRSearchHistoryItem *)searchHistory
{
    self.searchHistories = [self.searchHistories bk_reject:^BOOL(ADRSearchHistoryItem *obj) {
        return [obj isEqualToSearchHistory:searchHistory];
    }];
    [self save];
}

- (void)updateHistory
{
    self.searchHistories = [NSKeyedUnarchiver unarchiveObjectWithFile:_historiesFilePath];
    
    if (!self.searchHistories)
    {
        self.searchHistories = [[NSArray alloc] init];
    }
}

- (void)save
{
    [NSKeyedArchiver archiveRootObject:self.searchHistories toFile:self.historiesFilePath];
}

@end
