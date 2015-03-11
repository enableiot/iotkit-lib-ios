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

@interface Module_001_AuthorizationManagementTests : BasicSetup

@property(nonatomic,retain)AuthorizationManagement *authorizationObject;

@end

@implementation Module_001_AuthorizationManagementTests

- (void)setUp {
    [super setUp];
    _authorizationObject = [[AuthorizationManagement alloc] init];
    
}
- (void)tearDown {
    _authorizationObject = nil;
    [super tearDown];
}
- (void)test_101_GetNewAuthorizationToken {
    [self configureResponseDelegateWithExpectedResponseCode:200];
    XCTAssertTrue([_authorizationObject getNewAuthorizationTokenWithUsername:@"intel.aricent.iot5@gmail.com" andPassword:@"Password2529"]);
    [self waitForServerResponse];
}
- (void)test_103_GetAuthorizationTokenInfo {
    [self configureResponseDelegateWithExpectedResponseCode:200];
    XCTAssertTrue([_authorizationObject getAuthorizationTokenInfo]);
    [self waitForServerResponse];
}
- (void)test_102_ValidateAuthorizationToken{
    [self configureResponseDelegateWithExpectedResponseCode:200];
    XCTAssertTrue([_authorizationObject validateAuthorizationToken]);
    [self waitForServerResponse];
}

@end
