/*
 * Copyright (c) 2014 Intel Corporation.
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import "BasicSetup.h"
#import "IoTKitLib/DataManagement.h"
#import <XCTest/XCTest.h>

@interface Module_005_DataManagementTests : BasicSetup

@property(nonatomic,retain)DataManagement *dataManagementObject;

@end

@implementation Module_005_DataManagementTests

- (void)setUp {
    [super setUp];
    _dataManagementObject = [[DataManagement alloc]init];
}

- (void)tearDown {
    _dataManagementObject = nil;
    [super tearDown];
}

- (void)test_501_SubmitData{
    CloudResponse *response = [_dataManagementObject submitDataOn:[HttpUrlBuilder getComponentName]
                                                         AndValue:[self getRandomValue]
                                                      AndLatitide:10 AndLongitude:20 AndHeight:30 AndAttributes:nil];
    XCTAssertEqual(response.responseCode, 201);
}

- (void)test_502_RetrieveData{
    ConfigureRetrieveData *retData = [[ConfigureRetrieveData alloc] initConfigureRetrieveData:0 ToTimeInMillis:[[NSDate date] timeIntervalSince1970] * 1000];
    [retData addDeviceId:[HttpUrlBuilder getDeviceId]];
    [retData addComponentId:[HttpUrlBuilder getComponentId:[HttpUrlBuilder getComponentName]]];
    CloudResponse *response = [_dataManagementObject retrieveDataOn:retData];
    XCTAssertEqual(response.responseCode, 200);
}

@end
