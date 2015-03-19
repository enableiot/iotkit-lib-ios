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
    NSString *devId = [self getRandomDeviceId];
    Device *device = [Device createDeviceWithDeviceName:[self getRandomDeviceName]
                                                              andDeviceId:devId andGatewayId:devId];
    [device addLocationInfo:12.0 AndLongitude:25.0 ANdHeight:15.0];
    [device addTagName:@"created from MAC book pro"];
    [device addTagName:@"Intel ODC test dev"];
    [device addAttributeName:@"Processor" andValue:@"AMD"];
    [device addAttributeName:@"Camera" andValue:@"8MP"];
    [device addAttributeName:@"Wifi" andValue:@"YES"];
    [device addAttributeName:@"Retina Display" andValue:@"NO"];
    CloudResponse *response = [_deviceObject createNewDevice:device];
    XCTAssertEqual(response.responseCode, 201);
}
- (void)test_302_UpdateADevice{
    Device *updateDevice = [Device createDeviceWithDeviceName:[self getRandomDeviceName]
                                                              andDeviceId:nil andGatewayId:[HttpUrlBuilder getDeviceId]];
    [updateDevice addLocationInfo:15.0 AndLongitude:25.0 ANdHeight:20.0];
    [updateDevice addTagName:@"created from MAC book pro"];
    [updateDevice addTagName:@"Intel ODC test dev"];
    [updateDevice addAttributeName:@"Processor" andValue:@"INTEL"];
    [updateDevice addAttributeName:@"Camera" andValue:@"8MP"];
    [updateDevice addAttributeName:@"Wifi" andValue:@"YES"];
    [updateDevice addAttributeName:@"Retina Display" andValue:@"YES"];
    CloudResponse *response = [_deviceObject updateADevice:updateDevice];
    XCTAssertEqual(response.responseCode, 200);
}
- (void)test_303_GetDeviceList{
    CloudResponse *response = [_deviceObject getDeviceList];
    XCTAssertEqual(response.responseCode, 200);
}
- (void)test_304_GetMyDeviceInfo{
    CloudResponse *response = [_deviceObject getMyDeviceInfo];
    XCTAssertEqual(response.responseCode, 200);
}
- (void)test_305_GetInfoOnDevice{
    CloudResponse *response = [_deviceObject getInfoOnDevice:[HttpUrlBuilder getDeviceId]];
    XCTAssertEqual(response.responseCode, 200);
}
- (void)test_306_ActivateADevice{
    CloudResponse *response = [_deviceObject activateADevice:[HttpUrlBuilder getAccountActivationCode]];
    XCTAssertEqual(response.responseCode, 200);
}
- (void)test_307_AddComponentToDevice{
    CloudResponse *response = [_deviceObject addComponentToDevice:[self getRandomDeviceComponentName] WithType:@"temperature.v1.0"];
    XCTAssertEqual(response.responseCode, 201);
}
- (void)test_308_GetAllAttributes{
    CloudResponse *response = [_deviceObject getAllAttributes];
    XCTAssertEqual(response.responseCode, 200);
}
- (void)test_309_GetAllTags{
    CloudResponse *response = [_deviceObject getAllTags];
    XCTAssertEqual(response.responseCode, 200);
}
- (void)test_310_DeleteAComponent{
    CloudResponse *response = [_deviceObject deleteAComponent:[HttpUrlBuilder getComponentName]];
    XCTAssertEqual(response.responseCode, 204);
}
- (void)test_311_DeleteADevice{
    CloudResponse *response = [_deviceObject deleteADevice:[HttpUrlBuilder getDeviceId]];
    XCTAssertEqual(response.responseCode, 204);
}

@end
