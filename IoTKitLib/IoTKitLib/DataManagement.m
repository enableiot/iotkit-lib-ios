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
#import "DataManagement.h"
#import "HttpRequestOperation.h"
#import "HttpResponseMacros.h"
#define TAG @"DataManagement"
#define DATA @"data"
#define VALUE @"value"
#define CID @"componentId"
#define LOCATION @"loc"
#define FROMTIME @"from"
#define TOTIME @"to"
#define TARGETFILTER @"targetFilter"
#define METRICS @"metrics"
#define DEVICELIST @"deviceList"
#define OP @"op"
#define NONE @"none"

@interface ConfigureRetrieveData ()

@property(nonatomic,retain)NSMutableArray *deviceList;
@property(nonatomic,retain)NSMutableArray *componentIdList;
@property(nonatomic,assign)double fromTime;
@property(nonatomic,assign)double toTime;

@end

@implementation ConfigureRetrieveData
/***************************************************************************************************************************
 * FUNCTION NAME: initConfigureRetrieveData
 *
 * DESCRIPTION: Creates custom instance of the class ConfigureRetrieveData
 *
 * RETURNS: instance of the class ConfigureRetrieveData
 *
 * PARAMETERS : 1)fromTime
                2)toTime
 **************************************************************************************************************************/
-(id)initConfigureRetrieveData:(double)fromTime ToTimeInMillis:(double)toTime{
    self = [super init];
    if(self){
        _fromTime = fromTime;
        _toTime = toTime;
    }
    return self;
}
/***************************************************************************************************************************
 * FUNCTION NAME: addDeviceId
 *
 * DESCRIPTION: append device Id's to list of deviceId's
 *
 * RETURNS: nothing
 *
 * PARAMETERS : deviceId 
 **************************************************************************************************************************/
-(void) addDeviceId:(NSString*) deviceId {
    if (!_deviceList) {
        _deviceList = [NSMutableArray array];
    }
    [_deviceList addObject:deviceId];
}
/***************************************************************************************************************************
 * FUNCTION NAME: addComponentId
 *
 * DESCRIPTION: append component Id's to list of Id's
 *
 * RETURNS: nothing
 *
 * PARAMETERS : componentId 
 **************************************************************************************************************************/
-(void) addComponentId:(NSString*) componentId {
    if (!_componentIdList) {
        _componentIdList = [NSMutableArray array];
    }
    [_componentIdList addObject:componentId];
}

@end

//#######DataManagement###########
@implementation DataManagement

/***************************************************************************************************************************
 * FUNCTION NAME: submitDataOn
 *
 * DESCRIPTION: requests to submit data using componentName&value, lat&long, height &attributes
 *
 * RETURNS: true/false
 *
 * PARAMETERS : 1)componentName
                2)componentValue
                3)latitude
                4)longitude
                5)height
                6)attributes
 
**************************************************************************************************************************/
-(CloudResponse *) submitDataOn:(NSString*) componentName AndValue:(NSString*) componentValue
         AndLatitide:(double) latitude AndLongitude:(double) longitude AndHeight:(double) height
       AndAttributes:(NSDictionary*)attributes{
    NSString *componentId = [self validateRequestBodyParametersAndGetcomponentIdOn:componentName AndValue:componentValue];
    if(!componentId){
        return [CloudResponse createCloudResponseWithStatus:false andMessage:[NSString stringWithFormat:@"%@:Cannot submit data for device component",TAG]];
    }
    NSData *data = [self createHttpBodyForDataSubmissionOn:componentId AndValue: componentValue
                                               AndLatitide:latitude AndLongitude:longitude AndHeight:height
                                             AndAttributes:attributes];
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.submitData urlSlugValueList:nil];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:SUBMITDATA
                                                                     AndRequestBody:data
                                                                  AndHttpMethodType:HTTPPOST
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:nil
                                                                        DeviceToken:self.getStoredDeviceToken];
    return [self initiateHttpOperation:httpOperation];
}

/***************************************************************************************************************************
 * FUNCTION NAME: retrieveDataOn
 *
 * DESCRIPTION: requests to retrieve data
 *
 * RETURNS: true/false
 *
 * PARAMETERS : retrieve object data
 **************************************************************************************************************************/
-(CloudResponse *)retrieveDataOn:(ConfigureRetrieveData *)objRetrieveData{
    NSString *msg = [self validateRetrieveDataValues:objRetrieveData];
    if (msg) {
        return [CloudResponse createCloudResponseWithStatus:false andMessage:msg];
    }
    NSData *data = [self createHttpBodyToRetrieveData:objRetrieveData];
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.retrieveData urlSlugValueList:nil];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:RETRIEVEDATA
                                                                     AndRequestBody:data
                                                                  AndHttpMethodType:HTTPPOST
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];

}
/***************************************************************************************************************************
 * FUNCTION NAME: createHttpBodyToRetrieveData
 *
 * DESCRIPTION: method to create http Body to retrieve data
 *
 * RETURNS: data stream of request body
 *
 * PARAMETERS : retrieve data object
 **************************************************************************************************************************/
-(NSData*) createHttpBodyToRetrieveData:(ConfigureRetrieveData *)objRetrieveData{
    
    NSMutableDictionary *retrieveJson = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:objRetrieveData.fromTime] ,FROMTIME,[NSNumber numberWithDouble:objRetrieveData.toTime],TOTIME,nil];
    
    NSDictionary *targetFilter = [NSDictionary dictionaryWithObjectsAndKeys:objRetrieveData.deviceList,DEVICELIST, nil];
    [retrieveJson setObject:targetFilter forKey:TARGETFILTER];
    
    NSMutableArray *metricsArray = [NSMutableArray array];
    for(NSString *componentId in objRetrieveData.componentIdList){
        [metricsArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:componentId,ID,NONE,OP,nil]];
    }
    [retrieveJson setObject:metricsArray forKey:METRICS];
    NSError *error;
    return [NSJSONSerialization dataWithJSONObject:retrieveJson options:NSJSONWritingPrettyPrinted error:&error];
}
/***************************************************************************************************************************
 * FUNCTION NAME: createHttpBodyForDataSubmissionOn
 *
 * DESCRIPTION: method to create http Body to submit data
 *
 * RETURNS: data stream of request body
 *
 * PARAMETERS : 1)componentName
                2)componentValue
                3)latitude
                4)longitude
                5)height
                6)attributes
 **************************************************************************************************************************/
-(NSData*) createHttpBodyForDataSubmissionOn:(NSString*)componentId AndValue:(NSString*) componentValue
                                 AndLatitide:(double) latitude AndLongitude:(double) longitude
                                   AndHeight:(double) height AndAttributes:(NSDictionary*)attributes {
    NSMutableDictionary *submitDataDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:self.getCurrentTimeInMillis],CURRENTTIME,self.getAccountId,ACCOUNTID,nil];
    
    NSMutableDictionary *dataRecord = [NSMutableDictionary dictionaryWithObjectsAndKeys:componentId,CID,[NSNumber numberWithDouble:self.getCurrentTimeInMillis],CURRENTTIME,componentValue,VALUE,nil];
    if(latitude && longitude){
        NSMutableArray *locationArray = [NSMutableArray arrayWithObjects:[NSNumber numberWithDouble:latitude],[NSNumber numberWithDouble:longitude],nil];
        if(height){
            [locationArray addObject:[NSNumber numberWithDouble:height]];
        }
        [dataRecord setObject:locationArray forKey:LOCATION];
    }
    if(attributes && [attributes count]){
        [dataRecord setObject:attributes forKey:ATTRIBUTES];
    }
    
    [submitDataDictionary setObject:[NSArray arrayWithObject:dataRecord] forKey:DATA];
    NSError *error;
    return [NSJSONSerialization dataWithJSONObject:submitDataDictionary options:NSJSONWritingPrettyPrinted error:&error];
}

/***************************************************************************************************************************
 * FUNCTION NAME: validateRequestBodyParametersAndGetcomponentIdOn
 *
 * DESCRIPTION: validates component id & value , gets component id from defaults using componentName
 *
 * RETURNS: true/false
 *
 * PARAMETERS : 1)component Name
                2)component value
 **************************************************************************************************************************/
-(NSString*)validateRequestBodyParametersAndGetcomponentIdOn:(NSString*) componentName
                                                    AndValue:(NSString*) componentValue{
    if (!componentName) {
        NSLog(@"%@:submitData::Component Name cannot be NULL",TAG);
        return nil;
    }
    if (!componentValue) {
        NSLog(@"%@:submitData::Value cannot be NULL",TAG);
        return nil;
    }
    if (![self getAccountId] || ![self getDeviceId]){
        NSLog(@"%@:account Id  or device ID must not be Null, No Device exists to submit component data",TAG);
        return nil;
    }
    return [self getComponentId:componentName];
}
/***************************************************************************************************************************
 * FUNCTION NAME: validateRetrieveDataValues
 *
 * DESCRIPTION: validates device & componentId list
 *
 * RETURNS: true/false
 *
 * PARAMETERS : retrieve object data
 **************************************************************************************************************************/
-(NSString *)validateRetrieveDataValues:(ConfigureRetrieveData *)objRetrieveData{
    if(!objRetrieveData.deviceList || !objRetrieveData.componentIdList){
        return [NSString stringWithFormat:@"%@:devices or components not yet configured!!",TAG];
    }
    return nil;
}
@end
