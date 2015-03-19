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
    CloudResponse *response = [_accountManagementObject createAnAccount:[self getRandomAccountName]];
    XCTAssertEqual(response.responseCode, 201);
}
- (void)test_202_GetNewAuthorizationToken{
     AuthorizationManagement *auth = [[AuthorizationManagement alloc]init];
    CloudResponse *response = [auth getNewAuthorizationTokenWithUsername:@"intel.aricent.iot6@gmail.com" andPassword:@"Password2529"];
    XCTAssertEqual(response.responseCode, 200);
}
- (void)test_203_GetAccountInformation {
    CloudResponse *response = [_accountManagementObject getAccountInformation];
    XCTAssertEqual(response.responseCode, 200);
}
- (void)test_204_RenewAccountActivationCode {
    CloudResponse *response = [_accountManagementObject renewAccountActivationCode];
    XCTAssertEqual(response.responseCode, 200);
}
- (void)test_205_GetAccountActivationCode {
    CloudResponse *response = [_accountManagementObject getAccountActivationCode];
    XCTAssertEqual(response.responseCode, 200);
}
- (void)test_206_AddAnotherUserToYourAccount {
    CloudResponse *response = [_accountManagementObject addAnotherUserToAccount:[HttpUrlBuilder getAccountId] UserGettingInvited:@"545b0cb707024be10dec1152" Admin:true];
    XCTAssertEqual(response.responseCode, 200);
}
- (void)test_207_UpdateAnAccount {
    CloudResponse *response = [_accountManagementObject updateAnAccount:[HttpUrlBuilder getAccountName]
                               andOptionalAttributesWithSimpleKeyValues:nil];
    XCTAssertEqual(response.responseCode, 200);
}
- (void)test_208_DeleteAnAccount {
    CloudResponse *response = [_accountManagementObject deleteAnAccount];
    XCTAssertEqual(response.responseCode, 204);
}
@end
