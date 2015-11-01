//
//  HelperTests.m
//  SangueBom
//
//  Created by Mario Concilio on 11/1/15.
//  Copyright © 2015 Mario Concilio. All rights reserved.
//

#import "Helper.h"
#import <XCTest/XCTest.h>

@interface HelperTests : XCTestCase

@end

@implementation HelperTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCreateAnswersArray {
    NSArray *array = [Helper createAnswersArrayWithCapacity:8];
    for (NSInteger i=0; i<array.count; i++) {
        XCTAssertFalse([array[i] boolValue], @"failed to create array filled with NO values only");
    }
}

- (void)testCompareArrays {
    // two equal arrays
    NSArray *arr1 = @[@(NO), @(NO), @(YES), @(YES)];
    NSArray *arr2 = [arr1 copy];
    BOOL ans1 = [Helper compareAnswers:arr1 with:arr2];
    XCTAssertTrue(ans1, @"failed to return YES from two equal arrays");
    
    // two different arrays
    arr1 = @[@(YES), @(YES), @(NO), @(YES)];
    BOOL ans2 = [Helper compareAnswers:arr1 with:arr2];
    XCTAssertFalse(ans2, @"failed to return NO from two different arrays");
    
    // two different dimensions
    arr2 = @[@(YES), @(NO)];
    BOOL ans3 = [Helper compareAnswers:arr1 with:arr2];
    XCTAssertFalse(ans3, @"failed to return NO from two arrays with different dimensions");
}

- (void)testDateFormatting {
    NSString *string = @"09/01/1989";
    NSDate *date = [Helper parseDateFromString:string];
    XCTAssertNotNil(date, @"failed to parse date from string");
    
    NSString *str = [Helper formatDate:date];
    XCTAssertEqualObjects(string, str, @"failed to compare to equal strings");
}

@end
