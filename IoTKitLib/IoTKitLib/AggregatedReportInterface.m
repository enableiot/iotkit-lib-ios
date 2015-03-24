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

@property (nonatomic,retain)NSString *outType;
@property (nonatomic,retain)NSMutableArray *filters;
@property (nonatomic,retain)NSMutableArray *aggregationMethods;
@property (nonatomic,retain)NSMutableArray *dimensions;
@property (nonatomic,retain)NSMutableArray *gatewayIds;
@property (nonatomic,retain)NSMutableArray *deviceIds;
@property (nonatomic,retain)NSMutableArray *componentIds;
@property (nonatomic,retain)NSMutableDictionary *sort;
@property (nonatomic,assign)long startTS;
@property (nonatomic,assign)long endTS;
@property (nonatomic,assign)NSInteger reptOffset;
@property (nonatomic,assign)NSInteger reptLimit;
@property (nonatomic,assign)BOOL bCountOnly;

@end

@implementation AggregatedReportInterface
/***************************************************************************************************************************
 * FUNCTION NAME: initAggregatedReportInterfaceWithDefaults
 *
 * DESCRIPTION: Creates custom instance of the class AggregatedReportInterface
 **************************************************************************************************************************/
-(id) initAggregatedReportInterfaceWithDefaults {
    self = [super init];
    if(self){
        _startTS = 0L;
        _endTS = 0L;
        _reptOffset = 0;
        _reptLimit = 0;
        _bCountOnly = false;
    }
    return self;
}
/***************************************************************************************************************************
 * FUNCTION NAME: setStartTimestamp
 *
 * DESCRIPTION: set start time stamp
 **************************************************************************************************************************/
-(void)setStartTimestamp:(long) startTimestamp{
    _startTS = startTimestamp;
}
/***************************************************************************************************************************
 * FUNCTION NAME: setEndTimestamp
 *
 * DESCRIPTION: set end time stamp
 **************************************************************************************************************************/
-(void)setEndTimestamp:(long) endTimestamp{
    _endTS = endTimestamp;
}
/***************************************************************************************************************************
 * FUNCTION NAME: addAggregationMethod
 *
 * DESCRIPTION: append aggregated method to list
 **************************************************************************************************************************/
-(void)addAggregationMethod:(NSString*) aggregation{
    if (!_aggregationMethods) {
        _aggregationMethods = [NSMutableArray array];
    }
    [_aggregationMethods addObject:aggregation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: addDimension
 *
 * DESCRIPTION: append dimension to list
 **************************************************************************************************************************/
-(void)addDimension:(NSString*) dimension{
    if (!_dimensions) {
        _dimensions = [NSMutableArray array];
    }
    [_dimensions addObject:dimension];
}
/***************************************************************************************************************************
 * FUNCTION NAME: setOffset
 *
 * DESCRIPTION: set offset value
 **************************************************************************************************************************/
-(void)setOffset:(NSInteger) offset{
    _reptOffset = offset;
}
/***************************************************************************************************************************
 * FUNCTION NAME: setLimit
 *
 * DESCRIPTION: set limit on number of return results
 **************************************************************************************************************************/
-(void)setLimit:(NSInteger) limit{
    _reptLimit = limit;
}
/***************************************************************************************************************************
 * FUNCTION NAME: setCountOnly
 *
 * DESCRIPTION: sets to return number of results only
 **************************************************************************************************************************/
-(void)setCountOnly:(BOOL) countOnly{
    _bCountOnly = countOnly;
}
/***************************************************************************************************************************
 * FUNCTION NAME: setOutputType
 *
 * DESCRIPTION: set outputType of report
 **************************************************************************************************************************/
-(void)setOutputType:(NSString*) outputType{
    _outType = outputType;
}
/***************************************************************************************************************************
 * FUNCTION NAME: addDeviceId
 *
 * DESCRIPTION: append deviceId to query list
 **************************************************************************************************************************/
-(void)addDeviceId:(NSString*) deviceId{
    if (!_deviceIds) {
        _deviceIds = [NSMutableArray array];
    }
    [_deviceIds addObject:deviceId];
}
/***************************************************************************************************************************
 * FUNCTION NAME: addGatewayId
 *
 * DESCRIPTION: append gatewayId to list
 **************************************************************************************************************************/
-(void)addGatewayId:(NSString*) gatewayId{
    if (!_gatewayIds) {
        _gatewayIds = [NSMutableArray array];
    }
    [_gatewayIds addObject:gatewayId];
}
/***************************************************************************************************************************
 * FUNCTION NAME: addComponentId
 *
 * DESCRIPTION: append componentId to list
 **************************************************************************************************************************/
-(void)addComponentId:(NSString*) componentId{
    if (!_componentIds) {
        _componentIds = [NSMutableArray array];
    }
    [_componentIds addObject:componentId];
}
/***************************************************************************************************************************
 * FUNCTION NAME: addSortInfo
 *
 * DESCRIPTION: append sort key-value pair to list
 **************************************************************************************************************************/
-(void)addSortInfo:(NSString*) name AndValue:(NSString*)value{
    if (!_sort) {
        _sort = [NSMutableDictionary dictionary];
    }
    [_sort setObject:value forKey:name];
}
/***************************************************************************************************************************
 * FUNCTION NAME: addDimension
 *
 * DESCRIPTION: append filter object to list
 **************************************************************************************************************************/
-(void)addFilter:(AttributeFilter*) attributeFilter{
    if (!_filters) {
        _filters = [NSMutableArray array];
    }
    [_filters addObject:attributeFilter];
}
/***************************************************************************************************************************
 * FUNCTION NAME: request
 *
 * DESCRIPTION: method to create request on aggreagted report
 **************************************************************************************************************************/
-(CloudResponse *)request{
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
    
    [reportInterfaceJson setObject:[NSNumber numberWithInteger:_reptOffset] forKey:@"offset"];
    [reportInterfaceJson setObject:[NSNumber numberWithInteger:_reptLimit] forKey:@"limit"];
    if (_bCountOnly) {
        [reportInterfaceJson setObject:[NSNumber numberWithBool:_bCountOnly] forKey:@"countOnly"];
    }
    if (_outType) {
        [reportInterfaceJson setObject:_outType forKey:@"outputType"];
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
    [reportInterfaceJson setObject:[NSNumber numberWithLong:_startTS] forKey:@"from"];
    [reportInterfaceJson setObject:[NSNumber numberWithLong:_endTS] forKey:@"to"];
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
