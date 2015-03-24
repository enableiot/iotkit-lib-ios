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

#import "AdvancedDataInquiry.h"
#import "HttpRequestOperation.h"
#import "HttpResponseMacros.h"

#define TAG @"AdvancedDataEnquiry"

//##########AttributeFilter##########
@interface AttributeFilter ()

//@property(nonatomic,retain)NSString* filterName;
//@property(nonatomic,retain)NSMutableArray* filterValues;

@end

@implementation AttributeFilter
/***************************************************************************************************************************
 * FUNCTION NAME: initAttributeFilter
 *
 * DESCRIPTION: Creates custom instance of the class AttributeFilter
 *
 * RETURNS: instance of the class AttributeFilter
 *
 * PARAMETERS : filterName
 **************************************************************************************************************************/
-(id)initAttributeFilter:(NSString*)filterName{
    self = [super init];
    if(self){
        _filterName = filterName;
    }
    return self;
}
/***************************************************************************************************************************
 * FUNCTION NAME: addAttributeFilterValues
 *
 * DESCRIPTION: append filter value to list
 *
 * RETURNS: nothing
 *
 * PARAMETERS : filterValue
 **************************************************************************************************************************/
-(void)addAttributeFilterValues:(NSString*)filterValue{
    if(!_filterValues){
        _filterValues = [NSMutableArray array];
    }
    [_filterValues addObject:filterValue];
}

@end


//##########AdvancedDataInquiry##########
@interface AdvancedDataInquiry ()

@property(nonatomic,retain)NSString* msgType;
@property(nonatomic,retain)NSMutableArray* gatewayIds;
@property(nonatomic,retain)NSMutableArray* deviceIds;
@property(nonatomic,retain)NSMutableArray* componentIds;
@property(nonatomic,assign)long startTS;
@property(nonatomic,assign)long endTS;
@property(nonatomic,retain)NSMutableArray* returnedMeasureAttributes;
@property(nonatomic,assign)BOOL bShowMeasureLocation;
@property(nonatomic,retain)NSMutableArray* devCompAttributeFilter;
@property(nonatomic,retain)NSMutableArray* measurementAttributeFilter;
@property(nonatomic,retain)AttributeFilter* valueFilter;
@property(nonatomic,assign)NSInteger rowLimit;
@property(nonatomic,assign)BOOL bCountOnly;
@property(nonatomic,retain)NSMutableDictionary* sort;

@end


@implementation AdvancedDataInquiry

/***************************************************************************************************************************
 * FUNCTION NAME: initAdvancedDataInquiryWithDefaults
 *
 * DESCRIPTION: Creates custom instance of the class AdvancedDataEnquiry
 **************************************************************************************************************************/
-(id)initAdvancedDataInquiryWithDefaults{
    self = [super init];
    if(self){
        _startTS = 0L;
        _endTS = 0L;
        _bShowMeasureLocation = false;
        _rowLimit = 0;
        _bCountOnly = false;
    }
    return self;
}
/***************************************************************************************************************************
 * FUNCTION NAME: addGatewayId
 *
 * DESCRIPTION: append gatewayId to list
 **************************************************************************************************************************/
-(void)addGatewayId:(NSString*)gatewayId{
    if(!_gatewayIds){
        _gatewayIds = [NSMutableArray array];
    }
    [_gatewayIds addObject:gatewayId];
}
/***************************************************************************************************************************
 * FUNCTION NAME: addDeviceId
 *
 * DESCRIPTION: append deviceId method to list
 **************************************************************************************************************************/
-(void)addDeviceId:(NSString*)deviceId{
    if(!_deviceIds){
        _deviceIds = [NSMutableArray array];
    }
    [_deviceIds addObject:deviceId];
}
/***************************************************************************************************************************
 * FUNCTION NAME: addComponentId
 *
 * DESCRIPTION: append componentId method to list
 **************************************************************************************************************************/
-(void)addComponentId:(NSString*)componentId{
    if(!_componentIds){
        _componentIds = [NSMutableArray array];
    }
    [_componentIds addObject:componentId];
}
/***************************************************************************************************************************
 * FUNCTION NAME: setStartTimestamp
 *
 * DESCRIPTION: set start time stamp
 **************************************************************************************************************************/
-(void)setStartTimestamp:(long)timestamp{
    _startTS = timestamp;
}
/***************************************************************************************************************************
 * FUNCTION NAME: setEndTimestamp
 *
 * DESCRIPTION: set end time stamp
 **************************************************************************************************************************/
-(void)setEndTimestamp:(long)timestamp{
    _endTS = timestamp;
}
/***************************************************************************************************************************
 * FUNCTION NAME: addReturnedMeasureAttributes
 *
 * DESCRIPTION: append measure attribute to list
 **************************************************************************************************************************/
-(void)addReturnedMeasureAttributes:(NSString*)attribute{
    if(!_returnedMeasureAttributes){
        _returnedMeasureAttributes = [NSMutableArray array];
    }
    [_returnedMeasureAttributes addObject:attribute];
}
/***************************************************************************************************************************
 * FUNCTION NAME: setShowMeasureLocation
 *
 * DESCRIPTION: set whether to measure location on data inquiry
 **************************************************************************************************************************/
-(void)setShowMeasureLocation:(BOOL)measureLocation{
    _bShowMeasureLocation = measureLocation;
}
/***************************************************************************************************************************
 * FUNCTION NAME: addDevCompAttributeFilter
 *
 * DESCRIPTION: append dev comp attribute filter to list
 **************************************************************************************************************************/
-(void)addDevCompAttributeFilter:(AttributeFilter*)attributeFilter{
    if(!_devCompAttributeFilter){
        _devCompAttributeFilter = [NSMutableArray array];
    }
    [_devCompAttributeFilter addObject:attributeFilter];
}
/***************************************************************************************************************************
 * FUNCTION NAME: addMeasurementAttributeFilter
 *
 * DESCRIPTION: append measurement attribute filter to list
 **************************************************************************************************************************/
-(void)addMeasurementAttributeFilter:(AttributeFilter*)attributeFilter{
    if(!_measurementAttributeFilter){
        _measurementAttributeFilter = [NSMutableArray array];
    }
    [_measurementAttributeFilter addObject:attributeFilter];
}
/***************************************************************************************************************************
 * FUNCTION NAME: addValueFilter
 *
 * DESCRIPTION: append avalue filter to list
 **************************************************************************************************************************/
-(void)addValueFilter:(AttributeFilter*)attributeFilter{
    _valueFilter = attributeFilter;
}
/***************************************************************************************************************************
 * FUNCTION NAME: setComponentRowLimit
 *
 * DESCRIPTION: set component row limit for return results
 **************************************************************************************************************************/
-(void)setComponentRowLimit:(NSInteger)componentRowLimit{
    _rowLimit = componentRowLimit;
}
/***************************************************************************************************************************
 * FUNCTION NAME: setCountOnly
 *
 * DESCRIPTION: set count true to get only count from server else false
 **************************************************************************************************************************/
-(void)setCountOnly:(BOOL)countOnly{
    _bCountOnly = countOnly;
}
/***************************************************************************************************************************
 * FUNCTION NAME: addSortInfo
 *
 * DESCRIPTION: append sor key-value pair to list
 **************************************************************************************************************************/
-(void)addSortInfo:(NSString*)name WithValue:(NSString*)value{
    if(!_sort){
        _sort = [NSMutableDictionary dictionary];
    }
    [_sort setObject:value forKey:name];
}

/***************************************************************************************************************************
 * FUNCTION NAME: request
 *
 * DESCRIPTION: Inquire advanced data using different filters
 **************************************************************************************************************************/
-(CloudResponse *)request{
    NSData *data = [self createHttpBodyToEnquireData];
    NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"DATA:%@",myString);
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.advancedEnquiryOfData urlSlugValueList:nil];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:ADVANCEDENQUIRYOFDATA
                                                                     AndRequestBody:data
                                                                  AndHttpMethodType:HTTPPOST
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: createHttpBodyToEnquireData
 *
 * DESCRIPTION: method to create http Body on advanced dat enquiry
 *
 * RETURNS: data stream of request body
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(NSData*)createHttpBodyToEnquireData{
    NSMutableDictionary *dataInquiryJson = [NSMutableDictionary dictionary];
    
    //    if(!_msgType){
    //        [dataInquiryJson setObject:@"advancedDataInquiryRequest" forKey:@"msgType"];
    //    }else{
    //        [dataInquiryJson setObject:_msgType forKey:@"msgType"];
    //    }
    if (_gatewayIds) {
        NSMutableArray *gatewayArray = [NSMutableArray array];
        
        for (NSString *gatewayId in _gatewayIds) {
            [gatewayArray addObject:gatewayId];
        }
        [dataInquiryJson setObject:gatewayArray forKey:@"gatewayIds"];
    }
    if (_deviceIds) {
        NSMutableArray *deviceIdArray = [NSMutableArray array];
        
        for (NSString *deviceId in _deviceIds) {
            [deviceIdArray addObject:deviceId];
        }
        [dataInquiryJson setObject:deviceIdArray forKey:@"deviceIds"];
    }
    if (_componentIds) {
        NSMutableArray *componentIdArray = [NSMutableArray array];
        
        for (NSString *componentId in _componentIds) {
            [componentIdArray addObject:componentId];
        }
        [dataInquiryJson setObject:componentIdArray forKey:@"componentIds"];
    }
    [dataInquiryJson setObject:[NSNumber numberWithLong:_startTS] forKey:@"from"];
    [dataInquiryJson setObject:[NSNumber numberWithLong:_endTS] forKey:@"to"];
    
    
    //returnedMeasureAttributes
    if (_returnedMeasureAttributes) {
        NSMutableArray *returnedMeasureAttributesArray = [NSMutableArray array];
        for (NSString *attribute in _returnedMeasureAttributes) {
            [returnedMeasureAttributesArray addObject:attribute];
        }
        [dataInquiryJson setObject:returnedMeasureAttributesArray forKey:@"returnedMeasureAttributes"];
    }
    
    if (_bShowMeasureLocation) {
        [dataInquiryJson setObject:[NSNumber numberWithBool:_bShowMeasureLocation] forKey:@"showMeasureLocation"];
    }
    if (_rowLimit > 0) {
        [dataInquiryJson setObject:[NSNumber numberWithInteger:_rowLimit] forKey:@"componentRowLimit"];
    }
    //sort
    if (_sort) {
        NSMutableArray *sortArray = [NSMutableArray array];
        for(id key in _sort){
            NSDictionary *nameValueJson = [NSDictionary dictionaryWithObjectsAndKeys:[_sort objectForKey:key],key, nil];
            [sortArray addObject:nameValueJson];
            
        }
        [dataInquiryJson setObject:sortArray forKey:@"sort"];
    }
    if (_bCountOnly) {
        [dataInquiryJson setObject:[NSNumber numberWithBool:_bCountOnly] forKey:@"countOnly"];
    }
    if (_devCompAttributeFilter) {
        NSMutableDictionary *devCompAttributeJson = [NSMutableDictionary dictionary];
        for(AttributeFilter *attributeFilter in _devCompAttributeFilter){
            NSMutableArray *filterValuesArray = [NSMutableArray array];
            for (NSString *filterValue in attributeFilter.filterValues) {
                [filterValuesArray addObject:filterValue];
            }
            [devCompAttributeJson setObject:filterValuesArray forKey:attributeFilter.filterName];
        }
        [dataInquiryJson setObject:devCompAttributeJson forKey:@"devCompAttributeFilter"];
        
    }
    if (_measurementAttributeFilter) {
        NSMutableDictionary *measurementAttributeJson = [NSMutableDictionary dictionary];
        for(AttributeFilter *attributeFilter in _measurementAttributeFilter){
            NSMutableArray *filterValuesArray = [NSMutableArray array];
            for (NSString *filterValue in attributeFilter.filterValues) {
                [filterValuesArray addObject:filterValue];
            }
            [measurementAttributeJson setObject:filterValuesArray forKey:attributeFilter.filterName];
        }
        [dataInquiryJson setObject:measurementAttributeJson forKey:@"measurementAttributeFilter"];
        
    }
    if (_valueFilter) {
        NSMutableDictionary *valueFilterJson = [NSMutableDictionary dictionary];
        NSMutableArray *filterValuesArray = [NSMutableArray array];
        for (NSString *filterValue in _valueFilter.filterValues) {
            [filterValuesArray addObject:filterValue];
        }
        [valueFilterJson setObject:filterValuesArray forKey:_valueFilter.filterName];
        [dataInquiryJson setObject:valueFilterJson forKey:@"valueFilter"];
    }
    NSError *error;
    return [NSJSONSerialization dataWithJSONObject:dataInquiryJson
                                           options:NSJSONWritingPrettyPrinted
                                             error:&error];
}
@end


