//
//  ADRFlickrNetworkServiceTests.m
//  FlickrSearch
//
//  Created by dmitrii.aitov@philips.com on 16/02/17.
//  Copyright © 2017 Dmitrii Aitov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ADRFlickrNetworkService.h"
#import "ADRNetworkClient.h"

static NSString *const kApiKeyQueryKey = @"api_key";
static NSString *const kFormatQueryKey = @"format";
static NSString *const kCallbackQueryKey = @"nojsoncallback";
static NSString *const kFormatQueryValue = @"json";
static NSString *const kCallbackQueryValue = @"1";

@interface ADRFlickrNetworkServiceTests : XCTestCase

@end

@implementation ADRFlickrNetworkServiceTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testFlickrServiceCreation
{
    ADRNetworkClient *networkClient = [[ADRNetworkClient alloc] init];
    NSString *apiKey = @"veryverylongapikey";
    
    ADRFlickrNetworkService *flickrNetworkService = [[ADRFlickrNetworkService alloc] initWithAPIKey:apiKey networkClient:networkClient];
    
    XCTAssertNotNil(flickrNetworkService, @"Should not be nil");
    
    XCTAssertEqualObjects(flickrNetworkService.baseURL, [NSURL URLWithString:@"https://api.flickr.com/services/rest/"], @"Base url should point to flickr rest api endpoint");
    
    XCTAssertTrue(flickrNetworkService.networkCLient == networkClient, @"Should be same object");
}

- (void)testAddingQueryParameters
{
    ADRNetworkClient *networkClient = [[ADRNetworkClient alloc] init];
    NSString *apiKey = @"veryverylongapikey";
    
    ADRFlickrNetworkService *flickrNetworkService = [[ADRFlickrNetworkService alloc] initWithAPIKey:apiKey networkClient:networkClient];
    
    XCTAssertNotNil(flickrNetworkService, @"Should not be nil");
    
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:flickrNetworkService.baseURL resolvingAgainstBaseURL:YES];
    
    XCTAssertNil(components.queryItems, @"At this point query should be empty");
    
    components.queryItems = @[];
    
    [flickrNetworkService addParametersToURLComponents:components];
    
    XCTAssertEqual(components.queryItems.count, 3, @"At this point query should 3 elements");
    
    XCTAssertEqualObjects(components.queryItems[0].name, kApiKeyQueryKey, @"First query parameter name should be api_key");
    XCTAssertEqualObjects(components.queryItems[0].value, apiKey, @"First query parameter value should be veryverylongapikey");
    
    XCTAssertEqualObjects(components.queryItems[1].name, kFormatQueryKey, @"Second query parameter name should be format");
    XCTAssertEqualObjects(components.queryItems[1].value, kFormatQueryValue, @"Second query parameter value should be json");
    
    XCTAssertEqualObjects(components.queryItems[2].name, kCallbackQueryKey, @"Third query parameter name should be nojsoncallback");
    XCTAssertEqualObjects(components.queryItems[2].value, kCallbackQueryValue, @"Third query parameter value should be 1");
}

- (void)testAddingHTTPHeaders
{
    ADRNetworkClient *networkClient = [[ADRNetworkClient alloc] init];
    NSString *apiKey = @"veryverylongapikey";
    
    ADRFlickrNetworkService *flickrNetworkService = [[ADRFlickrNetworkService alloc] initWithAPIKey:apiKey networkClient:networkClient];
    
    XCTAssertNotNil(flickrNetworkService, @"Should not be nil");
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:flickrNetworkService.baseURL];
    
    XCTAssertNil(request.allHTTPHeaderFields, @"At this point headers should be empty");
    
    [flickrNetworkService addHeadersToURLRequest:request];
    
    XCTAssertNil(request.allHTTPHeaderFields, @"At this point headers should be empty");
}


@end
