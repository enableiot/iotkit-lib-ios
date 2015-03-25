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

#import "DefaultConfiguration.h"
#import "AttributeFilter.h"

/*!
 * Advanced Data Inquiry allows querying measurement data (values, location and attributes) for
 * a single account using advanced filtering and sorting.
 */
@interface AdvancedDataInquiry : DefaultConfiguration

-(id) init __attribute__((unavailable("Must create object using \"initAdvancedDataInquiryWithDefaults\" method")));

/*!
 * Creates custom instance of the class AdvancedDataEnquiry
 *
 * @return an instance of the class AdvancedDataEnquiry
 */
-(id)initAdvancedDataInquiryWithDefaults;

/*!
 * Add a gateway id that is requested for the data in the report.
 * @param gatewayId The gateway identifier for gateway data to be included in the report.
 */
-(void)addGatewayId:(NSString*)gatewayId;

/*!
 * Add a device id that is requested for the data in the report.
 * @param deviceId The device identifier for device data to be included in the report.
 */
-(void)addDeviceId:(NSString*)deviceId;

/*!
 * Add a component id that is requested for the data in the report.
 * @param componentId The component identifier for component data to be included in the report.
 */
-(void)addComponentId:(NSString*)componentId;

/*!
 * Set the start time for query data in be included in the report.
 * @param timestamp time in milliseconds since epoch time.
 */
-(void)setStartTimestamp:(long)timestamp;

/*!
 * Set the end time for query data in be included in the report.
 * @param timestamp time in milliseconds since epoch time.
 */
-(void)setEndTimestamp:(long)timestamp;

/*!
 * Add a requested attribute to a list of attributes that will be return for each measurement.
 * @param attribute The attribute to add to the list of attributes that will be part of the request.
 */
-(void)addReturnedMeasureAttributes:(NSString*)attribute;

/*!
 * Request for location (lat, long, alt) as part of each returned measurement.
 * @param measureLocation if true returns location.
 */
-(void)setShowMeasureLocation:(BOOL)measureLocation;

/*!
 * Append device comp attribute filter to list. Filters by device and/or component attributes.
 * @param attributeFilter The filter to filtered by
 */
-(void)addDevCompAttributeFilter:(AttributeFilter*)attributeFilter;

/*!
 * Append measurement attribute filter to list. Filters by measurement attributes.
 * @param attributeFilter The filter to filtered by
 */
-(void)addMeasurementAttributeFilter:(AttributeFilter*)attributeFilter;

/*!
 * Append avalue filter to list. Filters by measurement values.
 * @param attributeFilter The filter to filtered by
 */
-(void)addValueFilter:(AttributeFilter*)attributeFilter;

/*!
 * Limits the number of records returned for each component in the report.
 * @param rowLimit the number of row that will be returned.
 */
-(void)setComponentRowLimit:(NSInteger)rowLimit;

/*!
 * Setting to true will return the number of rows that would have returned from this report.
 * @param countOnly true will return number of rows.
 */
-(void)setCountOnly:(BOOL)countOnly;

/*!
 * Append sort key-value pair to list for query to be sorted by
 * @param name The name of the key
 * @param value The value of the key
 */
-(void)addSortInfo:(NSString*)name WithValue:(NSString*)value;

/**
 * Starts a request for the report.
 *
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 */
-(CloudResponse *)request;


@end
