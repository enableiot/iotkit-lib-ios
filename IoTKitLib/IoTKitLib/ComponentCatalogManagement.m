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
#import "ComponentCatalogManagement.h"
#import "HttpRequestOperation.h"
#import "HttpResponseMacros.h"


#define TAG @"ComponentTypesCatalog"
#define DIMENSION @"dimension"
#define VERSION @"version"
#define TYPE @"type"
#define DATATYPE @"dataType"
#define FORMAT @"format"
#define MEASUREUNIT @"measureunit"
#define DISPLAY @"display"
#define MINIMUM @"min"
#define MAXIMUM @"max"
#define COMMANDSTRING @"commandString"
#define VALUES @"values"
#define PARAMETERS @"parameters"
#define COMMAND @"command"
#define ACTUATOR @"actuator"

//#####ComponentCatalog#########
@interface ComponentCatalog ()

@property(nonatomic,retain)NSString *componentName;
@property(nonatomic,retain)NSString *componentVersion;
@property(nonatomic,retain)NSString *componentType;
@property(nonatomic,retain)NSString *componentDataType;
@property(nonatomic,retain)NSString *componentFormat;
@property(nonatomic,retain)NSString *componentDisplay;
@property(nonatomic,retain)NSString *componentUnit;
@property(nonatomic,retain)NSString *commandString;
@property(nonatomic,retain)NSMutableDictionary *actuatorCommandParams;
@property(nonatomic,assign)double minValue;
@property(nonatomic,assign)double maxValue;
@property(nonatomic,assign)BOOL isMinSet;
@property(nonatomic,assign)BOOL isMaxSet;

@end

@implementation ComponentCatalog
/***************************************************************************************************************************
 * FUNCTION NAME: ComponentCatalogWith
 *
 * DESCRIPTION: Creates custom instance of the class ComponentCatalog
 *
 * RETURNS: instance of the class ComponentCatalog
 *
 * PARAMETERS : 1)componentName
                2)componentVersion
                3)componentType
                4)componentDataType
                5)componentFormat
                6)componentUnit
                7)componentDisplay
 **************************************************************************************************************************/
+(id) ComponentCatalogWith:(NSString*) componentName AndVersion: (NSString*) componentVersion
                                 AndType:(NSString*) componentType AndDataType:(NSString*) componentDataType
                               AndFormat:(NSString*) componentFormat AndUnit:(NSString*) componentUnit
                              AndDisplay:(NSString*) componentDisplay {
    ComponentCatalog *customComponent = [[ComponentCatalog alloc] initCustomComponent];
    customComponent.componentName = componentName;
    customComponent.componentVersion = componentVersion;
    customComponent.componentType = componentType;
    customComponent.componentDataType = componentDataType;
    customComponent.componentFormat = componentFormat;
    customComponent.componentUnit = componentUnit;
    customComponent.componentDisplay = componentDisplay;
    customComponent.isMinSet = false;
    customComponent.isMaxSet = false;
    customComponent.minValue = 0.0;
    customComponent.maxValue = 0.0;
    return customComponent;
}
/***************************************************************************************************************************
 * FUNCTION NAME: initCustomComponent
 *
 * DESCRIPTION: Creates instance of the class ComponentCatalog
 *
 * RETURNS: instance of the class ComponentCatalog
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(id)initCustomComponent{
    self = [super init];
    if(!self){
        
    }
    return self;
}
/***************************************************************************************************************************
 * FUNCTION NAME: setMinValue
 *
 * DESCRIPTION: sets minimum Name
 *
 * RETURNS: nothing
 *
 * PARAMETERS : min Value
 **************************************************************************************************************************/
-(void) setMinValue:(double) minValue {
    _isMinSet = true;
    _minValue = minValue;
}
/***************************************************************************************************************************
 * FUNCTION NAME: setMaxValue
 *
 * DESCRIPTION: sets maximum Name
 *
 * RETURNS: nothing
 *
 * PARAMETERS : max value
 **************************************************************************************************************************/
-(void) setMaxValue:(double) maxValue {
    _isMaxSet = true;
    _maxValue = maxValue;
}
/***************************************************************************************************************************
 * FUNCTION NAME: setCommandString
 *
 * DESCRIPTION: sets command string Name
 *
 * RETURNS: nothing
 *
 * PARAMETERS : command string
 **************************************************************************************************************************/
-(void) setCommandString:(NSString*) commandString {
    _commandString = commandString;
}
/***************************************************************************************************************************
 * FUNCTION NAME: addCommandParameters
 *
 * DESCRIPTION: adds command name-value pair to command params list
 *
 * RETURNS: nothing
 *
 * PARAMETERS : 1)command name
                2)command value
 **************************************************************************************************************************/
-(void) addCommandParameters:(NSString*) commandName AndValue:(NSString*) commandValue {
    if (!_actuatorCommandParams) {
        _actuatorCommandParams = [NSMutableDictionary dictionary];
    }
    [_actuatorCommandParams setObject:commandValue forKey:commandName];
}


@end

//#####ComponentCatalogManagement#########
@implementation ComponentCatalogManagement

/***************************************************************************************************************************
 * FUNCTION NAME: listAllComponentTypesCatalog
 *
 * DESCRIPTION: requests to get list of components
 *
 * RETURNS: true/false
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(CloudResponse *)listAllComponentTypesCatalog{
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.listAllComponentTypesCatalog urlSlugValueList:nil];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:LISTALLCOMPONENTTYPESCATALOG
                                                                     AndRequestBody:nil
                                                                  AndHttpMethodType:HTTPGET
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: listAllDetailsOfComponentTypesCatalog
 *
 * DESCRIPTION: requests to get list of components detailed
 *
 * RETURNS: true/false
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(CloudResponse *)listAllDetailsOfComponentTypesCatalog{
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.listAllComponentTypesCatalogDetailed urlSlugValueList:nil];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:LISTALLCOMPONENTTYPESCATALOGDETAILED
                                                                     AndRequestBody:nil
                                                                  AndHttpMethodType:HTTPGET
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: listComponentTypeDetails
 *
 * DESCRIPTION: requests to list single Component Details
 *
 * RETURNS: true/false
 *
 * PARAMETERS : componentId
 **************************************************************************************************************************/
-(CloudResponse *)listComponentTypeDetails:(NSString *)componentId{
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.componentTypeCatalogDetails urlSlugValueList:[NSDictionary dictionaryWithObject:componentId forKey:COMPONENTCATALOGID]];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:COMPONENTTYPECATALOGDETAILS
                                                                     AndRequestBody:nil
                                                                  AndHttpMethodType:HTTPGET
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: createCustomComponent
 *
 * DESCRIPTION: requests to create custom component
 *
 * RETURNS: true/false
 *
 * PARAMETERS : ComponentCatalog object
 **************************************************************************************************************************/
-(CloudResponse *)createCustomComponent:(ComponentCatalog *)createComponentCatalog{
    if(!createComponentCatalog){
        NSLog(@"%@:ComponentCatalog need to be initialized & configured to create component",TAG);
        return false;
    }
    if(![self validateActuatorCommand:createComponentCatalog]){
        return false;
    }
    NSData *data = [self createBodyForCreationOfCustomComponent:createComponentCatalog];
    if(!data){
        return false;
    }
    
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.createCustomComponent urlSlugValueList:nil];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:CREATECUSTOMCOMPONENT
                                                                     AndRequestBody:data
                                                                  AndHttpMethodType:HTTPPOST
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
    
}
/***************************************************************************************************************************
 * FUNCTION NAME: updateAComponent
 *
 * DESCRIPTION: requests to update component using component ID
 *
 * RETURNS: true/false
 *
 * PARAMETERS : 1)ComponentCatalog object
                2)componentId
 **************************************************************************************************************************/
-(CloudResponse *)updateAComponent:(ComponentCatalog *)updateComponentCatalog
            OnComponent:(NSString *)componentId{
    if(!updateComponentCatalog){
        NSLog(@"%@:ComponentCatalog need to be initialized & configured to update component",TAG);
        return false;
    }
    if(![self validateActuatorCommand:updateComponentCatalog]){
        return false;
    }
    NSData *data = [self createBodyForUpdationOfCustomComponent:updateComponentCatalog];
    if(!data){
        return false;
    }
    
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.updateComponent urlSlugValueList:[NSDictionary dictionaryWithObject:componentId forKey:COMPONENTCATALOGID]];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:UPDATECOMPONENT
                                                                     AndRequestBody:data
                                                                  AndHttpMethodType:HTTPPUT
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
    
}
/***************************************************************************************************************************
 * FUNCTION NAME: createBodyForUpdationOfCustomComponent
 *
 * DESCRIPTION: method to create http Body to update component
 *
 * RETURNS: data stream of request body
 *
 * PARAMETERS : ComponentCatalog object
 **************************************************************************************************************************/
-(NSData*) createBodyForUpdationOfCustomComponent:(ComponentCatalog *)updateComponentCatalog{
    NSMutableDictionary *componentDictionary = [NSMutableDictionary dictionary];
    if (updateComponentCatalog.componentType != nil) {
        [componentDictionary setObject:updateComponentCatalog.componentType forKey:TYPE];
    }
    if (updateComponentCatalog.componentDataType != nil) {
        [componentDictionary setObject:updateComponentCatalog.componentDataType forKey:DATATYPE];
    }
    if (updateComponentCatalog.componentFormat != nil) {
        [componentDictionary setObject:updateComponentCatalog.componentFormat forKey:FORMAT];
    }
    if (updateComponentCatalog.componentUnit != nil) {
        [componentDictionary setObject:updateComponentCatalog.componentUnit forKey:MEASUREUNIT];
    }
    if (updateComponentCatalog.componentDisplay != nil) {
        [componentDictionary setObject:updateComponentCatalog.componentDisplay forKey:DISPLAY];
    }
    //add min,max values if exist
    componentDictionary = [self addMinMaxValuesToHttpBody:updateComponentCatalog ToDictionary:componentDictionary];
    componentDictionary = [self addActuatorCommandParametersToHttpBody:updateComponentCatalog
                                                          ToDictionary:componentDictionary];
    NSError *error;
    return [NSJSONSerialization dataWithJSONObject:componentDictionary options:NSJSONWritingPrettyPrinted error:&error];
}
/***************************************************************************************************************************
 * FUNCTION NAME: createBodyForCreationOfCustomComponent
 *
 * DESCRIPTION: method to create http Body to create component
 *
 * RETURNS: data stream of request body
 *
 * PARAMETERS : ComponentCatalog object
 **************************************************************************************************************************/
-(NSData*) createBodyForCreationOfCustomComponent:(ComponentCatalog *)createComponentCatalog{
    
    if (createComponentCatalog.componentName == nil || createComponentCatalog.componentVersion == nil ||
        createComponentCatalog.componentType == nil || createComponentCatalog.componentDataType == nil ||
        createComponentCatalog.componentFormat == nil || createComponentCatalog.componentUnit == nil ||
        createComponentCatalog.componentDisplay == nil) {
        NSLog(@"%@:Mandatory field missing to create component catalog",TAG);
        return nil;
    }
    NSMutableDictionary *componentDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:createComponentCatalog.componentName,DIMENSION,createComponentCatalog.componentVersion,VERSION,
                                                createComponentCatalog.componentType,TYPE,createComponentCatalog.componentDataType,DATATYPE,createComponentCatalog.componentFormat,FORMAT,createComponentCatalog.componentUnit,MEASUREUNIT,createComponentCatalog.componentDisplay,DISPLAY,nil];
    
    //add min,max values if exist
    componentDictionary = [self addMinMaxValuesToHttpBody:createComponentCatalog ToDictionary:componentDictionary];
    componentDictionary = [self addActuatorCommandParametersToHttpBody:createComponentCatalog
                                                          ToDictionary:componentDictionary];
    NSError *error;
    return [NSJSONSerialization dataWithJSONObject:componentDictionary options:NSJSONWritingPrettyPrinted error:&error];
}
/***************************************************************************************************************************
 * FUNCTION NAME: validateActuatorCommand
 *
 * DESCRIPTION: method to validate command params on actuator
 *
 * RETURNS: true/false
 *
 * PARAMETERS : ComponentCatalog object
 **************************************************************************************************************************/
-(BOOL) validateActuatorCommand:(ComponentCatalog*) ComponentCatalog {
    if ([ComponentCatalog.componentType isEqualToString:ACTUATOR] &&
        ComponentCatalog.actuatorCommandParams == nil) {
        NSLog(@"%@:Command Parameters are mandatory for component catalog type \"actuator\"",TAG);
        return false;
    }
    if (![ComponentCatalog.componentType isEqualToString:ACTUATOR] &&
        ComponentCatalog.commandString != nil) {
        NSLog(@"%@:Command Json(command string and params) not required  for catalog type \"%@\""
              ,TAG,ComponentCatalog.componentType);
        return false;
    }
    return true;
}
/***************************************************************************************************************************
 * FUNCTION NAME: addActuatorCommandParametersToHttpBody
 *
 * DESCRIPTION: method to add command parameters to http body
 *
 * RETURNS: component dictionary
 *
 * PARAMETERS : 1)ComponentCatalog object
                2)component Dictionary
 **************************************************************************************************************************/
-(NSMutableDictionary*)addActuatorCommandParametersToHttpBody:(ComponentCatalog *)ComponentCatalog ToDictionary:(NSMutableDictionary*)componentDictionary{
    
    if (ComponentCatalog.commandString != nil) {
        NSMutableArray *parameterArray = [NSMutableArray array];
        for(id key in ComponentCatalog.actuatorCommandParams){
            [parameterArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:key,NAME,
                                       [ComponentCatalog.actuatorCommandParams objectForKey:key],VALUES,nil]];
            
        }
        
        NSMutableDictionary *commandDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:ComponentCatalog.commandString,COMMANDSTRING,parameterArray,PARAMETERS, nil];
        [componentDictionary setObject:commandDictionary forKey:COMMAND];
    }
    
    return componentDictionary;
}

/***************************************************************************************************************************
 * FUNCTION NAME: addMinMaxValuesToHttpBody
 *
 * DESCRIPTION: method to add min max values to http body
 *
 * RETURNS: component dictionary
 *
 * PARAMETERS :1)ComponentCatalog object
               2)component Dictionary
 **************************************************************************************************************************/
-(NSMutableDictionary*)addMinMaxValuesToHttpBody:(ComponentCatalog *)ComponentCatalog ToDictionary:(NSMutableDictionary*)componentDictionary{
    if (ComponentCatalog.isMinSet) {
        [componentDictionary setObject:[NSNumber numberWithDouble:ComponentCatalog.minValue] forKey:MINIMUM];
        
    }
    if (ComponentCatalog.isMaxSet) {
        [componentDictionary setObject:[NSNumber numberWithDouble:ComponentCatalog.maxValue] forKey:MAXIMUM];
        
    }
    return componentDictionary;
}


@end
