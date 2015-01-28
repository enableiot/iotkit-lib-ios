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
#import "IoTKitLib/DeviceManagament.h"

@interface Module_003_DeviceManagementTests : BasicSetup

@property(nonatomic,retain)DeviceManagament *deviceObject;

@end

@implementation Module_003_DeviceManagementTests

- (void)setUp {
    [super setUp];
    _deviceObject = [[DeviceManagament alloc] init];
}

- (void)tearDown {
    _deviceObject = nil;
    [super tearDown];
}

- (void)test_301_CreateNewDevice{
    [self configureResponseDelegateWithExpectedResponseCode:201];
    NSString *devId = [self getRandomDeviceId];
    CreateDevice *createDevice = [CreateDevice createDeviceWithDeviceName:[self getRandomDeviceName]
                                                              andDeviceId:devId andGatewayId:devId];
    [createDevice addLocationInfo:12.0 AndLongitude:25.0 ANdHeight:15.0];
    [createDevice addTagName:@"created from MAC book pro"];
    [createDevice addTagName:@"Intel ODC test dev"];
    [createDevice addAttributeName:@"Processor" andValue:@"AMD"];
    [createDevice addAttributeName:@"Camera" andValue:@"8MP"];
    [createDevice addAttributeName:@"Wifi" andValue:@"YES"];
    [createDevice addAttributeName:@"Retina Display" andValue:@"NO"];
    XCTAssertTrue([_deviceObject createNewDevice:createDevice]);
    [self waitForServerResponse];
}
- (void)test_302_UpdateADevice{
    [self configureResponseDelegateWithExpectedResponseCode:200];
    CreateDevice *updateDevice = [CreateDevice createDeviceWithDeviceName:[self getRandomDeviceName]
                                                              andDeviceId:nil andGatewayId:[HttpUrlBuilder getDeviceId]];
    [updateDevice addLocationInfo:15.0 AndLongitude:25.0 ANdHeight:20.0];
    [updateDevice addTagName:@"created from MAC book pro"];
    [updateDevice addTagName:@"Intel ODC test dev"];
    [updateDevice addAttributeName:@"Processor" andValue:@"INTEL"];
    [updateDevice addAttributeName:@"Camera" andValue:@"8MP"];
    [updateDevice addAttributeName:@"Wifi" andValue:@"YES"];
    [updateDevice addAttributeName:@"Retina Display" andValue:@"YES"];
    XCTAssertTrue([_deviceObject updateADevice:updateDevice]);
    [self waitForServerResponse];
}
- (void)test_303_GetDeviceList{
    [self configureResponseDelegateWithExpectedResponseCode:200];
    XCTAssertTrue([_deviceObject listAllDevices]);
    [self waitForServerResponse];
}
- (void)test_304_GetMyDeviceInfo{
    [self configureResponseDelegateWithExpectedResponseCode:200];
    XCTAssertTrue([_deviceObject getMyDeviceInfo]);
    [self waitForServerResponse];
}
- (void)test_305_GetInfoOnDevice{
    [self configureResponseDelegateWithExpectedResponseCode:200];
    XCTAssertTrue([_deviceObject getInfoOnDevice:[HttpUrlBuilder getDeviceId]]);
    [self waitForServerResponse];
}
- (void)test_306_ActivateADevice{
    [self configureResponseDelegateWithExpectedResponseCode:200];
    XCTAssertTrue([_deviceObject activateADevice:[HttpUrlBuilder getAccountActivationCode]]);
    [self waitForServerResponse];
}
- (void)test_307_AddComponentToDevice{
    [self configureResponseDelegateWithExpectedResponseCode:201];
    XCTAssertTrue([_deviceObject addComponentToDevice:[self getRandomDeviceComponentName] WithType:@"temperature.v1.0"]);
    [self waitForServerResponse];
}
- (void)test_308_GetAllAttributes{
    [self configureResponseDelegateWithExpectedResponseCode:200];
    XCTAssertTrue([_deviceObject listAllDeviceAttributes]);
    [self waitForServerResponse];
}
- (void)test_309_GetAllTags{
    [self configureResponseDelegateWithExpectedResponseCode:200];
    XCTAssertTrue([_deviceObject listAllDeviceTags]);
    [self waitForServerResponse];
}
- (void)test_310_DeleteAComponent{
    [self configureResponseDelegateWithExpectedResponseCode:204];
    XCTAssertTrue([_deviceObject deleteAComponent:[HttpUrlBuilder getComponentName]]);
    [self waitForServerResponse];
}
- (void)test_311_DeleteADevice{
    [self configureResponseDelegateWithExpectedResponseCode:204];
    XCTAssertTrue([_deviceObject deleteADevice:[HttpUrlBuilder getDeviceId]]);
    [self waitForServerResponse];
}

@end
