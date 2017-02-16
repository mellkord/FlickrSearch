//
//  ADRFlickrSearchHistoryViewModelTests.m
//  FlickrSearch
//
//  Created by dmitrii.aitov@philips.com on 16/02/17.
//  Copyright © 2017 Dmitrii Aitov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ADRFlickrSearchHistoryViewModel.h"
#import "ADRSearchHistoryItem.h"
#import "ADRSearchHistoryStorage.h"
#import "ADRSearchHistoryTableCellViewModelProtocol.h"
#import "AppDelegate.h"

static NSString *const kHistoriesFileName = @"histories.dat";

@interface ADRFlickrSearchHistoryViewModelTests : XCTestCase

@end

@implementation ADRFlickrSearchHistoryViewModelTests

- (void)setUp {
    [super setUp];
    [self.class cleanHistory];
}

- (void)tearDown {
    [self.class cleanHistory];
    [super tearDown];
}

- (void)testHistoryItemsCount
{
    ADRFlickrSearchHistoryViewModel *flickrSearchHistoryViewModel = [[ADRFlickrSearchHistoryViewModel alloc] init];
    
    ADRSearchHistoryStorage *historyStorage = ((AppDelegate *)UIApplication.sharedApplication.delegate).historyStorage;
    [historyStorage updateHistory];
    
    XCTAssertEqual(flickrSearchHistoryViewModel.historyCount, 0, @"History empty at this point history count should be 0");
    
    NSString *searchString = @"Cat";
    NSDate *searchDate = [NSDate dateWithTimeIntervalSince1970:0];
    ADRSearchHistoryItem *item = [[ADRSearchHistoryItem alloc] initWithSearchString:searchString searchDate:searchDate];
    
    [historyStorage addSearchHistory:item];
    
    XCTAssertEqual(flickrSearchHistoryViewModel.historyCount, 1, @"History empty at this point history count should be 1");
    
    [historyStorage removeSearchHistory:item];
    
    XCTAssertEqual(flickrSearchHistoryViewModel.historyCount, 0, @"History empty at this point history count should be 0");
}

- (void)testModelAtIndex
{
    ADRFlickrSearchHistoryViewModel *flickrSearchHistoryViewModel = [[ADRFlickrSearchHistoryViewModel alloc] init];
    
    ADRSearchHistoryStorage *historyStorage = ((AppDelegate *)UIApplication.sharedApplication.delegate).historyStorage;
    [historyStorage updateHistory];
    
    XCTAssertEqual(flickrSearchHistoryViewModel.historyCount, 0, @"History empty at this point history count should be 0");
    
    NSString *searchString = @"Cat";
    NSDate *searchDate = [NSDate dateWithTimeIntervalSince1970:0];
    ADRSearchHistoryItem *item = [[ADRSearchHistoryItem alloc] initWithSearchString:searchString searchDate:searchDate];
    
    [historyStorage addSearchHistory:item];
    
    XCTAssertEqual(flickrSearchHistoryViewModel.historyCount, 1, @"History empty at this point history count should be 1");
    
    NSObject <ADRSearchHistoryTableCellViewModelProtocol> *cellModel = [flickrSearchHistoryViewModel modelForHistoryCellAtIndex:0];
    
    XCTAssertEqualObjects(cellModel.searchString, searchString, @"Should be same search strings");
    XCTAssertEqualObjects(cellModel.dateString, @"Jan 01, 1970 01:00", @"Should be same date strings");
    
    [historyStorage removeSearchHistory:item];
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
