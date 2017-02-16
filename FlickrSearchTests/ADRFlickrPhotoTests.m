//
//  ADRFlickrPhotoTests.m
//  FlickrSearch
//
//  Created by dmitrii.aitov@philips.com on 16/02/17.
//  Copyright © 2017 Dmitrii Aitov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ADRFlickrPhoto.h"

@interface ADRFlickrPhotoTests : XCTestCase

@end

@implementation ADRFlickrPhotoTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testPhotoCreation
{
    NSUInteger identifier = 123;
    NSUInteger server = 12;
    NSUInteger farm = 1;
    
    NSString *title = @"Megacool";
    NSString *owner = @"MisterAnonymous";
    NSString *secret = @"SSSssHhhhh";
    
    ADRFlickrPhoto *photo = [[ADRFlickrPhoto alloc] initWithIdentifier:identifier
                                                                 title:title
                                                                 owner:owner
                                                                secret:secret
                                                                server:server
                                                                  farm:farm];
    
    XCTAssertNotNil(photo, @"Photo shouldnt be nil");
    
    XCTAssertEqualObjects(photo.title, title, @"Titles should be same");
    XCTAssertEqualObjects(photo.owner, owner, @"Owner should be same");
    XCTAssertEqualObjects(photo.secret, secret, @"Secret should be same");
    
    XCTAssertEqual(photo.identifier, identifier, @"Identifiers should be same");
    XCTAssertEqual(photo.server, server, @"Servers should be same");
    XCTAssertEqual(photo.farm, farm, @"Farms should be same");
}

- (void)testPhotoUrl
{
    NSUInteger identifier = 123;
    NSUInteger server = 12;
    NSUInteger farm = 1;
    
    NSString *title = @"Megacool";
    NSString *owner = @"MisterAnonymous";
    NSString *secret = @"SSSssHhhhh";
    
    //https:\//farm{farm}.static.flickr.com/{server}/{id}_{secret}.jpg
    NSURL *manualURL = [NSURL URLWithString:@"https://farm1.static.flickr.com/12/123_SSSssHhhhh.jpg"];
    
    XCTAssertNotNil(manualURL, @"Manual url shouldnt be nil");
    
    ADRFlickrPhoto *photo = [[ADRFlickrPhoto alloc] initWithIdentifier:identifier
                                                                 title:title
                                                                 owner:owner
                                                                secret:secret
                                                                server:server
                                                                  farm:farm];
    
    XCTAssertNotNil(photo, @"Photo shouldnt be nil");
    
    XCTAssertEqualObjects(photo.imageURL, manualURL, @"Urls should be equal");
}


@end
