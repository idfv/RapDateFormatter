//
//  RapDateFormatterTests.m
//
//  Created by RapKit on 2017/6/21.
//  Copyright © 2017 RapKit. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "RapDateFormatter.h"

@interface RapDateFormatterTests : XCTestCase

@end

@implementation RapDateFormatterTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    NSArray<NSDictionary *> *testSecDicArr = @[
                                               @{@(100000000):              @"Just"},
                                               @{@(10):                     @"Just"},
                                               @{@(0):                      @"Just"},
                                               @{@(-10):                    @"Just"},
                                               @{@(-60 + 1):                @"Just"},
                                               @{@(-60):                    @"1 minute ago"},
                                               @{@(-60 * 60 + 1):           @"59 minutes ago"},
                                               @{@(-60 * 60):               @"1 hour ago"},
                                               @{@(-60 * 60 * 24 * 1 + 1):  @"23 hours ago"},
                                               @{@(-60 * 60 * 24 * 1):      @"Yesterday"},
                                               @{@(-60 * 60 * 24 * 2):      @"Before yesterday"},
                                               @{@(-60 * 60 * 24 * 3):      @"3 days ago"},
                                               @{@(-60 * 60 * 24 * 9):      @"9 days ago"},
                                               @{@(-60 * 60 * 24 * 10):     @"*-*"}, // m-d
                                               @{@(-60 * 60 * 24 * 365):    @"*-*-*"}, // y-m-d
                                               ];
    
    NSDate *currDate            = [NSDate date];
    NSDateFormatter *formatter  = [[NSDateFormatter alloc] init];
    formatter.dateFormat        = @"yyyy-MM-dd HH:mm:ss";
    [testSecDicArr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSNumber *key   = obj.allKeys.firstObject;
        NSString *value = obj.allValues.firstObject;
        
        NSDate *testDate = [NSDate dateWithTimeInterval:key.doubleValue sinceDate:currDate];
        printf("\n\n%d ====================", (int)idx + 1);
        printf("\nCurr date: %s", [formatter stringFromDate:currDate].UTF8String);
        printf("\nTest date: %s", [formatter stringFromDate:testDate].UTF8String);
        
        NSString *result = [RapDateFormatter dateFormatWithDate:testDate];
        printf("\nResult: %s", result.UTF8String);
        
        if ([value containsString:@"*"]) {
            [[value componentsSeparatedByString:@"*"] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj.length) {
                    XCTAssert([result containsString:obj], "Date Formatted Error.");
                }
            }];
        }else{
            XCTAssert([result hasPrefix:value], "Date Formatted Error.");
        }
        
    }];
    
    printf("\n====================\n\n");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
