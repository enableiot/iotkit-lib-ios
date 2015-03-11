//
//  AggregatedReportInterface.m
//  IoT
//
//  Created by RaghavendraX Gutta on 15/12/14.
//  Copyright (c) 2014 Intel. All rights reserved.
//

#import "AggregatedReportInterface.h"
#import "HttpRequestOperation.h"
#import "HttpResponseMacros.h"
#define TAG @"AggregatedReportInterface"

@interface AggregatedReportInterface ()

@property (nonatomic,retain)NSString *msgType;
@property (nonatomic,retain)NSString *outputType;
@property (nonatomic,retain)NSMutableArray *filters;
@property (nonatomic,retain)NSMutableArray *aggregationMethods;
@property (nonatomic,retain)NSMutableArray *dimensions;
@property (nonatomic,retain)NSMutableArray *gatewayIds;
@property (nonatomic,retain)NSMutableArray *deviceIds;
@property (nonatomic,retain)NSMutableArray *componentIds;
@property (nonatomic,retain)NSMutableDictionary *sort;
@property (nonatomic,assign)long startTimestamp;
@property (nonatomic,assign)long endTimestamp;
@property (nonatomic,assign)NSInteger offset;
@property (nonatomic,assign)NSInteger limit;
@property (nonatomic,assign)BOOL countOnly;

@end

@implementation AggregatedReportInterface
/***************************************************************************************************************************
 * FUNCTION NAME: initAggregatedReportInterfaceWithDefaults
 *
 * DESCRIPTION: Creates custom instance of the class AggregatedReportInterface
 *
 * RETURNS: instance of the class AggregatedReportInterface
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(id) initAggregatedReportInterfaceWithDefaults {
    self = [super init];
    if(self){
        _startTimestamp = 0L;
        _endTimestamp = 0L;
        _offset = 0;
        _limit = 0;
        _countOnly = false;
    }
    return self;
}
/***************************************************************************************************************************
 * FUNCTION NAME: setReportMessageType
 *
 * DESCRIPTION: set report message type
 *
 * RETURNS: nothing
 *
 * PARAMETERS : msgType
 **************************************************************************************************************************/
-(void)setReportMessageType:(NSString*) msgType {
    _msgType = msgType;
}
/***************************************************************************************************************************
 * FUNCTION NAME: setReportStartTimestamp
 *
 * DESCRIPTION: set start time stamp
 *
 * RETURNS: nothing
 *
 * PARAMETERS : startTimestamp
 **************************************************************************************************************************/
-(void)setReportStartTimestamp:(long) startTimestamp{
    _startTimestamp = startTimestamp;
}
/***************************************************************************************************************************
 * FUNCTION NAME: setReportEndTimestamp
 *
 * DESCRIPTION: set end time stamp
 *
 * RETURNS: nothing
 *
 * PARAMETERS : endTimestamp
 **************************************************************************************************************************/
-(void)setReportEndTimestamp:(long) endTimestamp{
    _endTimestamp = endTimestamp;
}
/***************************************************************************************************************************
 * FUNCTION NAME: addAggregationMethods
 *
 * DESCRIPTION: append aggregated method to list
 *
 * RETURNS: nothing
 *
 * PARAMETERS : aggregation type
 **************************************************************************************************************************/
-(void)addAggregationMethods:(NSString*) aggregation{
    if (!_aggregationMethods) {
        _aggregationMethods = [NSMutableArray array];
    }
    [_aggregationMethods addObject:aggregation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: addDimensions
 *
 * DESCRIPTION: append dimension to list
 *
 * RETURNS: nothing
 *
 * PARAMETERS : dimension type
 **************************************************************************************************************************/
-(void)addDimensions:(NSString*) dimension{
    if (!_dimensions) {
        _dimensions = [NSMutableArray array];
    }
    [_dimensions addObject:dimension];
}
/***************************************************************************************************************************
 * FUNCTION NAME: setOffset
 *
 * DESCRIPTION: set offset value
 *
 * RETURNS: nothing
 *
 * PARAMETERS : offset
 **************************************************************************************************************************/
-(void)setOffset:(NSInteger) offset{
    _offset = offset;
}
/***************************************************************************************************************************
 * FUNCTION NAME: setLimit
 *
 * DESCRIPTION: set limit on number of return results
 *
 * RETURNS: nothing
 *
 * PARAMETERS : limit
 **************************************************************************************************************************/
-(void)setLimit:(NSInteger) limit{
    _limit = limit;
}
/***************************************************************************************************************************
 * FUNCTION NAME: setReportCountOnly
 *
 * DESCRIPTION: sets to return number of results only
 *
 * RETURNS: nothing
 *
 * PARAMETERS : countOnly(true/false)
 **************************************************************************************************************************/
-(void)setReportCountOnly:(BOOL) countOnly{
    _countOnly = countOnly;
}
/***************************************************************************************************************************
 * FUNCTION NAME: setOutputType
 *
 * DESCRIPTION: set outputType of report
 *
 * RETURNS: nothing
 *
 * PARAMETERS : outputType
 **************************************************************************************************************************/
-(void)setOutputType:(NSString*) outputType{
    _outputType = outputType;
}
/***************************************************************************************************************************
 * FUNCTION NAME: addReportDeviceIds
 *
 * DESCRIPTION: append deviceId to query list
 *
 * RETURNS: nothing
 *
 * PARAMETERS : deviceId
 **************************************************************************************************************************/
-(void)addReportDeviceIds:(NSString*) deviceId{
    if (!_deviceIds) {
        _deviceIds = [NSMutableArray array];
    }
    [_deviceIds addObject:deviceId];
}
/***************************************************************************************************************************
 * FUNCTION NAME: addReportGatewayIds
 *
 * DESCRIPTION: append gatewayId to list
 *
 * RETURNS: nothing
 *
 * PARAMETERS : gatewayId
 **************************************************************************************************************************/
-(void)addReportGatewayIds:(NSString*) gatewayId{
    if (!_gatewayIds) {
        _gatewayIds = [NSMutableArray array];
    }
    [_gatewayIds addObject:gatewayId];
}
/***************************************************************************************************************************
 * FUNCTION NAME: addReportComponentIds
 *
 * DESCRIPTION: append componentId to list
 *
 * RETURNS: nothing
 *
 * PARAMETERS : componentId
 **************************************************************************************************************************/
-(void)addReportComponentIds:(NSString*) componentId{
    if (!_componentIds) {
        _componentIds = [NSMutableArray array];
    }
    [_componentIds addObject:componentId];
}
/***************************************************************************************************************************
 * FUNCTION NAME: addReportSortInfo
 *
 * DESCRIPTION: append sort key-value pair to list
 *
 * RETURNS: nothing
 *
 * PARAMETERS : name & value of sort type
 **************************************************************************************************************************/
-(void)addReportSortInfo:(NSString*) name AndValue:(NSString*)value{
    if (!_sort) {
        _sort = [NSMutableDictionary dictionary];
    }
    [_sort setObject:value forKey:name];
}
/***************************************************************************************************************************
 * FUNCTION NAME: addDimensions
 *
 * DESCRIPTION: append filter object to list
 *
 * RETURNS: nothing
 *
 * PARAMETERS : attributeFilter object
 **************************************************************************************************************************/
-(void)addFilters:(AttributeFilter*) attributeFilter{
    if (!_filters) {
        _filters = [NSMutableArray array];
    }
    [_filters addObject:attributeFilter];
}
/***************************************************************************************************************************
 * FUNCTION NAME: getAggregatedReportInterface
 *
 * DESCRIPTION: method to create request on aggreagted report
 *
 * RETURNS: true/false
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(BOOL)getAggregatedReportInterface{
    NSData *data = [self createHttpBodyToGetAggregatedReport];
    NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"DATA:%@",myString);
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.aggregatedReportInterface urlSlugValueList:nil];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:AGGREGATEDREPORTINTERFACE
                                                                     AndRequestBody:data
                                                                  AndHttpMethodType:HTTPPOST
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: createHttpBodyToGetAggregatedReport
 *
 * DESCRIPTION: method to create http Body on aggregated report request
 *
 * RETURNS: data stream of request body
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(NSData*)createHttpBodyToGetAggregatedReport{
    NSMutableDictionary *reportInterfaceJson = [NSMutableDictionary dictionary];
    
    [reportInterfaceJson setObject:[NSNumber numberWithInteger:_offset] forKey:@"offset"];
    [reportInterfaceJson setObject:[NSNumber numberWithInteger:_limit] forKey:@"limit"];
    if (_countOnly) {
        [reportInterfaceJson setObject:[NSNumber numberWithBool:_countOnly] forKey:@"countOnly"];
    }
    if (_outputType) {
        [reportInterfaceJson setObject:_outputType forKey:@"outputType"];
    }
    if (_aggregationMethods) {
        [reportInterfaceJson setObject:_aggregationMethods forKey:@"aggregationMethods"];
    }
    if (_dimensions) {
        [reportInterfaceJson setObject:_dimensions forKey:@"dimensions"];
    }
    if (_gatewayIds) {
        [reportInterfaceJson setObject:_gatewayIds forKey:@"gatewayIds"];
    }
    if (_deviceIds) {
        [reportInterfaceJson setObject:_deviceIds forKey:@"deviceIds"];
    }
    if (_componentIds) {
        NSMutableArray *componentIdArray = [NSMutableArray array];
        for (NSString *componentId in _componentIds) {
            [componentIdArray addObject:componentId];
        }
        [reportInterfaceJson setObject:componentIdArray forKey:@"componentIds"];
    }
    [reportInterfaceJson setObject:[NSNumber numberWithLong:_startTimestamp] forKey:@"from"];
    [reportInterfaceJson setObject:[NSNumber numberWithLong:_endTimestamp] forKey:@"to"];
    //sort
    if (_sort) {
        NSMutableArray *sortArray = [NSMutableArray array];
        for (id key in _sort) {
            [sortArray addObject:[NSDictionary dictionaryWithObject:[_sort objectForKey:key] forKey:key]];
        }
        [reportInterfaceJson setObject:sortArray forKey:@"sort"];
    }
    if (_filters) {
        NSMutableDictionary *filterJson = [NSMutableDictionary dictionary];
        for (AttributeFilter *attributeFilter in _filters) {
            NSMutableArray *filterValuesArray = [NSMutableArray array];
            for (NSString *filterValue in attributeFilter.filterValues) {
                [filterValuesArray addObject:filterValue];
            }
            [filterJson setObject:filterValuesArray forKey:attributeFilter.filterName];
        }
        [reportInterfaceJson setObject:filterJson forKey:@"filters"];
    }
    
    NSError *error;
    return [NSJSONSerialization dataWithJSONObject:reportInterfaceJson
                                           options:NSJSONWritingPrettyPrinted
                                             error:&error];
}
@end
