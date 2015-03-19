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
    CloudResponse *response = [_userManagementObject createNewUserWith:@"intel.aricent.iot6@gmail.com"
                                                           AndPassword:@"Password2529"];
    XCTAssertEqual(response.responseCode, 201);
}
- (void)test_602_GetNewAuthorizationToken{
    AuthorizationManagement *auth = [[AuthorizationManagement alloc]init];
    CloudResponse *response = [auth getNewAuthorizationTokenWithUsername:@"intel.aricent.iot6@gmail.com" andPassword:@"Password2529"];
    XCTAssertEqual(response.responseCode, 200);
}
/*- (void)test_603_AcceptTermsAndConditions{
    CloudResponse *response = [_userManagementObject acceptTermsAndConditionsOn:[HttpUrlBuilder getUserId]
                                                                     Acceptance:true];
    XCTAssertEqual(response.responseCode, 200);
}*/
- (void)test_604_GetUserInfo{
    CloudResponse *response = [_userManagementObject getUserInfo:[HttpUrlBuilder getUserId]];
    XCTAssertEqual(response.responseCode, 200);
}
- (void)test_605_UpdateUserAttributes{
    CloudResponse *response = [_userManagementObject updateUserAttributesOn:[HttpUrlBuilder getUserId]
                                                        AndListOfAttributes:[NSDictionary dictionaryWithObjectsAndKeys:@"100000000",@"phone",@"hey hey",@"wish", nil]];
    XCTAssertEqual(response.responseCode, 200);
}
- (void)test_606_ChangePassword{
    CloudResponse *response = [_userManagementObject changePasswordOn:@"intel.aricent.iot6@gmail.com" AndCurrentPassword:@"Password2529" AndNewPassword:@"Password25292"];
    XCTAssertEqual(response.responseCode, 200);
}
- (void)test_607_GetNewAuthorizationToken{
    AuthorizationManagement *auth = [[AuthorizationManagement alloc]init];
    CloudResponse *response = [auth getNewAuthorizationTokenWithUsername:@"intel.aricent.iot6@gmail.com" andPassword:@"Password25292"];
    XCTAssertEqual(response.responseCode, 200);
}
- (void)test_608_RequestChangePassword{
    CloudResponse *response = [_userManagementObject requestChangePasswordOn:@"intel.aricent.iot6@gmail.com"];
    XCTAssertEqual(response.responseCode, 200);
}
- (void)test_609_UpdateForgotPassword{
    CloudResponse *response = [_userManagementObject updateForgotPassword:@"dxmYkK0VNkJdTdqc" AndNewPassword:@"Password2529"];
    XCTAssertEqual(response.responseCode, 200);
}
- (void)test_610_DeleteAUser{
    CloudResponse *response = [_userManagementObject deleteUser:[HttpUrlBuilder getUserId]];
    XCTAssertEqual(response.responseCode, 204);
}
@end
