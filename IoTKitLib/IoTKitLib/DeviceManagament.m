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

#import "DeviceManagament.h"
#import "HttpResponseMacros.h"
#import "HttpRequestOperation.h"
#define TAG @"DeviceManagament"
#define GATEWAYID @"gatewayId"
//#define DEVICENAME @"name"
#define DEVICETAGS @"tags"
#define DEVICEATTRIBUTES @"attributes"
#define DEVICELOCATION @"loc"
#define ACTIVATIONCODE @"activationCode"

//#####Device########

@interface Device ()

@property(nonatomic,retain) NSString *deviceName;
@property(nonatomic,retain) NSString *deviceId;
@property(nonatomic,retain) NSString *gatewayId;
@property(nonatomic,retain) NSArray *location;
@property(nonatomic,retain) NSMutableArray *listOfTags;
@property(nonatomic,retain) NSMutableDictionary *listOfAttributes;

@end

@implementation Device
/***************************************************************************************************************************
 * FUNCTION NAME: createDeviceWithDeviceName
 *
 * DESCRIPTION: Creates custom instance of the class Device
 *
 * RETURNS: instance of the class Device
 *
 * PARAMETERS : 1)deviceName
                2)deviceId
                3)gatewayId
 **************************************************************************************************************************/
+(id)createDeviceWithDeviceName:(NSString*)deviceName andDeviceId:(NSString*) deviceId andGatewayId:(NSString*) gatewayId
{
    Device *deviceObj = [[Device alloc] initDevice];
    deviceObj.deviceName = deviceName;
    deviceObj.deviceId = deviceId;
    deviceObj.gatewayId = gatewayId;
    return deviceObj;
}
/***************************************************************************************************************************
 * FUNCTION NAME: initDevice
 *
 * DESCRIPTION: Creates instance of the class Device
 *
 * RETURNS: instance of the class Device
 *
 * PARAMETERS :nil
 **************************************************************************************************************************/
-(id)initDevice{
    self = [super init];
    if(!self){
        
    }
    return self;
}
/***************************************************************************************************************************
 * FUNCTION NAME: addLocationInfo
 *
 * DESCRIPTION: adds location info of device using lat,long&height
 *
 * RETURNS: nothing
 *
 * PARAMETERS : 1)latitude
                2)longitude
                3)height
 **************************************************************************************************************************/
-(void)addLocationInfo:(double)latitude AndLongitude:(double) longitude ANdHeight:(double) height{
    _location = [[NSArray alloc] initWithObjects:[NSNumber numberWithDouble:latitude],[NSNumber numberWithDouble:longitude],[NSNumber numberWithDouble:height],nil];
}
/***************************************************************************************************************************
 * FUNCTION NAME: addTagName
 *
 * DESCRIPTION: adds tag name to list of tags
 *
 * RETURNS: nothing
 *
 * PARAMETERS : tag name
 **************************************************************************************************************************/
-(void)addTagName:(NSString*)tagName {
    if(!_listOfTags){
        _listOfTags = [[NSMutableArray alloc] init];
    }
    [_listOfTags addObject:tagName];
}
/***************************************************************************************************************************
 * FUNCTION NAME: addAttributeName
 *
 * DESCRIPTION: adds attribute name-value pair to attribute list
 *
 * RETURNS: nothing
 *
 * PARAMETERS : 1)attribute name
                2)attribute value
 **************************************************************************************************************************/
-(void)addAttributeName:(NSString*)attributeName  andValue:(NSString*)attributeValue {
    if(!_listOfAttributes){
        _listOfAttributes = [[NSMutableDictionary alloc] init];
    }
    [_listOfAttributes setObject:attributeValue  forKey:attributeName];
}

@end


//#####Device Management########


@interface DeviceManagament()

@property(nonatomic,retain) NSString *deviceName;
@property(nonatomic,retain) NSString *deviceId;
@property(nonatomic,retain) NSString *gatewayId;
@property(nonatomic,retain) NSArray *location;
@property(nonatomic,retain) NSMutableArray *listOfTags;
@property(nonatomic,retain) NSMutableDictionary *listOfAttributes;

@end

@implementation DeviceManagament

/***************************************************************************************************************************
 * FUNCTION NAME: getDeviceList
 *
 * DESCRIPTION: requests to list all devices
 *
 * RETURNS: true/false
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(CloudResponse *) getDeviceList{
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.listDevices urlSlugValueList:nil];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:LISTDEVICES
                                                                     AndRequestBody:nil
                                                                  AndHttpMethodType:HTTPGET
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: createNewDevice
 *
 * DESCRIPTION: requests to create new device
 *
 * RETURNS: true/false
 *
 * PARAMETERS : deviceCreationObj object
 **************************************************************************************************************************/
-(CloudResponse *) createNewDevice:(Device*) deviceCreationObj{
    if(!deviceCreationObj){
        NSLog(@"%@:Need to Initialize Device class",TAG);
        return false;
    }
    NSData *httpBody = [self createBodyForDeviceCreation:deviceCreationObj];
    NSLog(@"DEVICE CREATION JSON STRING:%@",[[NSString alloc] initWithData:httpBody encoding:NSUTF8StringEncoding]);
    if(!httpBody){
        return false;
    }
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.createDevice urlSlugValueList:nil];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:CREATEDEVICE
                                                                     AndRequestBody:httpBody
                                                                  AndHttpMethodType:HTTPPOST
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: getMyDeviceInfo
 *
 * DESCRIPTION: requests to my device info
 *
 * RETURNS: true/false
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(CloudResponse *) getMyDeviceInfo{
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.getMyDeviceInfo urlSlugValueList:nil];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:GETMYDEVICEINFO
                                                                     AndRequestBody:nil
                                                                  AndHttpMethodType:HTTPGET
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: getInfoOnDevice
 *
 * DESCRIPTION: requests to get device info with given Id
 *
 * RETURNS: true/false
 *
 * PARAMETERS : deviceID
 **************************************************************************************************************************/
-(CloudResponse *) getInfoOnDevice:(NSString*)deviceId{
    if(!deviceId){
        NSLog(@"%@:provided deviceId is nil",TAG);
        return false;
    }
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.getOneDeviceInfo urlSlugValueList:[NSDictionary dictionaryWithObject:deviceId forKey:CONFIGOTHERDEVICEID]];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:GETONEDEVICEINFO
                                                                     AndRequestBody:nil
                                                                  AndHttpMethodType:HTTPGET
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: getAllTags
 *
 * DESCRIPTION: requests to list device tags
 *
 * RETURNS: true/false
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(CloudResponse *) getAllTags{
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.listAllTags urlSlugValueList:nil];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:LISTALLTAGS
                                                                     AndRequestBody:nil
                                                                  AndHttpMethodType:HTTPGET
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: getAllAttributes
 *
 * DESCRIPTION: requests to list device attributes
 *
 * RETURNS: true/false
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(CloudResponse *) getAllAttributes{
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.listAllAttributes urlSlugValueList:nil];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:LISTALLATTRIBUTES
                                                                     AndRequestBody:nil
                                                                  AndHttpMethodType:HTTPGET
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: updateADevice
 *
 * DESCRIPTION: requests to update device
 *
 * RETURNS: true/false
 *
 * PARAMETERS : update device object
 **************************************************************************************************************************/
-(CloudResponse *) updateADevice:(Device*)deviceUpdationObj{
    if(!deviceUpdationObj){
        NSLog(@"%@:Need to Initialize Device class",TAG);
        return false;
    }
    NSData *httpBody = [self createBodyForDeviceUpdation:deviceUpdationObj];
    if(!httpBody){
        return false;
    }
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.updateDevice urlSlugValueList:nil];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:UPDATEDEVICE
                                                                     AndRequestBody:httpBody
                                                                  AndHttpMethodType:HTTPPUT
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: activateADevice
 *
 * DESCRIPTION: requests to activate device
 *
 * RETURNS: true/false
 *
 * PARAMETERS : activation code
 **************************************************************************************************************************/
-(CloudResponse *) activateADevice:(NSString*)activationCode{
    if(!activationCode){
        NSLog(@"%@:Need activationCode to activate device",TAG);
        return false;
    }
    NSData *httpBody = [self createBodyForDeviceActivation:activationCode];
    if(!httpBody){
        return false;
    }
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.activateDevice urlSlugValueList:nil];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:ACTIVATEDEVICE
                                                                     AndRequestBody:httpBody
                                                                  AndHttpMethodType:HTTPPUT
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: addComponentToDevice
 *
 * DESCRIPTION: requests to add component to device with component name & type
 *
 * RETURNS: true/false
 *
 * PARAMETERS : 1)componentName
                2)componentType
 **************************************************************************************************************************/
-(CloudResponse *) addComponentToDevice:(NSString*)componentName WithType:(NSString*)componentType{
    if(!componentName || !componentType){
        NSLog(@"%@:Need componentName and componentType",TAG);
        return false;
    }
    NSData *httpBody = [self createBodyForDeviceComponent:componentName WithType:componentType];
    if(!httpBody){
        return false;
    }
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.addComponent urlSlugValueList:nil];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:ADDCOMPONENT
                                                                     AndRequestBody:httpBody
                                                                  AndHttpMethodType:HTTPPOST
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredDeviceToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];

}
/***************************************************************************************************************************
 * FUNCTION NAME: deleteAComponent
 *
 * DESCRIPTION: requests to delete component
 *
 * RETURNS: true/false
 *
 * PARAMETERS : componentName
 **************************************************************************************************************************/
-(CloudResponse *)deleteAComponent:(NSString*)componentName{
    if(!componentName){
        NSLog(@"%@:Need componentName to delete",TAG);
        return false;
    }
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.deleteComponent urlSlugValueList:[NSDictionary dictionaryWithObject:componentName forKey:NAME]];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:DELETECOMPONENT
                                                                     AndRequestBody:nil
                                                                  AndHttpMethodType:HTTPDELETE
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: deleteADevice
 *
 * DESCRIPTION: requests to delete device
 *
 * RETURNS: true/false
 *
 * PARAMETERS : deviceId
 **************************************************************************************************************************/
-(CloudResponse *)deleteADevice:(NSString*)deviceId{
    if(!deviceId){
        NSLog(@"%@:Need deviceId to delete",TAG);
        return false;
    }
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.deleteDevice urlSlugValueList:[NSDictionary dictionaryWithObject:deviceId forKey:CONFIGOTHERDEVICEID]];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:DELETEDEVICE
                                                                     AndRequestBody:nil
                                                                  AndHttpMethodType:HTTPDELETE
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: createBodyForDeviceComponent
 *
 * DESCRIPTION: method to create http Body to add component to device
 *
 * RETURNS: data stream of request body
 *
 * PARAMETERS : 1)component name
                2)component Type
 **************************************************************************************************************************/
-(NSData*) createBodyForDeviceComponent:(NSString*)componentName WithType:(NSString*)componentType{
    NSError *error;
    return [NSJSONSerialization dataWithJSONObject:[NSDictionary dictionaryWithObjectsAndKeys:[[NSUUID UUID] UUIDString],COMPONENTID,componentName,NAME,componentType,COMPONENTTYPE, nil] options:NSJSONWritingPrettyPrinted error:&error];
}
/***************************************************************************************************************************
 * FUNCTION NAME: createBodyForDeviceActivation
 *
 * DESCRIPTION: method to create http Body to activate device
 *
 * RETURNS: data stream of request body
 *
 * PARAMETERS : activation code **************************************************************************************************************************/
-(NSData*) createBodyForDeviceActivation:(NSString*)activationCode{
    NSError *error;
    return [NSJSONSerialization dataWithJSONObject:[NSDictionary dictionaryWithObject:activationCode forKey:ACTIVATIONCODE] options:NSJSONWritingPrettyPrinted error:&error];
}
/***************************************************************************************************************************
 * FUNCTION NAME: createBodyForDeviceUpdation
 *
 * DESCRIPTION: method to create http Body to update device
 *
 * RETURNS: data stream of request body
 *
 * PARAMETERS : Device object
 **************************************************************************************************************************/
-(NSData*) createBodyForDeviceUpdation:(Device*)deviceUpdationObj{
    
    NSMutableDictionary *jsonDictionary = [[NSMutableDictionary alloc] init];
    
    jsonDictionary = [self createOrUpdateDeviceBodyWith:jsonDictionary OnDevice:deviceUpdationObj];
    NSError *error;
    
    return [NSJSONSerialization dataWithJSONObject:jsonDictionary options:NSJSONWritingPrettyPrinted error:&error];
    
    
}
/***************************************************************************************************************************
 * FUNCTION NAME: createBodyForDeviceCreation
 *
 * DESCRIPTION: method to create http Body to create device
 *
 * RETURNS: data stream of request body
 *
 * PARAMETERS : Device object
 **************************************************************************************************************************/
-(NSData*) createBodyForDeviceCreation:(Device*)deviceCreationObj{
    if(!deviceCreationObj.deviceId){
        NSLog(@"%@:deviceId cannot be nil",TAG);
        return nil;
    }
    NSMutableDictionary *jsonDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:deviceCreationObj.deviceId,DEVICEID,nil];
    
    jsonDictionary = [self createOrUpdateDeviceBodyWith:jsonDictionary OnDevice:deviceCreationObj];
    
    NSError *error;
    
    return [NSJSONSerialization dataWithJSONObject:jsonDictionary options:NSJSONWritingPrettyPrinted error:&error];
    
}
/***************************************************************************************************************************
 * FUNCTION NAME: createOrUpdateDeviceBodyWith
 *
 * DESCRIPTION: method to create/update http Body to create/update device
 *
 * RETURNS: data stream of request body
 *
 * PARAMETERS : 1)jsonDictionary
                2)Device object
 **************************************************************************************************************************/
-(NSMutableDictionary*)createOrUpdateDeviceBodyWith:(NSMutableDictionary*)jsonDictionary OnDevice:(Device*)createOrUpdateDeviceObj{
    if(!createOrUpdateDeviceObj.gatewayId || !createOrUpdateDeviceObj.deviceName){
        NSLog(@"%@:gatewayId or deviceName cannot be nil",TAG);
        return nil;
    }
    [jsonDictionary setObject:createOrUpdateDeviceObj.gatewayId forKey:GATEWAYID];
    [jsonDictionary setObject:createOrUpdateDeviceObj.deviceName forKey:NAME];
    
    if(createOrUpdateDeviceObj.location){
        [jsonDictionary setObject:createOrUpdateDeviceObj.location forKey:DEVICELOCATION];
    }
    if(createOrUpdateDeviceObj.listOfTags){
        [jsonDictionary setObject:createOrUpdateDeviceObj.listOfTags forKey:DEVICETAGS];
    }
    if(createOrUpdateDeviceObj.listOfAttributes){
        [jsonDictionary setObject:createOrUpdateDeviceObj.listOfAttributes forKey:DEVICEATTRIBUTES];
    }
    return jsonDictionary;
}
@end

