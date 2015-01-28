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
#import "IoTKitLib/AlertManagement.h"

@interface Module_011_AlertManagementTests : BasicSetup

@property(nonatomic,retain)AlertManagement *alertObject;

@end

@implementation Module_011_AlertManagementTests

- (void)setUp {
    [super setUp];
    _alertObject = [[AlertManagement alloc] init];
}

- (void)tearDown {
    _alertObject = nil;
    [super tearDown];
}

- (void)test_1101_CreateAlert {
    [self configureResponseDelegateWithExpectedResponseCode:200];
    CreateNewAlert *newAlert = [[CreateNewAlert alloc] init];
    CreateNewAlertData *newAlertData = [[CreateNewAlertData alloc] initCreateNewAlertData];
    CreateNewAlertDataConditions *newAlertDataConditions = [[CreateNewAlertDataConditions alloc]initCreateNewAlertDataConditions];
    CreateNewAlertDataConditionComponents *newAlertDataConditionComponents = [[CreateNewAlertDataConditionComponents alloc] init];
    
    //setting new alert props
    [newAlertData alertSetAlertId:[self getRandomAlertId]];
    [newAlertData alertSetRuleId:[[[NSUserDefaults standardUserDefaults] objectForKey:RULEID] integerValue]];
    [newAlertData alertSetDeviceId:[HttpUrlBuilder getDeviceId]];
    [newAlertData alertSetAccountId:[HttpUrlBuilder getAccountId]];
    [newAlertData alertSetAlertStatus:@"Open"];
    [newAlertData alertSetTimestamp:[self getCurrentTimeInMillis]];
    [newAlertData alertSetResetTimestamp:[self getCurrentTimeInMillis]];
    [newAlertData alertSetResetType:@"Automatic"];
    [newAlertData alertSetLastUpdateDate:[self getCurrentTimeInMillis]];
    [newAlertData alertSetRuleName:[[NSUserDefaults standardUserDefaults] objectForKey:@"DemoIoTRule"]];
    [newAlertData alertSetRulePriority:@"Low"];
    [newAlertData alertSetNaturalLangAlert:@"temperature > 0"];
    [newAlertData alertSetRuleExecutionTimestamp:[self getCurrentTimeInMillis]];
    
    //adding alert data to alert list
    [newAlert addNewAlertDataObject:newAlertData];
    
    //setting new alert condition props
    [newAlertDataConditions alertSetConditionSequence:1];
    [newAlertDataConditions alertSetNaturalLanguageCondition:@"temperature > 0"];
    
    //adding conditions to alert condition list
    [newAlertData alertAddNewAlertConditions:newAlertDataConditions];
    
    //setting new alert condition component props
    [newAlertDataConditionComponents alertSetComponentId:[HttpUrlBuilder getComponentId:
                                                          [HttpUrlBuilder getComponentName]]];
    [newAlertDataConditionComponents alertSetDataType:@"Number"];
    [newAlertDataConditionComponents alertSetComponentName:@"temper"];
    [newAlertDataConditionComponents alertAddValuePointsAt:[self getCurrentTimeInMillis] With:[self getRandomValue]];
    
    //adding condition components to component list
    [newAlertDataConditions alertAddComponents:newAlertDataConditionComponents];
    
    XCTAssertTrue([_alertObject createAlert:newAlert]);
    [self waitForServerResponse];
}
- (void)test_1102_GetListOfAlerts {
    [self configureResponseDelegateWithExpectedResponseCode:200];
    XCTAssertTrue([_alertObject getListOfAlerts]);
    [self waitForServerResponse];
}
- (void)test_1103_GetInfoOnAlert {
    [self configureResponseDelegateWithExpectedResponseCode:200];
    XCTAssertTrue([_alertObject getInfoOnAlert:[[NSUserDefaults standardUserDefaults]
                                                objectForKey:@"alert_Id"]]);
    [self waitForServerResponse];
}
- (void)test_1104_UpdateAlertStatus {
    [self configureResponseDelegateWithExpectedResponseCode:200];
    XCTAssertTrue([_alertObject updateAlertStatus:[[NSUserDefaults standardUserDefaults]
                                                   objectForKey:@"alert_Id"] WithStatus:@"Open"]);
    [self waitForServerResponse];
}
- (void)test_1105_AddCommentsToTheAlert {
    [self configureResponseDelegateWithExpectedResponseCode:200];
    XCTAssertTrue([_alertObject addCommentsToTheAlert:[[NSUserDefaults standardUserDefaults]
                                                       objectForKey:@"alert_Id"]
                                               OnUser:@"intel.aricent.iot5@gmail.com"
                                               AtTime:[self getCurrentTimeInMillis]
                                          WithComment:@"Demo comment on alert"]);
    [self waitForServerResponse];
}
- (void)test_1106_ResetAlert {
    [self configureResponseDelegateWithExpectedResponseCode:200];
    XCTAssertTrue([_alertObject resetAlert:[[NSUserDefaults standardUserDefaults]
                                            objectForKey:@"alert_Id"]]);
    [self waitForServerResponse];
}

@end
