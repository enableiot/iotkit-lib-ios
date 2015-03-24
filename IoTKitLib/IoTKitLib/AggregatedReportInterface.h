//
//  AggregatedReportInterface.h
//  IoT
//
//  Created by RaghavendraX Gutta on 15/12/14.
//  Copyright (c) 2014 Intel. All rights reserved.
//

#import "DefaultConfiguration.h"
#import "AttributeFilter.h"

/*!
 * AggregatedReportInterface allows querying aggregated metrics data in a single account.
 */
@interface AggregatedReportInterface : DefaultConfiguration

-(id) init __attribute__((unavailable("Must create object using \"initAggregatedReportInterfaceWithDefaults\" method")));

/*!
 * Creates custom instance of the class AggregatedReportInterface
 *
 * @return instance of the class AggregatedReportInterface
 */
 -(id) initAggregatedReportInterfaceWithDefaults;

/*!
 * Set the start time for query data in be included in the report.
 * @param startTimestamp time in milliseconds since epoch time.
 */
-(void)setStartTimestamp:(long) startTimestamp;

/*!
 * Set the end time for query data in be included in the report.
 * @param endTimestamp time in milliseconds since epoch time.
 */
-(void)setEndTimestamp:(long) endTimestamp;

/*!
 * Add the aggregation method to the query request.
 * @param aggregation The aggregation method from the list of acceptable values of "min", "max",
 *                    "average", "std", "count" and "sum". The default is "average".
 */
-(void)addAggregationMethod:(NSString*) aggregation;

/*!
 * Add a dimension to a list of dimensions for measurements aggregation of the report.
 * @param dimension A dimension of either "timeHour", "componentName" or "deviceAttribute_any".
 */
-(void)addDimension:(NSString*) dimension;

/*!
 * The first row of the data to return in the report. If this is set the limit must be set also.
 * @param offset The offset into the row of data to retrieve the report.
 */
-(void)setOffset:(NSInteger) offset;

/*!
 * The maximum number of rows to include in the report.
 * @param limit the limit for the number of records return.
 */
-(void)setLimit:(NSInteger) limit;

/*!
 * Setting to true will return the number of rows that would have returned from this report.
 * @param countOnly true will return number of rows
 */
-(void)setCountOnly:(BOOL) countOnly;

/*!
 * Set the output type of the report to be returned.
 * @param outputType The desired output type of the data. The available options are "csv" or "json".
 *                   The default is "json".
 */
-(void)setOutputType:(NSString*) outputType;

/*!
 * Add a device id that is requested for the data in the report.
 * @param deviceId The device identifier for device data to be included in the report.
 */
-(void)addDeviceId:(NSString*) deviceId;

/*!
 * Add a gateway id that is requested for the data in the report.
 * @param gatewayId The gateway identifier for gateway data to be included in the report.
 */
-(void)addGatewayId:(NSString*) gatewayId;

/*!
 * Add a component id that is requested for the data in the report.
 * @param componentId The component identifier for component data to be included in the report.
 */
-(void)addComponentId:(NSString*) componentId;

/*!
 * Add the sort criteria to the query.
 * @param name The sort field name.
 * @param value The source value. It must be "Asc" or "Desc".
 */
-(void)addSortInfo:(NSString*) name AndValue:(NSString*)value;

/*!
 * Add attribute filter.
 * @param attributeFilter the filter to be added.
 */
-(void)addFilter:(AttributeFilter*) attributeFilter;

/*!
 * Starts a request for the report.
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 */
-(CloudResponse *)request;

@end
