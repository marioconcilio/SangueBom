//
//  APIServiceTests.m
//  SangueBom
//
//  Created by Mario Concilio on 9/16/15.
//  Copyright (c) 2015 Mario Concilio. All rights reserved.
//

#import "APIService.h"
#import "Helper.h"
#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface APIServiceTests : XCTestCase

@end

@implementation APIServiceTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Helper Methods
- (void)waitForExpectations {
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"code: %ld, %@", error.code, [error.userInfo valueForKey:NSLocalizedDescriptionKey]);
        }
    }];
}

#pragma mark - Test Methods
- (void)testSingletonSharedInstance {
    XCTAssertNotNil([APIService sharedInstance], @"returning nil from shared instance");
}

- (void)testUniqueInstance {
    XCTAssertNotNil([[APIService alloc] init], @"returning nil from unique instance");
}

- (void)testSingletonReturnsSameSharedInstance {
    APIService *s1 = [APIService sharedInstance];
    APIService *s2 = [APIService sharedInstance];
    
    XCTAssertEqual(s1, s2, @"singleton is not the same shared instance");
}

- (void)testSingletonDifferentFromUniqueInstance {
    APIService *singleton = [APIService sharedInstance];
    APIService *unique = [[APIService alloc] init];
    
    XCTAssertNotEqual(singleton, unique, @"singleton and unique instance should not be equal");
}

- (void)testTruncateAllBloodCenters {
    XCTestExpectation *expectation = [self expectationWithDescription:@"truncate"];
    
    [[APIService sharedInstance] truncateAllBloodCenters:^(NSError *error) {
        XCTAssertNil(error);
        [expectation fulfill];
    }];
    
    [self waitForExpectations];
}

- (void)testPopulateBloodCenters {
    XCTestExpectation *expectation = [self expectationWithDescription:@"populate"];
    
    [[APIService sharedInstance] populateBloodCenters:^(NSError *error) {
        XCTAssertNil(error);
        [expectation fulfill];
    }];
    
    [self waitForExpectations];
}

- (void)testTruncateAllPersons {
    XCTestExpectation *expectation = [self expectationWithDescription:@"truncate"];

    [[APIService sharedInstance] truncateAllPersons:^(NSError *error) {
        XCTAssertNil(error);
        [expectation fulfill];
    }];
    
    [self waitForExpectations];
}

- (void)testRegisterUser {
    XCTestExpectation *expectation = [self expectationWithDescription:@"signup"];

    [[APIService sharedInstance] registerUser:@"Mario"
                                      surname:@"Concilio"
                                        email:@"marioconcilio@test.com"
                                     password:@"mario12345"
                                     birthday:[Helper parseDateFromString:@"09/01/1989"]
                                    bloodType:@"A+"
                                        block:^(NSError *error) {
                                            XCTAssertNil(error);
                                            [expectation fulfill];
                                        }];
    
    [self waitForExpectations];
}

- (void)testLogin {
    XCTestExpectation *expectation = [self expectationWithDescription:@"login"];
    
    [[APIService sharedInstance] login:@"marioconcilio@test.com"
                              password:@"mario12345"
                                 block:^(NSError *error) {
                                     XCTAssertNil(error);
                                     [expectation fulfill];
                                 }];
    
    [self waitForExpectations];
}

@end
