//
//  APIServiceTests.m
//  SangueBom
//
//  Created by Mario Concilio on 9/16/15.
//  Copyright (c) 2015 Mario Concilio. All rights reserved.
//

#import "APIService.h"
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

- (void)testSingletonSharedInstance {
    XCTAssertNotNil([APIService sharedInstance]);
}

- (void)testUniqueInstance {
    XCTAssertNotNil([[APIService alloc] init]);
}

- (void)testSingletonReturnsSameSharedInstance {
    APIService *s1 = [APIService sharedInstance];
    APIService *s2 = [APIService sharedInstance];
    
    XCTAssertEqual(s1, s2);
}

- (void)testSingletonDifferentFromUniqueInstance {
    APIService *singleton = [APIService sharedInstance];
    APIService *unique = [[APIService alloc] init];
    
    XCTAssertNotEqual(singleton, unique);
}

- (void)testLogin {
    XCTestExpectation *loginExpectation = [self expectationWithDescription:@"login"];
    [[APIService sharedInstance] login:@"marioconcilio@gmail.com"
                              password:@"mario12345"
                                 block:^(NSError *error) {
                                     XCTAssertNil(error);
                                     [loginExpectation fulfill];
                                 }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"code: %ld, %@", error.code, [error.userInfo valueForKey:NSLocalizedDescriptionKey]);
        }
    }];
}

@end
