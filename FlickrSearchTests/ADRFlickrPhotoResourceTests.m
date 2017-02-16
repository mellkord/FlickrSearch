//
//  ADRFlickrPhotoResourceTests.m
//  FlickrSearch
//
//  Created by dmitrii.aitov@philips.com on 16/02/17.
//  Copyright © 2017 Dmitrii Aitov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ADRFlickrPhotoResource.h"
#import "ADRFlickrNetworkService.h"
#import "ADRNetworkClient.h"

static NSString *const kFlickrAPIKey = @"2ff0c003011f52f2362c80190dbedd27";

@interface ADRFlickrPhotoResourceTests : XCTestCase

@property (nonatomic, strong, readwrite, nonnull) ADRFlickrNetworkService *flickrNetworkService;
@property (nonatomic, strong, readwrite, nonnull) ADRFlickrPhotoResource *flickrPhotoResource;

@end

@implementation ADRFlickrPhotoResourceTests

- (void)setUp
{
    [super setUp];
    
    self.flickrNetworkService = [[ADRFlickrNetworkService alloc] initWithAPIKey:kFlickrAPIKey networkClient:[[ADRNetworkClient alloc] init]];
    self.flickrPhotoResource = (ADRFlickrPhotoResource *)self.flickrNetworkService.photoResource;
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSearchPhotos
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"search"];
    
    NSURLSessionTask *task = [self.flickrPhotoResource searchPhotosForString:@"Cat" page:1 photosPerPage:100 completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        XCTAssertNotNil(data, "data should not be nil");
        XCTAssertNil(error, "error should be nil");

        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
          NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
          XCTAssertEqual(httpResponse.statusCode, 200, @"HTTP response status code should be 200");
        } else {
          XCTFail(@"Response was not NSHTTPURLResponse");
        }

        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:task.originalRequest.timeoutInterval handler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        }
        [task cancel];
    }];
}

- (void)testDownloadImage
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"image"];
    
    NSURL *imageURL = [NSURL URLWithString:@"https://farm1.static.flickr.com/578/23451156376_8983a8ebc7.jpg"];
    
    NSURLSessionTask *task = [self.flickrPhotoResource getImageWithURL:imageURL downloadCompletion:^(NSURL *fileUrl, NSURLResponse *response, NSError *error) {
        XCTAssertNotNil(fileUrl, "data should not be nil");
        XCTAssertNil(error, "error should be nil");
        
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            XCTAssertEqual(httpResponse.statusCode, 200, @"HTTP response status code should be 200");
            XCTAssertEqualObjects(httpResponse.URL.absoluteString, imageURL.absoluteString, @"HTTP response URL should be equal to original URL");
            
            XCTAssertTrue([NSFileManager.defaultManager fileExistsAtPath:fileUrl.path], @"File should exists");
            
        } else {
            XCTFail(@"Response was not NSHTTPURLResponse");
        }
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:task.originalRequest.timeoutInterval handler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        }
        [task cancel];
    }];
}


@end
