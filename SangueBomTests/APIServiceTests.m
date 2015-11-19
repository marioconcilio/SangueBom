//
//  APIServiceTests.m
//  SangueBom
//
//  Created by Mario Concilio on 9/16/15.
//  Copyright (c) 2015 Mario Concilio. All rights reserved.
//

#import "APIService.h"
#import "Helper.h"
#import "VOBloodCenter.h"
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
- (void)testListAllBloodCenters {
    XCTestExpectation *expectation = [self expectationWithDescription:@"listAllBloodCenters"];

    [[APIService sharedInstance] listAllBloodCenters:^(NSArray<VOBloodCenter *> *centers, NSError *error) {
        XCTAssertNotNil(centers);
        XCTAssertGreaterThan(centers.count, 0);
        XCTAssertNil(error);
        [expectation fulfill];
    }];
    
    [self waitForExpectations];
}

- (void)testSignup {
    XCTestExpectation *expectation = [self expectationWithDescription:@"signup"];
    u_int32_t randomInt = arc4random() % 1000;

    [[APIService sharedInstance] registerUser:[NSString stringWithFormat:@"Test User%03d", randomInt]
                                        email:[NSString stringWithFormat:@"testuser%03d@test.com", randomInt]
                                     password:@"123456"
                                    bloodType:@"A+"
                                     birthday:@"11-11-2015"
                                        block:^(NSError *error) {
                                            XCTAssertNil(error);
                                            [expectation fulfill];
                                        }];
    
    [self waitForExpectations];
}

- (void)testLogin {
    XCTestExpectation *expectation = [self expectationWithDescription:@"login"];

    [[APIService sharedInstance] login:@"caio_uechi@hotmail.com"
                              password:@"123456"
                                 block:^(NSError *error) {
                                     XCTAssertNil(error);
                                     [expectation fulfill];
                                 }];
    
    [self waitForExpectations];
}

- (void)testUpdateUser {
    XCTestExpectation *expectation = [self expectationWithDescription:@"update"];
    
    [[APIService sharedInstance] updateUserBloodType:@"O+"
                                               email:@"caio_uechi@hotmail.com"
                                            password:@"123456"
                                               block:^(NSError *error) {
                                                   XCTAssertNil(error);
                                                   [expectation fulfill];
                                               }];
    
    [self waitForExpectations];
}

@end
