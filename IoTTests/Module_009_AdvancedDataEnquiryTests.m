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
#import "IoTKitLib/AdvancedDataEnquiry.h"

@interface Module_009_AdvancedDataEnquiryTests : BasicSetup

@property(nonatomic,retain)AdvancedDataEnquiry *objAdvancedDataEnquiry;

@end

@implementation Module_009_AdvancedDataEnquiryTests

- (void)setUp {
    [super setUp];
    _objAdvancedDataEnquiry = [[AdvancedDataEnquiry alloc]initAdvancedDataEnquiryWithDefaults];
}

- (void)tearDown {
    _objAdvancedDataEnquiry = nil;
    [super tearDown];
}

- (void)test_901_AdvancedDataEnquiry {
    [self configureResponseDelegateWithExpectedResponseCode:200];
    [_objAdvancedDataEnquiry addGatewayIds:[HttpUrlBuilder getDeviceId]];
    //[objAdvancedDataEnquiry addGatewayIds:@"devTest"];
    
    [_objAdvancedDataEnquiry addDeviceIds:[HttpUrlBuilder getDeviceId]];
    //[objAdvancedDataEnquiry addDeviceIds:@"devTest"];
    
    [_objAdvancedDataEnquiry addComponentIds:[HttpUrlBuilder getComponentId:[HttpUrlBuilder getComponentName]]];
    //[_objAdvancedDataEnquiry addComponentIds:@"42A9690E-C837-4E46-ADA9-88A7E77D0760"];
    //[objAdvancedDataEnquiry addComponentIds:@"b780757a-4a45-40f3-9804-60eee953e8d2"];
    
    [_objAdvancedDataEnquiry setStartTimestamp:0L];
    [_objAdvancedDataEnquiry setEndTimestamp:[self getCurrentTimeInMillis]];
    
    //[_objAdvancedDataEnquiry addReturnedMeasureAttributes:@"Processor"];
    //[_objAdvancedDataEnquiry addReturnedMeasureAttributes:@"Camera"];
    //[_objAdvancedDataEnquiry addReturnedMeasureAttributes:@"attr_3"];
    
    //[_objAdvancedDataEnquiry setShowMeasureLocation:true];
    //dev comp attrs
    AttributeFilter *devCompAttributeFilter1 = [[AttributeFilter alloc] initAttributeFilter:@"Tags"];
    [devCompAttributeFilter1 addAttributeFilterValues:@"created from MAC book pro"];
    [devCompAttributeFilter1 addAttributeFilterValues:@"Intel ODC test dev"];
    
    AttributeFilter *devCompAttributeFilter2 = [[AttributeFilter alloc] initAttributeFilter:@"componentType"];
    [devCompAttributeFilter2 addAttributeFilterValues:@"temperature.v1.0"];
    
    [_objAdvancedDataEnquiry addDevCompAttributeFilter:devCompAttributeFilter1];
    [_objAdvancedDataEnquiry addDevCompAttributeFilter:devCompAttributeFilter2];
    //measure comp attrs
    //    AttributeFilter *measurementAttributeFilter1 = [[AttributeFilter alloc] initAttributeFilter:@"mfilter_1"];
    //    [measurementAttributeFilter1 addAttributeFilterValues:@"mValue1"];
    //    [measurementAttributeFilter1 addAttributeFilterValues:@"mValue2"];
    //    [measurementAttributeFilter1 addAttributeFilterValues:@"mValue3"];
    //
    //    AttributeFilter *measurementAttributeFilter2 = [[AttributeFilter alloc] initAttributeFilter:@"mfilter_2"];
    //    [measurementAttributeFilter1 addAttributeFilterValues:@"mValue11"];
    //    [measurementAttributeFilter1 addAttributeFilterValues:@"mValue22"];
    //    [measurementAttributeFilter1 addAttributeFilterValues:@"mValue33"];
    //
    //    [_objAdvancedDataEnquiry addMeasurementAttributeFilter:measurementAttributeFilter1];
    //    [_objAdvancedDataEnquiry addMeasurementAttributeFilter:measurementAttributeFilter2];
    //
    //    //value filter
    //    AttributeFilter *valueFilter = [[AttributeFilter alloc] initAttributeFilter:@"value"];
    //    [valueFilter addAttributeFilterValues:@"filter_value1"];
    //    [valueFilter addAttributeFilterValues:@"filter_value2"];
    //    [valueFilter addAttributeFilterValues:@"filter_value3"];
    //    [_objAdvancedDataEnquiry addValueFilter:valueFilter];
    
    [_objAdvancedDataEnquiry setComponentRowLimit:5];
    //[_objAdvancedDataEnquiry setCountOnly:true];
    //sort
    [_objAdvancedDataEnquiry addSortInfo:@"Timestamp" WithValue:@"Asc"];
    [_objAdvancedDataEnquiry addSortInfo:@"Value" WithValue:@"Desc"];
    
    [_objAdvancedDataEnquiry advancedDataEnquiry];
    [self waitForServerResponse];
}


@end
