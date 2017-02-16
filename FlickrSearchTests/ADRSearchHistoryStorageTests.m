//
//  ADRSearchHistoryStorageTests.m
//  FlickrSearch
//
//  Created by dmitrii.aitov@philips.com on 16/02/17.
//  Copyright © 2017 Dmitrii Aitov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ADRSearchHistoryStorage.h"
#import "ADRSearchHistoryItem.h"

#include <stdlib.h>

static NSString *const kHistoriesFileName = @"histories.dat";

@interface ADRSearchHistoryStorageTests : XCTestCase
@property (nonatomic, strong, readwrite, nonnull) ADRSearchHistoryStorage *historyStorage;
@end

@implementation ADRSearchHistoryStorageTests

+ (void)setUp
{
    [super setUp];
}

- (void)setUp
{
    [super setUp];
    [self.class cleanHistory];
    self.historyStorage = [[ADRSearchHistoryStorage alloc] init];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testAddHistoryItem
{
    NSString *searchString = @"Cat";
    NSDate *searchDate = [NSDate dateWithTimeIntervalSince1970:0];
    ADRSearchHistoryItem *item = [[ADRSearchHistoryItem alloc] initWithSearchString:searchString searchDate:searchDate];
    [self.historyStorage addSearchHistory:item];
    
    XCTAssertTrue(self.historyStorage.searchHistories.count == 1, @"Should be only one item in storage");
    
    XCTAssertEqualObjects(self.historyStorage.searchHistories.firstObject.searchString, searchString, @"Search string should be equal to Cat");
    XCTAssertEqualObjects(self.historyStorage.searchHistories.firstObject.searchDate, searchDate, @"Search date should be equal to 1970");
}

- (void)testCantAddTwoSameHistoryItems
{
    NSString *searchString = @"Cat";
    NSDate *searchDate = [NSDate dateWithTimeIntervalSince1970:0];
    ADRSearchHistoryItem *item = [[ADRSearchHistoryItem alloc] initWithSearchString:searchString searchDate:searchDate];
    
    [self.historyStorage addSearchHistory:item];
    [self.historyStorage addSearchHistory:item];
    
    XCTAssertTrue(self.historyStorage.searchHistories.count == 1, @"Should be only one item in storage");
}

- (void)testRemoveHistoryItem
{
    NSString *searchString = @"Cat";
    NSDate *searchDate = [NSDate dateWithTimeIntervalSince1970:0];
    ADRSearchHistoryItem *item = [[ADRSearchHistoryItem alloc] initWithSearchString:searchString searchDate:searchDate];
    [self.historyStorage addSearchHistory:item];
    
    XCTAssertTrue(self.historyStorage.searchHistories.count == 1, @"Should be only one item in storage");
    
    [self.historyStorage removeSearchHistory:item];
    
    XCTAssertTrue(self.historyStorage.searchHistories.count == 0, @"Should be zero items in storage");
}

- (void)testCountOfHystoryItems
{
    int addItemsCount = arc4random_uniform(100);
    int removeItemsCount = arc4random_uniform(addItemsCount);

    NSMutableArray *tmpItems = [NSMutableArray array];
    
    for (int i = 0; i < addItemsCount; i++)
    {
        ADRSearchHistoryItem *newItem = [self createHistoryItem];
        [tmpItems addObject:newItem];
        [self.historyStorage addSearchHistory:newItem];
    }
    
    XCTAssertTrue(self.historyStorage.searchHistories.count == addItemsCount, @"Should be same as addItemsCount items in storage");
    
    for (int i = 0; i < removeItemsCount; i++)
    {
        [self.historyStorage removeSearchHistory:tmpItems[i]];
    }
    
    XCTAssertTrue(self.historyStorage.searchHistories.count == (addItemsCount - removeItemsCount), @"Should be same as (addItemsCount - removeItemsCount) items in storage");
}

- (void)testPersistanceOfHistoryItesm
{
    int addItemsCount = arc4random_uniform(100);
    
    NSMutableArray *tmpItems = [NSMutableArray array];
    
    for (int i = 0; i < addItemsCount; i++)
    {
        ADRSearchHistoryItem *newItem = [self createHistoryItem];
        [tmpItems addObject:newItem];
        [self.historyStorage addSearchHistory:newItem];
    }
    
    //new one reads from same file
    ADRSearchHistoryStorage *newHistoryStorage = [[ADRSearchHistoryStorage alloc] init];
    
    XCTAssertTrue(newHistoryStorage.searchHistories.count == self.historyStorage.searchHistories.count, @"Should be same items in both storage");
    XCTAssertTrue(newHistoryStorage.searchHistories.count == addItemsCount, @"Should be same as addItemsCount items in storage");
    
    NSArray *manualReadHistoryItems = [NSKeyedUnarchiver unarchiveObjectWithFile:[self.class searchHistoryFilePath]];
    
    [manualReadHistoryItems enumerateObjectsUsingBlock:^(ADRSearchHistoryItem *item, NSUInteger idx, BOOL * _Nonnull stop) {
        XCTAssertEqualObjects(item, tmpItems[idx], @"Should be same history items");
        XCTAssertEqualObjects(item, self.historyStorage.searchHistories[idx], @"Should be same history items");
        XCTAssertEqualObjects(item, newHistoryStorage.searchHistories[idx], @"Should be same history items");
    }];
}

- (void)testPerformanceRead
{
    for (int i = 0; i < 100; i++)
    {
        ADRSearchHistoryItem *newItem = [self createHistoryItem];
        [self.historyStorage addSearchHistory:newItem];
    }
    
    [self measureBlock:^{
        ADRSearchHistoryStorage *newHistoryStorage = [[ADRSearchHistoryStorage alloc] init];
        XCTAssertTrue(newHistoryStorage.searchHistories.count == 100, @"Should be 100 items in storage");
    }];
}

- (void)testPerformanceWrite
{
    [self measureBlock:^{
        for (int i = 0; i < 100; i++)
        {
            ADRSearchHistoryItem *newItem = [self createHistoryItem];
            [self.historyStorage addSearchHistory:newItem];
        }
    }];
}

- (ADRSearchHistoryItem *)createHistoryItem
{
    NSString *searchString = @"Cat";
    NSDate *searchDate = [NSDate date];
    return [[ADRSearchHistoryItem alloc] initWithSearchString:searchString searchDate:searchDate];
}

+ (void)cleanHistory
{
    NSString *historyFilePath = [self searchHistoryFilePath];
    [NSFileManager.defaultManager removeItemAtPath:historyFilePath error:nil];
}

+ (NSString *)searchHistoryFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths.firstObject;
    
    return [documentsDirectory stringByAppendingPathComponent:kHistoriesFileName];
}



@end
