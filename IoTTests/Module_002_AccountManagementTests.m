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
#import "IoTKitLib/AccountManagement.h"
#import "IoTKitLib/AuthorizationManagement.h"

@interface Module_002_AccountManagementTests :BasicSetup

@property(nonatomic,retain)AccountManagement *accountManagementObject;

@end

@implementation Module_002_AccountManagementTests

- (void)setUp {
    [super setUp];
    _accountManagementObject = [[AccountManagement alloc] init];
}
- (void)tearDown {
    _accountManagementObject = nil;
    [super tearDown];
}

- (void)test_201_CreateAnAccount {
    [self configureResponseDelegateWithExpectedResponseCode:201];
    XCTAssertTrue([_accountManagementObject createAnAccount:[self getRandomAccountName]]);
    [self waitForServerResponse];
}
- (void)test_202_GetNewAuthorizationToken{
    [self configureResponseDelegateWithExpectedResponseCode:200];
    AuthorizationManagement *auth = [[AuthorizationManagement alloc]init];
    XCTAssertTrue([auth getNewAuthorizationTokenWithUsername:@"intel.aricent.iot5@gmail.com" andPassword:@"Password2529"]);
    [self waitForServerResponse];
}
- (void)test_203_GetAccountInformation {
    [self configureResponseDelegateWithExpectedResponseCode:200];
    XCTAssertTrue([_accountManagementObject getAccountInformation]);
    [self waitForServerResponse];
}
- (void)test_204_RenewAccountActivationCode {
    [self configureResponseDelegateWithExpectedResponseCode:200];
    XCTAssertTrue([_accountManagementObject renewAccountActivationCode]);
    [self waitForServerResponse];
}
- (void)test_205_GetAccountActivationCode {
    [self configureResponseDelegateWithExpectedResponseCode:200];
    XCTAssertTrue([_accountManagementObject getAccountActivationCode]);
    [self waitForServerResponse];
}
- (void)test_206_AddAnotherUserToYourAccount {
    [self configureResponseDelegateWithExpectedResponseCode:200];
    XCTAssertTrue([_accountManagementObject addAnotherUserToAccount:[HttpUrlBuilder getAccountId] UserGettingInvited:@"545b0cb707024be10dec1152" Admin:false]);
    [self waitForServerResponse];
}
- (void)test_207_UpdateAnAccount {
    [self configureResponseDelegateWithExpectedResponseCode:200];
    XCTAssertTrue([_accountManagementObject updateAnAccount:[HttpUrlBuilder getAccountName]
                   andOptionalAttributesWithSimpleKeyValues:nil]);
    [self waitForServerResponse];
}
- (void)test_208_DeleteAnAccount {
    [self configureResponseDelegateWithExpectedResponseCode:204];
    XCTAssertTrue([_accountManagementObject deleteAnAccount]);
    [self waitForServerResponse];
}
@end
