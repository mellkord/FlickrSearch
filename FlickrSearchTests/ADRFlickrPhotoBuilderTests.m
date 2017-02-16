//
//  ADRFlickrPhotoBuilderTests.m
//  FlickrSearch
//
//  Created by dmitrii.aitov@philips.com on 16/02/17.
//  Copyright © 2017 Dmitrii Aitov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ADRFlickrPhotoBuilder.h"
#import "ADRFlickrPhoto.h"

static NSString *const kPhotosDictionaryKey = @"photos";
static NSString *const kPhotosArrayKey = @"photo";
static NSString *const kPhotoIdentifierKey = @"id";
static NSString *const kServerKey = @"server";
static NSString *const kFarmKey = @"farm";
static NSString *const kOwnerKey = @"owner";
static NSString *const kPhotoSecretKey = @"secret";
static NSString *const kPhotoTitleKey = @"title";

@interface ADRFlickrPhotoBuilderTests : XCTestCase

@end

@implementation ADRFlickrPhotoBuilderTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPhotoCreationFromJSONData
{
    NSData *jsonData = [self createRightJsonData];
    
    XCTAssertNotNil(jsonData, @"Should be not nil");
    
    NSArray *photos = [ADRFlickrPhotoBuilder photosFromJSONData:jsonData];
    
    XCTAssertEqual(photos.count, 3, @"Count of photos should be 3");
    [photos enumerateObjectsUsingBlock:^(ADRFlickrPhoto *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XCTAssertTrue([obj isMemberOfClass:[ADRFlickrPhoto class]], @"All objects should be photos");
    }];
    
    //All objects has some imperfections
    jsonData = [self createWrongJsonData];
    
    XCTAssertNotNil(jsonData, @"Should be not nil");
    
    photos = [ADRFlickrPhotoBuilder photosFromJSONData:jsonData];
    
    XCTAssertEqual(photos.count, 3, @"Count of photos should be 3");
    [photos enumerateObjectsUsingBlock:^(ADRFlickrPhoto *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XCTAssertTrue([obj isMemberOfClass:[NSNull class]], @"All objects should be nsnull");
    }];
    
    //Object 1 not valid, 2 and 3 valid
    jsonData = [self createParcialyWrongJsonData];
    
    XCTAssertNotNil(jsonData, @"Should be not nil");
    
    photos = [ADRFlickrPhotoBuilder photosFromJSONData:jsonData];
    
    XCTAssertEqual(photos.count, 3, @"Count of photos should be 3");
    [photos enumerateObjectsUsingBlock:^(ADRFlickrPhoto *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0)
        {
            XCTAssertTrue([obj isMemberOfClass:[NSNull class]], @"First object should be nsnull");
        }
        else
        {
            XCTAssertTrue([obj isMemberOfClass:[ADRFlickrPhoto class]], @"2 and 3 objects should be photos");
        }
    }];
}

- (void)testNotJSONData
{
    NSData *data = [@"Not json data" dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSArray *photos = [ADRFlickrPhotoBuilder photosFromJSONData:data];
    
    XCTAssertNil(photos, @"Should be nil");
}

- (void)testPhotoCreationFromXMLData
{
    
}

- (void)testNotXMLData
{
    
}

- (NSData *)createRightJsonData
{
    NSDictionary *photo1Dict = @{kPhotoIdentifierKey : @"123", kServerKey : @"12", kFarmKey : @1, kPhotoTitleKey : @"Megatitle1", kPhotoSecretKey: @"secret1", kOwnerKey : @"owner"};
    NSDictionary *photo2Dict = @{kPhotoIdentifierKey : @"124", kServerKey : @"12", kFarmKey : @1, kPhotoTitleKey : @"Megatitle2", kPhotoSecretKey: @"secret2", kOwnerKey : @"owner"};
    NSDictionary *photo3Dict = @{kPhotoIdentifierKey : @"125", kServerKey : @"12", kFarmKey : @1, kPhotoTitleKey : @"Megatitle3", kPhotoSecretKey: @"secret3", kOwnerKey : @"owner"};
    NSDictionary *dataDict = @{kPhotosDictionaryKey : @{kPhotosArrayKey : @[photo1Dict, photo2Dict, photo3Dict]}};
    
    return [NSJSONSerialization dataWithJSONObject:dataDict options:0 error:nil];
}

- (NSData *)createWrongJsonData
{
    NSDictionary *photo1Dict = @{kServerKey : @"12", kFarmKey : @1, kPhotoTitleKey : @"Megatitle1", kPhotoSecretKey: @"secret1", kOwnerKey : @"owner"};
    NSDictionary *photo2Dict = @{kPhotoIdentifierKey : @"124", kServerKey : @"12", kFarmKey : @1, kPhotoSecretKey: @"secret2", kOwnerKey : @"owner"};
    NSDictionary *photo3Dict = @{kPhotoIdentifierKey : @"125", kServerKey : @"12", kFarmKey : @1, kPhotoTitleKey : @"Megatitle3", kOwnerKey : @"owner"};
    NSDictionary *dataDict = @{kPhotosDictionaryKey : @{kPhotosArrayKey : @[photo1Dict, photo2Dict, photo3Dict]}};
    
    return [NSJSONSerialization dataWithJSONObject:dataDict options:0 error:nil];
}

- (NSData *)createParcialyWrongJsonData
{
    NSDictionary *photo1Dict = @{kPhotoIdentifierKey : @"123", kFarmKey : @1, kPhotoTitleKey : @"Megatitle1", kPhotoSecretKey: @"secret1", kOwnerKey : @"owner"};
    NSDictionary *photo2Dict = @{kPhotoIdentifierKey : @"124", kServerKey : @"12", kFarmKey : @1, kPhotoTitleKey : @"Megatitle2", kPhotoSecretKey: @"secret2", kOwnerKey : @"owner"};
    NSDictionary *photo3Dict = @{kPhotoIdentifierKey : @"125", kServerKey : @"12", kFarmKey : @1, kPhotoTitleKey : @"Megatitle3", kPhotoSecretKey: @"secret3", kOwnerKey : @"owner"};
    NSDictionary *dataDict = @{kPhotosDictionaryKey : @{kPhotosArrayKey : @[photo1Dict, photo2Dict, photo3Dict]}};
    
    return [NSJSONSerialization dataWithJSONObject:dataDict options:0 error:nil];
}


- (NSData *)createRightXMLData
{
    NSLog(@"Not implemented yet");
    return nil;
}

- (NSData *)createWrongXMLData
{
    NSLog(@"Not implemented yet");
    return nil;
}

@end
