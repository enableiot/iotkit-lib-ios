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
#import "IoTKitLib/AuthorizationManagement.h"
#import "IoTKitLib/UserManagement.h"

@interface Module_006_UserManagementTests : BasicSetup

@property(nonatomic,retain)UserManagement *userManagementObject;

@end

@implementation Module_006_UserManagementTests

- (void)setUp {
    [super setUp];
    _userManagementObject = [[UserManagement alloc]init];
}

- (void)tearDown {
    _userManagementObject = nil;
    [super tearDown];
}
- (void)test_601_CreateNewUser{
    [self configureResponseDelegateWithExpectedResponseCode:201];
    XCTAssertTrue([_userManagementObject createNewUserWith:@"intel.aricent.iot5@gmail.com"
                                               AndPassword:@"Password2529"]);
    [self waitForServerResponse];
}
- (void)test_602_GetNewAuthorizationToken{
    [self configureResponseDelegateWithExpectedResponseCode:200];
    AuthorizationManagement *auth = [[AuthorizationManagement alloc]init];
    XCTAssertTrue([auth getNewAuthorizationTokenWithUsername:@"intel.aricent.iot5@gmail.com" andPassword:@"Password2529"]);
    [self waitForServerResponse];
}
- (void)test_603_AcceptTermsAndConditions{
    [self configureResponseDelegateWithExpectedResponseCode:200];
    XCTAssertTrue([_userManagementObject acceptTermsAndConditionsOn:[HttpUrlBuilder getUserId]
                                                         Acceptance:true]);
    [self waitForServerResponse];
}
- (void)test_604_GetUserInfo{
    [self configureResponseDelegateWithExpectedResponseCode:200];
    XCTAssertTrue([_userManagementObject getUserInfo:[HttpUrlBuilder getUserId]]);
    [self waitForServerResponse];
}
- (void)test_605_UpdateUserAttributes{
    [self configureResponseDelegateWithExpectedResponseCode:200];
    BOOL isTrue = [_userManagementObject updateUserAttributesOn:[HttpUrlBuilder getUserId]
                              AndListOfAttributes:[NSDictionary dictionaryWithObjectsAndKeys:@"100000000",@"phone",@"hey hey",@"wish", nil]];
    XCTAssertTrue(isTrue);
    [self waitForServerResponse];
}
- (void)test_606_ChangePassword{
    [self configureResponseDelegateWithExpectedResponseCode:200];
    XCTAssertTrue([_userManagementObject changePasswordOn:@"intel.aricent.iot5@gmail.com" AndCurrentPassword:@"Password2529" AndNewPassword:@"Password25292"]);
    [self waitForServerResponse];
}
- (void)test_607_GetNewAuthorizationToken{
    [self configureResponseDelegateWithExpectedResponseCode:200];
    AuthorizationManagement *auth = [[AuthorizationManagement alloc]init];
    XCTAssertTrue([auth getNewAuthorizationTokenWithUsername:@"intel.aricent.iot5@gmail.com" andPassword:@"Password25292"]);
    [self waitForServerResponse];
}
- (void)test_608_RequestChangePassword{
    [self configureResponseDelegateWithExpectedResponseCode:200];
    XCTAssertTrue([_userManagementObject requestChangePasswordOn:@"intel.aricent.iot5@gmail.com"]);
    [self waitForServerResponse];
}
- (void)test_609_UpdateForgotPassword{
    [self configureResponseDelegateWithExpectedResponseCode:200];
    XCTAssertTrue([_userManagementObject updateForgotPassword:@"HqaRch3mzCaDe2XH" AndNewPassword:@"Password2529"]);
    [self waitForServerResponse];
}
- (void)test_610_DeleteAUser{
    [self configureResponseDelegateWithExpectedResponseCode:204];
    XCTAssertTrue([_userManagementObject deleteUser:[HttpUrlBuilder getUserId]]);
    [self waitForServerResponse];
}
@end
