//
//  ADRFlickrSearchViewModelTests.m
//  FlickrSearch
//
//  Created by dmitrii.aitov@philips.com on 16/02/17.
//  Copyright © 2017 Dmitrii Aitov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ADRFlickrSearchViewModel.h"
#import "ADRSearchHistoryItem.h"
#import "ADRSearchHistoryStorage.h"
#import "AppDelegate.h"

static NSString *const kHistoriesFileName = @"histories.dat";

@interface ADRFlickrSearchViewModelTests : XCTestCase

@end

@implementation ADRFlickrSearchViewModelTests

- (void)setUp
{
    [super setUp];
    [self.class cleanHistory];
}

- (void)tearDown
{
    [self.class cleanHistory];
    [super tearDown];
}

- (void)testHistoryButtonEnable
{
    ADRFlickrSearchViewModel *flickrSearchViewModel = [[ADRFlickrSearchViewModel alloc] init];
    
    XCTAssertFalse(flickrSearchViewModel.historyButtonEnable, @"History empty at this point history button should be disabled");
    
    NSString *searchString = @"Cat";
    NSDate *searchDate = [NSDate dateWithTimeIntervalSince1970:0];
    ADRSearchHistoryItem *item = [[ADRSearchHistoryItem alloc] initWithSearchString:searchString searchDate:searchDate];
    ADRSearchHistoryStorage *historyStorage = ((AppDelegate *)UIApplication.sharedApplication.delegate).historyStorage;
    [historyStorage updateHistory];
    [historyStorage addSearchHistory:item];
    
    XCTAssertTrue(flickrSearchViewModel.historyButtonEnable, @"History has element at this point history button should be enabled");
    
    [historyStorage removeSearchHistory:item];
    
    XCTAssertFalse(flickrSearchViewModel.historyButtonEnable, @"History empty at this point history button should be disabled");
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
