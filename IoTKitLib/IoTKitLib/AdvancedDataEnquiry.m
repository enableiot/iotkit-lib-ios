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

#import "AdvancedDataEnquiry.h"
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


//##########AttributeFilterList##########
@interface AttributeFilterList ()

//@property(nonatomic,retain)NSMutableArray *filterData;

@end

@implementation AttributeFilterList

@end

//##########AdvancedDataEnquiry##########
@interface AdvancedDataEnquiry ()

@property(nonatomic,retain)NSString* msgType;
@property(nonatomic,retain)NSMutableArray* gatewayIds;
@property(nonatomic,retain)NSMutableArray* deviceIds;
@property(nonatomic,retain)NSMutableArray* componentIds;
@property(nonatomic,assign)long startTimestamp;
@property(nonatomic,assign)long endTimestamp;
@property(nonatomic,retain)NSMutableArray* returnedMeasureAttributes;
@property(nonatomic,assign)BOOL showMeasureLocation;
@property(nonatomic,retain)AttributeFilterList* devCompAttributeFilter;
@property(nonatomic,retain)AttributeFilterList* measurementAttributeFilter;
@property(nonatomic,retain)AttributeFilter* valueFilter;
@property(nonatomic,assign)NSInteger componentRowLimit;
@property(nonatomic,assign)BOOL countOnly;
@property(nonatomic,retain)NSMutableDictionary* sort;

@end


@implementation AdvancedDataEnquiry

/***************************************************************************************************************************
 * FUNCTION NAME: initAdvancedDataEnquiryWithDefaults
 *
 * DESCRIPTION: Creates custom instance of the class AdvancedDataEnquiry
 *
 * RETURNS: instance of the class AdvancedDataEnquiry
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(id)initAdvancedDataEnquiryWithDefaults{
    self = [super init];
    if(self){
        _startTimestamp = 0L;
        _endTimestamp = 0L;
        _showMeasureLocation = false;
        _componentRowLimit = 0;
        _countOnly = false;
    }
    return self;
}
/***************************************************************************************************************************
 * FUNCTION NAME: setMessageType
 *
 * DESCRIPTION: sets message type for advanced data enquiry
 *
 * RETURNS: nothing
 *
 * PARAMETERS : msgType
 **************************************************************************************************************************/
-(void)setMessageType:(NSString*)msgType{
    _msgType = msgType;
}
/***************************************************************************************************************************
 * FUNCTION NAME: addGatewayIds
 *
 * DESCRIPTION: append gatewayId to list
 *
 * RETURNS: nothing
 *
 * PARAMETERS : gatewayId
 **************************************************************************************************************************/
-(void)addGatewayIds:(NSString*)gatewayId{
    if(!_gatewayIds){
        _gatewayIds = [NSMutableArray array];
    }
    [_gatewayIds addObject:gatewayId];
}
/***************************************************************************************************************************
 * FUNCTION NAME: addDeviceIds
 *
 * DESCRIPTION: append deviceId method to list
 *
 * RETURNS: nothing
 *
 * PARAMETERS : deviceId
 **************************************************************************************************************************/
-(void)addDeviceIds:(NSString*)deviceId{
    if(!_deviceIds){
        _deviceIds = [NSMutableArray array];
    }
    [_deviceIds addObject:deviceId];
}
/***************************************************************************************************************************
 * FUNCTION NAME: addComponentIds
 *
 * DESCRIPTION: append componentId method to list
 *
 * RETURNS: nothing
 *
 * PARAMETERS : componentId
 **************************************************************************************************************************/
-(void)addComponentIds:(NSString*)componentId{
    if(!_componentIds){
        _componentIds = [NSMutableArray array];
    }
    [_componentIds addObject:componentId];
}
/***************************************************************************************************************************
 * FUNCTION NAME: setStartTimestamp
 *
 * DESCRIPTION: set start time stamp
 *
 * RETURNS: nothing
 *
 * PARAMETERS : startTimestamp
 **************************************************************************************************************************/
-(void)setStartTimestamp:(long)startTimestamp{
    _startTimestamp = startTimestamp;
}
/***************************************************************************************************************************
 * FUNCTION NAME: setEndTimestamp
 *
 * DESCRIPTION: set end time stamp
 *
 * RETURNS: nothing
 *
 * PARAMETERS : endTimestamp
 **************************************************************************************************************************/
-(void)setEndTimestamp:(long)endTimestamp{
    _endTimestamp = endTimestamp;
}
/***************************************************************************************************************************
 * FUNCTION NAME: addReturnedMeasureAttributes
 *
 * DESCRIPTION: append measure attribute to list
 *
 * RETURNS: nothing
 *
 * PARAMETERS : attribute
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
 *
 * RETURNS: nothing
 *
 * PARAMETERS : measureLocation(true/false)
 **************************************************************************************************************************/
-(void)setShowMeasureLocation:(BOOL)measureLocation{
    _showMeasureLocation = measureLocation;
}
/***************************************************************************************************************************
 * FUNCTION NAME: addDevCompAttributeFilter
 *
 * DESCRIPTION: append dev comp attribute filter to list
 *
 * RETURNS: nothing
 *
 * PARAMETERS :  attributeFilter
 **************************************************************************************************************************/
-(void)addDevCompAttributeFilter:(AttributeFilter*)attributeFilter{
    if(!_devCompAttributeFilter){
        _devCompAttributeFilter = [[AttributeFilterList alloc] init];
        _devCompAttributeFilter.filterData = [NSMutableArray array];
    }
    [_devCompAttributeFilter.filterData addObject:attributeFilter];
}
/***************************************************************************************************************************
 * FUNCTION NAME: addMeasurementAttributeFilter
 *
 * DESCRIPTION: append measurement attribute filter to list
 *
 * RETURNS: nothing
 *
 * PARAMETERS : attributeFilter
 **************************************************************************************************************************/
-(void)addMeasurementAttributeFilter:(AttributeFilter*)attributeFilter{
    if(!_measurementAttributeFilter){
        _measurementAttributeFilter = [[AttributeFilterList alloc] init];
        _measurementAttributeFilter.filterData = [NSMutableArray array];
    }
    [_measurementAttributeFilter.filterData addObject:attributeFilter];
}
/***************************************************************************************************************************
 * FUNCTION NAME: addValueFilter
 *
 * DESCRIPTION: append avalue filter to list
 *
 * RETURNS: nothing
 *
 * PARAMETERS : attributeFilter
 **************************************************************************************************************************/
-(void)addValueFilter:(AttributeFilter*)attributeFilter{
    _valueFilter = attributeFilter;
}
/***************************************************************************************************************************
 * FUNCTION NAME: setComponentRowLimit
 *
 * DESCRIPTION: set component row limit for return results
 *
 * RETURNS: nothing
 *
 * PARAMETERS : componentRowLimit
 **************************************************************************************************************************/
-(void)setComponentRowLimit:(NSInteger)componentRowLimit{
    _componentRowLimit = componentRowLimit;
}
/***************************************************************************************************************************
 * FUNCTION NAME: setCountOnly
 *
 * DESCRIPTION: set count true to get only count from server else false
 *
 * RETURNS: nothing
 *
 * PARAMETERS : true/false
 **************************************************************************************************************************/
-(void)setCountOnly:(BOOL)countOnly{
    _countOnly = countOnly;
}
/***************************************************************************************************************************
 * FUNCTION NAME: addSortInfo
 *
 * DESCRIPTION: append sor key-value pair to list
 *
 * RETURNS: nothing
 *
 * PARAMETERS : sort name & value
 **************************************************************************************************************************/
-(void)addSortInfo:(NSString*)name WithValue:(NSString*)value{
    if(!_sort){
        _sort = [NSMutableDictionary dictionary];
    }
    [_sort setObject:value forKey:name];
}

/***************************************************************************************************************************
 * FUNCTION NAME: advancedDataEnquiry
 *
 * DESCRIPTION: enquire advanced data using different filters
 *
 * RETURNS: true/false
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(BOOL)advancedDataEnquiry{
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
    [dataInquiryJson setObject:[NSNumber numberWithLong:_startTimestamp] forKey:@"from"];
    [dataInquiryJson setObject:[NSNumber numberWithLong:_endTimestamp] forKey:@"to"];
    
    
    //returnedMeasureAttributes
    if (_returnedMeasureAttributes) {
        NSMutableArray *returnedMeasureAttributesArray = [NSMutableArray array];
        for (NSString *attribute in _returnedMeasureAttributes) {
            [returnedMeasureAttributesArray addObject:attribute];
        }
        [dataInquiryJson setObject:returnedMeasureAttributesArray forKey:@"returnedMeasureAttributes"];
    }
    
    if (_showMeasureLocation) {
        [dataInquiryJson setObject:[NSNumber numberWithBool:_showMeasureLocation] forKey:@"showMeasureLocation"];
    }
    if (_componentRowLimit > 0) {
        [dataInquiryJson setObject:[NSNumber numberWithInteger:_componentRowLimit] forKey:@"componentRowLimit"];
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
    if (_countOnly) {
        [dataInquiryJson setObject:[NSNumber numberWithBool:_countOnly] forKey:@"countOnly"];
    }
    if (_devCompAttributeFilter) {
        NSMutableDictionary *devCompAttributeJson = [NSMutableDictionary dictionary];
        for(AttributeFilter *attributeFilter in _devCompAttributeFilter.filterData){
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
        for(AttributeFilter *attributeFilter in _measurementAttributeFilter.filterData){
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


