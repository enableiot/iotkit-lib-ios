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
#import "IoTKitLib/InvitationManagement.h"

@interface Module_007_InvitationManagementTests : BasicSetup

@property(nonatomic,retain)InvitationManagement *invitationObject;

@end

@implementation Module_007_InvitationManagementTests

- (void)setUp {
    [super setUp];
    _invitationObject = [[InvitationManagement alloc]init];
}

- (void)tearDown {
    _invitationObject = nil;
    [super tearDown];
}
- (void)test_701_CreateInvitation{
    CloudResponse *response = [_invitationObject createInvitationTo:@"intel.aricent.iot3@gmail.com"];
    XCTAssertEqual(response.responseCode, 201);
}
- (void)test_702_GetInvitationListSendToSpecificUser{
    CloudResponse *response = [_invitationObject getInvitationListSendToSpecificUser:@"intel.aricent.iot3@gmail.com"];
    XCTAssertEqual(response.responseCode, 200);
}
- (void)test_703_GetListOfInvitation{
    CloudResponse *response = [_invitationObject getListOfInvitation];
    XCTAssertEqual(response.responseCode, 200);
}
- (void)test_704_DeleteInvitations{
    CloudResponse *response = [_invitationObject deleteInvitationsTo:@"intel.aricent.iot3@gmail.com"];
    XCTAssertEqual(response.responseCode, 200);
}
@end
