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
#import "IoTKitLib/AggregatedReportInterface.h"

@interface Module_010_AggregatedReportInterfaceTests : BasicSetup

@property(nonatomic,retain)AggregatedReportInterface *aggregatedReportInterfaceObject;

@end

@implementation Module_010_AggregatedReportInterfaceTests

- (void)setUp {
    [super setUp];
    _aggregatedReportInterfaceObject = [[AggregatedReportInterface alloc]
                                        initAggregatedReportInterfaceWithDefaults];
}

- (void)tearDown {
    _aggregatedReportInterfaceObject = nil;
    [super tearDown];
}

- (void)test_1001_AggregatedReportInterface {
    [self configureResponseDelegateWithExpectedResponseCode:200];
    //[_aggregatedReportInterfaceObject setReportMessageType:@"aggregatedReportRequest"];
    [_aggregatedReportInterfaceObject addReportGatewayIds:[HttpUrlBuilder getDeviceId]];
    //[_aggregatedReportInterfaceObject addReportGatewayIds:@"qwertyPAD1"];
    //[_aggregatedReportInterfaceObject addReportGatewayIds:@"devTest"];
   
    [_aggregatedReportInterfaceObject addReportDeviceIds:[HttpUrlBuilder getDeviceId]];
    //[_aggregatedReportInterfaceObject addReportDeviceIds:@"qwertyPAD1"];
    //[_aggregatedReportInterfaceObject addReportDeviceIds:@"devTest"];
    
    [_aggregatedReportInterfaceObject addReportComponentIds:[HttpUrlBuilder getComponentId:
                                                             [HttpUrlBuilder getComponentName]]];
    /*[_aggregatedReportInterfaceObject addReportComponentIds:@"42A9690E-C837-4E46-ADA9-88A7E77D0760"];
    [_aggregatedReportInterfaceObject addReportComponentIds:@"b780757a-4a45-40f3-9804-60eee953e8d2"];
    [_aggregatedReportInterfaceObject addReportComponentIds:@"5C09B9F0-E06B-404A-A882-EAC64675A63E"];
    [_aggregatedReportInterfaceObject addReportComponentIds:@"BB9E347D-7895-437E-9ECA-8069879090B7"];*/
    
    
    
    [_aggregatedReportInterfaceObject setReportStartTimestamp:0L];
    [_aggregatedReportInterfaceObject setReportEndTimestamp:[self getCurrentTimeInMillis]];
    
    //report filters
    AttributeFilter *filter1 = [[AttributeFilter alloc] initAttributeFilter:@"Tags"];
    [filter1 addAttributeFilterValues:@"created from MAC book pro"];
    [filter1 addAttributeFilterValues:@"Intel ODC test dev"];
    
    [_aggregatedReportInterfaceObject addFilters:filter1];
    
    [_aggregatedReportInterfaceObject setOutputType:@"json"];
    [_aggregatedReportInterfaceObject setLimit:100];
    [_aggregatedReportInterfaceObject setOffset:0];
    
    [_aggregatedReportInterfaceObject addAggregationMethods:@"average"];
    [_aggregatedReportInterfaceObject addAggregationMethods:@"min"];
    [_aggregatedReportInterfaceObject addAggregationMethods:@"max"];
    [_aggregatedReportInterfaceObject addAggregationMethods:@"sum"];
    
    /*[_aggregatedReportInterfaceObject addDimensions:@"dim1"];
    [_aggregatedReportInterfaceObject addDimensions:@"dim2"];*/

    //[_aggregatedReportInterfaceObject setReportCountOnly:true];
    //sort
    [_aggregatedReportInterfaceObject addReportSortInfo:@"timeHour" AndValue:@"Asc"];
    //[_aggregatedReportInterfaceObject addReportSortInfo:@"sortField2" AndValue:@"Desc"];
    XCTAssertTrue([_aggregatedReportInterfaceObject getAggregatedReportInterface]);
    [self waitForServerResponse];
}


@end
