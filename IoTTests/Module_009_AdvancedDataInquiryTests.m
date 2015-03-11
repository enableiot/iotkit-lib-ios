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
#import "IoTKitLib/AdvancedDataInquiry.h"

@interface Module_009_AdvancedDataInquiryTests : BasicSetup

@property(nonatomic,retain)AdvancedDataInquiry *objAdvancedDataInquiry;

@end

@implementation Module_009_AdvancedDataInquiryTests

- (void)setUp {
    [super setUp];
    _objAdvancedDataInquiry = [[AdvancedDataInquiry alloc]initAdvancedDataInquiryWithDefaults];
}

- (void)tearDown {
    _objAdvancedDataInquiry = nil;
    [super tearDown];
}

- (void)test_901_AdvancedDataInquiry {
    [self configureResponseDelegateWithExpectedResponseCode:200];
    [_objAdvancedDataInquiry addGatewayId:[HttpUrlBuilder getDeviceId]];
    //[objAdvancedDataInquiry addGatewayId:@"devTest"];
    
    [_objAdvancedDataInquiry addDeviceId:[HttpUrlBuilder getDeviceId]];
    //[objAdvancedDataInquiry addDeviceId:@"devTest"];
    
    [_objAdvancedDataInquiry addComponentId:[HttpUrlBuilder getComponentId:[HttpUrlBuilder getComponentName]]];
    //[_objAdvancedDataInquiry addComponentId:@"42A9690E-C837-4E46-ADA9-88A7E77D0760"];
    //[objAdvancedDataInquiry addComponentId:@"b780757a-4a45-40f3-9804-60eee953e8d2"];
    
    [_objAdvancedDataInquiry setStartTimestamp:0L];
    [_objAdvancedDataInquiry setEndTimestamp:[self getCurrentTimeInMillis]];
    
    //[_objAdvancedDataInquiry addReturnedMeasureAttributes:@"Processor"];
    //[_objAdvancedDataInquiry addReturnedMeasureAttributes:@"Camera"];
    //[_objAdvancedDataInquiry addReturnedMeasureAttributes:@"attr_3"];
    
    //[_objAdvancedDataInquiry setShowMeasureLocation:true];
    //dev comp attrs
    AttributeFilter *devCompAttributeFilter1 = [[AttributeFilter alloc] initAttributeFilter:@"Tags"];
    [devCompAttributeFilter1 addAttributeFilterValues:@"created from MAC book pro"];
    [devCompAttributeFilter1 addAttributeFilterValues:@"Intel ODC test dev"];
    
    AttributeFilter *devCompAttributeFilter2 = [[AttributeFilter alloc] initAttributeFilter:@"componentType"];
    [devCompAttributeFilter2 addAttributeFilterValues:@"temperature.v1.0"];
    
    [_objAdvancedDataInquiry addDevCompAttributeFilter:devCompAttributeFilter1];
    [_objAdvancedDataInquiry addDevCompAttributeFilter:devCompAttributeFilter2];
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
    //    [_objAdvancedDataInquiry addMeasurementAttributeFilter:measurementAttributeFilter1];
    //    [_objAdvancedDataInquiry addMeasurementAttributeFilter:measurementAttributeFilter2];
    //
    //    //value filter
    //    AttributeFilter *valueFilter = [[AttributeFilter alloc] initAttributeFilter:@"value"];
    //    [valueFilter addAttributeFilterValues:@"filter_value1"];
    //    [valueFilter addAttributeFilterValues:@"filter_value2"];
    //    [valueFilter addAttributeFilterValues:@"filter_value3"];
    //    [_objAdvancedDataInquiry addValueFilter:valueFilter];
    
    [_objAdvancedDataInquiry setComponentRowLimit:5];
    //[_objAdvancedDataInquiry setCountOnly:true];
    //sort
    [_objAdvancedDataInquiry addSortInfo:@"Timestamp" WithValue:@"Asc"];
    [_objAdvancedDataInquiry addSortInfo:@"Value" WithValue:@"Desc"];
    
    [_objAdvancedDataInquiry request];
    [self waitForServerResponse];
}


@end
