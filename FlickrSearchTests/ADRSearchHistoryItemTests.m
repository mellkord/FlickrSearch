//
//  ADRSearchHistoryItemTests.m
//  FlickrSearch
//
//  Created by dmitrii.aitov@philips.com on 16/02/17.
//  Copyright © 2017 Dmitrii Aitov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ADRSearchHistoryItem.h"

@interface ADRSearchHistoryItemTests : XCTestCase

@end

@implementation ADRSearchHistoryItemTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testHistoryItemCreation
{
    NSString *searchString = @"Cat";
    NSDate *searchDate = [NSDate dateWithTimeIntervalSince1970:0];
    
    ADRSearchHistoryItem *item = [[ADRSearchHistoryItem alloc] initWithSearchString:searchString searchDate:searchDate];
    
    XCTAssertNotNil(item, @"Should not be nil");
    
    XCTAssertEqualObjects(item.searchString, searchString, @"Search string should be equal to Cat");
    XCTAssertEqualObjects(item.searchDate, searchDate, @"Search date should be equal to 1970");
}

- (void)testHistoryItemsEquality
{
    NSString *searchString = @"Cat";
    NSDate *searchDate = [NSDate dateWithTimeIntervalSince1970:0];
    
    ADRSearchHistoryItem *item = [[ADRSearchHistoryItem alloc] initWithSearchString:searchString searchDate:searchDate];
    
    XCTAssertNotNil(item, @"Should not be nil");
    
    XCTAssertTrue([item isEqualToSearchHistory:item], @"Same objects should be equal");
    
    ADRSearchHistoryItem *item2 = [[ADRSearchHistoryItem alloc] initWithSearchString:searchString searchDate:searchDate];
    
    XCTAssertTrue([item isEqualToSearchHistory:item2], @"Different objects but with same parameters should be equal");
    
    NSDate *differentSearchDate = [NSDate date];
    item2 = [[ADRSearchHistoryItem alloc] initWithSearchString:searchString searchDate:differentSearchDate];
    
    XCTAssertFalse([item isEqualToSearchHistory:item2], @"Different objects different date parameter should be not equal");
    
    XCTAssertFalse([item isEqualToSearchHistory:(ADRSearchHistoryItem *)[NSNull null]], @"Different type of objects should be not equal");
}


@end
