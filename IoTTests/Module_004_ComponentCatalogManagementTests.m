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
#import "IoTKitLib/ComponentCatalogManagement.h"

@interface Module_004_ComponentCatalogManagementTests : BasicSetup

@property(nonatomic,retain)ComponentCatalogManagement *componentCatalogObject;

@end

@implementation Module_004_ComponentCatalogManagementTests

- (void)setUp {
    [super setUp];
    _componentCatalogObject = [[ComponentCatalogManagement alloc]init];
}

- (void)tearDown {
    _componentCatalogObject = nil;
    [super tearDown];
}
- (void)test_401_ListAllComponentTypesCatalog{
    [self configureResponseDelegateWithExpectedResponseCode:200];
    XCTAssertTrue([_componentCatalogObject listAllComponentTypesCatalog]);
    [self waitForServerResponse];
}
- (void)test_402_ListAllDetailsOfComponentTypesCatalog{
    [self configureResponseDelegateWithExpectedResponseCode:200];
    XCTAssertTrue([_componentCatalogObject listAllDetailsOfComponentTypesCatalog]);
    [self waitForServerResponse];
}
- (void)test_403_ListComponentTypeDetails{
    [self configureResponseDelegateWithExpectedResponseCode:200];
    XCTAssertTrue([_componentCatalogObject listComponentTypeDetails:@"temperature.v1.0"]);
    [self waitForServerResponse];
}
- (void)test_404_CreateCustomComponent{
    [self configureResponseDelegateWithExpectedResponseCode:201];
    ComponentCatalog *createComponentCatalog = [ComponentCatalog ComponentCatalogWith:[self getRandomCustomComponentName] AndVersion:@"1.0" AndType:@"actuator" AndDataType:@"Number" AndFormat:@"float" AndUnit:@"Degrees Celsius" AndDisplay:@"timeSeries"];
    [createComponentCatalog setMinValue:5.0];
    [createComponentCatalog setMaxValue:100.0];
    [createComponentCatalog setCommandString:@"Intel actuator"];
    [createComponentCatalog addCommandParameters:@"AC1" AndValue:@"30-40"];
    [createComponentCatalog addCommandParameters:@"AC2" AndValue:@"35-48"];
    [createComponentCatalog addCommandParameters:@"AC3" AndValue:@"32-38"];
    [createComponentCatalog addCommandParameters:@"TrueAC" AndValue:@"20-30"];
    [createComponentCatalog addCommandParameters:@"LiveAC" AndValue:@"10-20"];
    XCTAssertTrue([_componentCatalogObject createCustomComponent:createComponentCatalog]);
    [self waitForServerResponse];
}
- (void)test_405_UpdateAComponent{
    [self configureResponseDelegateWithExpectedResponseCode:201];
    ComponentCatalog *updateComponentCatalog = [ComponentCatalog ComponentCatalogWith:nil AndVersion:nil AndType:@"actuator" AndDataType:@"Number" AndFormat:@"integer" AndUnit:@"Degrees Celsius" AndDisplay:@"timeSeries"];
    [updateComponentCatalog setMinValue:5.0];
    [updateComponentCatalog setMaxValue:100.0];
    [updateComponentCatalog setCommandString:@"Intel actuator"];
    [updateComponentCatalog addCommandParameters:@"AC1" AndValue:@"35-40"];
    [updateComponentCatalog addCommandParameters:@"AC2" AndValue:@"25-48"];
    [updateComponentCatalog addCommandParameters:@"AC3" AndValue:@"32-38"];
    [updateComponentCatalog addCommandParameters:@"TrueAC" AndValue:@"10-30"];
    [updateComponentCatalog addCommandParameters:@"LiveAC" AndValue:@"0-20"];
    XCTAssertTrue([_componentCatalogObject updateAComponent:updateComponentCatalog OnComponent:
                   [[self getCustomComponentName] stringByAppendingString:@".V1.0"]]);
    [self waitForServerResponse];
}


@end
