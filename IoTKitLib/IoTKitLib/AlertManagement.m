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

#import "AlertManagement.h"
#import "HttpRequestOperation.h"
#import "HttpResponseMacros.h"
#import "ConditionCmpsValuePoints.h"

#define TAG @"AlertManagement"

//#####ConditionCmpsValuePoints########
@interface ConditionCmpsValuePoints ()

@property(nonatomic,assign)long timeStamp;
@property(nonatomic,retain)NSString* value;

@end

@implementation ConditionCmpsValuePoints
/***************************************************************************************************************************
 * FUNCTION NAME: initConditionCmpsValuePoints
 *
 * DESCRIPTION: Creates custom instance of the class ConditionCmpsValuePoints
 *
 * RETURNS: instance of the class ConditionCmpsValuePoints
 *
 * PARAMETERS : 1)timeStamp
                2)alert Value
 **************************************************************************************************************************/
-(id)initConditionCmpsValuePoints:(long) timeStamp WithValue:(NSString*) value{
    self = [super init];
    if(self){
        self.timeStamp = timeStamp;
        self.value = value;
    }
    return self;
}

@end

//#####CreateNewAlertDataConditionComponents########

@interface CreateNewAlertDataConditionComponents ()

// components
@property(nonatomic,retain)NSString* cmpComponentId;
@property(nonatomic,retain)NSString* cmpDataType;
@property(nonatomic,retain)NSString* cmpComponentName;
//value points
@property(nonatomic,retain)NSMutableArray* conditionCmpsValuePointsList;

@end

@implementation CreateNewAlertDataConditionComponents
/***************************************************************************************************************************
 * FUNCTION NAME: alertSetComponentId
 *
 * DESCRIPTION: sets componenet Id
 *
 * RETURNS: nothing
 *
 * PARAMETERS : componentId
 **************************************************************************************************************************/
-(void)alertSetComponentId:(NSString*)cmpId{
    _cmpComponentId = cmpId;
}
/***************************************************************************************************************************
 * FUNCTION NAME: alertSetDataType
 *
 * DESCRIPTION: sets data type
 *
 * RETURNS: nothing
 *
 * PARAMETERS : cmdDataType
 **************************************************************************************************************************/
-(void)alertSetDataType:(NSString*)cmdDataType{
    _cmpDataType = cmdDataType;
}
/***************************************************************************************************************************
 * FUNCTION NAME: alertSetComponentName
 *
 * DESCRIPTION: sets component name
 *
 * RETURNS: nothing
 *
 * PARAMETERS : component name
 **************************************************************************************************************************/
-(void)alertSetComponentName:(NSString*)cmpName{
    _cmpComponentName = cmpName;
}
/***************************************************************************************************************************
 * FUNCTION NAME: alertAddValuePointsAt
 *
 * DESCRIPTION: append value to valuePoint list with time stamp
 *
 * RETURNS: nothing
 *
 * PARAMETERS : 1)timeStamp
                2)Value
 **************************************************************************************************************************/
-(void)alertAddValuePointsAt:(long) timeStamp With:(NSString*)value{
    if(!_conditionCmpsValuePointsList){
        _conditionCmpsValuePointsList = [NSMutableArray array];
    }
    [_conditionCmpsValuePointsList addObject:[[ConditionCmpsValuePoints alloc] initConditionCmpsValuePoints:timeStamp WithValue:value]];
}

@end


//#####CreateNewAlertDataConditions########
@interface CreateNewAlertDataConditions ()

// conditions
@property(nonatomic,retain)NSString* naturalLangCondition;
@property(nonatomic,assign)NSInteger conditionSequence;
// components
@property(nonatomic,retain)NSMutableArray* alertDataConditionCmpsList;

@end

@implementation CreateNewAlertDataConditions

/***************************************************************************************************************************
 * FUNCTION NAME: initCreateNewAlertDataConditions
 *
 * DESCRIPTION: Creates custom instance of the class CreateNewAlertDataConditions
 *
 * RETURNS: instance of the class CreateNewAlertDataConditions
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(id)initCreateNewAlertDataConditions{
    self = [super init];
    if(self){
        _conditionSequence = -1;
    }
    return self;
}
/***************************************************************************************************************************
 * FUNCTION NAME: alertSetConditionSequence
 *
 * DESCRIPTION: sets condition sequence on alert
 *
 * RETURNS: nothing
 *
 * PARAMETERS : conditionSequence
 **************************************************************************************************************************/
-(void)alertSetConditionSequence:(NSInteger)conditionSequence{
    _conditionSequence = conditionSequence;
}
/***************************************************************************************************************************
 * FUNCTION NAME: alertSetNaturalLanguageCondition
 *
 * DESCRIPTION: sets natural language condition
 *
 * RETURNS: nothing
 *
 * PARAMETERS : naturalLangCondition
 **************************************************************************************************************************/
-(void)alertSetNaturalLanguageCondition:(NSString*)naturalLangCondition{
    _naturalLangCondition = naturalLangCondition;
}
/***************************************************************************************************************************
 * FUNCTION NAME: alertAddComponents
 *
 * DESCRIPTION: append component object to data conditions list
 *
 * RETURNS: nothing
 *
 * PARAMETERS : component object **************************************************************************************************************************/
-(void)alertAddComponents:(CreateNewAlertDataConditionComponents*)component{
    if(!_alertDataConditionCmpsList){
        _alertDataConditionCmpsList = [NSMutableArray array];
    }
    [_alertDataConditionCmpsList addObject:component];
}

@end

//#####CreateNewAlertData########
@interface CreateNewAlertData ()

//data
@property(nonatomic,retain)NSString* accountId;
@property(nonatomic,retain)NSString* deviceId;
@property(nonatomic,retain)NSString* alertStatus;
@property(nonatomic,retain)NSString* resetType;
@property(nonatomic,retain)NSString* ruleName;
@property(nonatomic,retain)NSString* rulePriority;
@property(nonatomic,retain)NSString* naturalLangAlert;
@property(nonatomic,assign)NSInteger alertId;
@property(nonatomic,assign)NSInteger ruleId;
@property(nonatomic,assign)long timestamp;
@property(nonatomic,assign)long resetTimestamp;
@property(nonatomic,assign)long lastUpdateDate;
@property(nonatomic,assign)long ruleExecutionTimestamp;
//CreateNewAlertDataConditionsList conditions;
@property(nonatomic,retain)NSMutableArray* alertDataConditionsList;

@end

@implementation CreateNewAlertData
/***************************************************************************************************************************
 * FUNCTION NAME: initCreateNewAlertData
 *
 * DESCRIPTION: Creates custom instance of the class CreateNewAlertData
 *
 * RETURNS: instance of the class CreateNewAlertData
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(id)initCreateNewAlertData{
    self = [super init];
    if(self){
        _alertId = -1; // IDs are never expected to be -1
        _ruleId = -1; // IDs are never expected to be -1
        _timestamp = 0L;
        _resetTimestamp = 0L;
        _lastUpdateDate = 0L;
        _ruleExecutionTimestamp = -1L; // timestamps are never -1
    }
    return self;
}
/***************************************************************************************************************************
 * FUNCTION NAME: alertSetAccountId
 *
 * DESCRIPTION: sets account Id for alert
 *
 * RETURNS: nothing
 *
 * PARAMETERS : accountId
 **************************************************************************************************************************/
-(void)alertSetAccountId:(NSString*)accountId{
    _accountId = accountId;
}
/***************************************************************************************************************************
 * FUNCTION NAME: alertSetAlertId
 *
 * DESCRIPTION: sets alert Id
 *
 * RETURNS: nothing
 *
 * PARAMETERS : alertId
 **************************************************************************************************************************/
-(void)alertSetAlertId:(NSInteger)alertId{
    _alertId = alertId;
}
/***************************************************************************************************************************
 * FUNCTION NAME: alertSetRuleId
 *
 * DESCRIPTION: sets rule Id
 *
 * RETURNS: nothing
 *
 * PARAMETERS : ruleId
 **************************************************************************************************************************/
-(void)alertSetRuleId:(NSInteger)ruleId{
    _ruleId = ruleId;
}
/***************************************************************************************************************************
 * FUNCTION NAME: alertSetDeviceId
 *
 * DESCRIPTION: sets device Id
 *
 * RETURNS: nothing
 *
 * PARAMETERS : deviceId
 **************************************************************************************************************************/
-(void)alertSetDeviceId:(NSString*)deviceId{
    _deviceId = deviceId;
}
/***************************************************************************************************************************
 * FUNCTION NAME: alertSetAlertStatus
 *
 * DESCRIPTION: sets alert status
 *
 * RETURNS: nothing
 *
 * PARAMETERS : alertStatus
 **************************************************************************************************************************/
-(void)alertSetAlertStatus:(NSString*)alertStatus{
    _alertStatus = alertStatus;
}
/***************************************************************************************************************************
 * FUNCTION NAME: alertSetTimestamp
 *
 * DESCRIPTION: sets time stamp
 *
 * RETURNS: nothing
 *
 * PARAMETERS : timestamp
 **************************************************************************************************************************/
-(void)alertSetTimestamp:(long)timestamp{
    _timestamp = timestamp;
}
/***************************************************************************************************************************
 * FUNCTION NAME: alertSetResetTimestamp
 *
 * DESCRIPTION: sets reset time stamp on alert
 *
 * RETURNS: nothing
 *
 * PARAMETERS : resetTimestamp
 **************************************************************************************************************************/
-(void)alertSetResetTimestamp:(long)resetTimestamp{
    _resetTimestamp = resetTimestamp;
}
/***************************************************************************************************************************
 * FUNCTION NAME: alertSetResetType
 *
 * DESCRIPTION: sets reset type
 *
 * RETURNS: nothing
 *
 * PARAMETERS : resetType
 **************************************************************************************************************************/
-(void)alertSetResetType:(NSString*)resetType{
    _resetType = resetType;
}
/***************************************************************************************************************************
 * FUNCTION NAME: alertSetLastUpdateDate
 *
 * DESCRIPTION: sets last Update date
 *
 * RETURNS: nothing
 *
 * PARAMETERS : lastUpdateDate
 **************************************************************************************************************************/
-(void)alertSetLastUpdateDate:(long)lastUpdateDate{
    _lastUpdateDate = lastUpdateDate;
}
/***************************************************************************************************************************
 * FUNCTION NAME: alertSetRuleName
 *
 * DESCRIPTION: sets Rule Name
 *
 * RETURNS: nothing
 *
 * PARAMETERS : ruleName
 **************************************************************************************************************************/
-(void)alertSetRuleName:(NSString*)ruleName{
    _ruleName = ruleName;
}
/***************************************************************************************************************************
 * FUNCTION NAME: alertSetRulePriority
 *
 * DESCRIPTION: sets rule Priority
 *
 * RETURNS: nothing
 *
 * PARAMETERS : rulePriority
 **************************************************************************************************************************/
-(void)alertSetRulePriority:(NSString*)rulePriority{
    _rulePriority = rulePriority;
}
/***************************************************************************************************************************
 * FUNCTION NAME: alertSetNaturalLangAlert
 *
 * DESCRIPTION: sets natural language alert
 *
 * RETURNS: nothing
 *
 * PARAMETERS : naturalLangAlert
 **************************************************************************************************************************/
-(void)alertSetNaturalLangAlert:(NSString*)naturalLangAlert{
    _naturalLangAlert = naturalLangAlert;
}
/***************************************************************************************************************************
 * FUNCTION NAME: alertSetRuleExecutionTimestamp
 *
 * DESCRIPTION: sets rule execution time stamp
 *
 * RETURNS: nothing
 *
 * PARAMETERS : ruleExecutionTimestamp
 **************************************************************************************************************************/
-(void)alertSetRuleExecutionTimestamp:(long)ruleExecutionTimestamp{
    _ruleExecutionTimestamp = ruleExecutionTimestamp;
}
/***************************************************************************************************************************
 * FUNCTION NAME: alertAddNewAlertConditions
 *
 * DESCRIPTION: append condition object to data conditions list
 *
 * RETURNS: nothing
 *
 * PARAMETERS : conditionsObj object **************************************************************************************************************************/
-(void)alertAddNewAlertConditions:(CreateNewAlertDataConditions*)conditionsObj{
    if(!_alertDataConditionsList){
        _alertDataConditionsList = [NSMutableArray array];
    }
    [_alertDataConditionsList addObject:conditionsObj];
}

@end

//##########CreateNewAlert##############
@interface CreateNewAlert ()

@property(nonatomic,retain)NSString* msgType;
@property(nonatomic,retain)NSMutableArray* alertDataList;

@end

@implementation CreateNewAlert
/***************************************************************************************************************************
 * FUNCTION NAME: setMsgType
 *
 * DESCRIPTION: sets msg type on alert
 *
 * RETURNS: nothing
 *
 * PARAMETERS : msgType
 **************************************************************************************************************************/
-(void)setMsgType:(NSString*)msgType{
    _msgType = msgType;
}
/***************************************************************************************************************************
 * FUNCTION NAME: addNewAlertDataObject
 *
 * DESCRIPTION: append alert data object to alert data list
 *
 * RETURNS: nothing
 *
 * PARAMETERS : createNewAlertDataObj **************************************************************************************************************************/
-(void)addNewAlertDataObject:(CreateNewAlertData*)createNewAlertDataObj{
    if(!_alertDataList){
        _alertDataList = [NSMutableArray array];
    }
    [_alertDataList addObject:createNewAlertDataObj];
}

@end

//##########AlertManagement##############
@implementation AlertManagement

/***************************************************************************************************************************
 * FUNCTION NAME: getListOfAlerts
 *
 * DESCRIPTION: requests list of alerts
 *
 * RETURNS: true/false
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(BOOL)getListOfAlerts{
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.getListOfAlerts urlSlugValueList:nil];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:GETLISTOFALERTS
                                                                     AndRequestBody:nil
                                                                  AndHttpMethodType:HTTPGET
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: getInfoOnAlert
 *
 * DESCRIPTION: requests information on given alert ID
 *
 * RETURNS: true/false
 *
 * PARAMETERS : alertId
 **************************************************************************************************************************/
-(BOOL)getInfoOnAlert:(NSString *)alertId{
    if(!alertId){
        NSLog(@"%@:Alert ID cannot be null",TAG);
        return false;
    }
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.getAlertInformation urlSlugValueList:[NSDictionary dictionaryWithObjectsAndKeys:alertId,ALERTID,nil]];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:GETALERTINFORMATION
                                                                     AndRequestBody:nil
                                                                  AndHttpMethodType:HTTPGET
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
    
}
/***************************************************************************************************************************
 * FUNCTION NAME: resetAlert
 *
 * DESCRIPTION: requests reset of given alert id
 *
 * RETURNS: true/false
 *
 * PARAMETERS : alertId
 **************************************************************************************************************************/
-(BOOL)resetAlert:(NSString *)alertId{
    if(!alertId){
        NSLog(@"%@:Alert ID cannot be null",TAG);
        return false;
    }
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.resetAlert urlSlugValueList:[NSDictionary dictionaryWithObjectsAndKeys:alertId,ALERTID,nil]];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:RESETALERT
                                                                     AndRequestBody:nil
                                                                  AndHttpMethodType:HTTPPUT
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: updateAlertStatus
 *
 * DESCRIPTION: updates given alert with passed status
 *
 * RETURNS: true/false
 *
 * PARAMETERS : 1)alertId
                2)status
 **************************************************************************************************************************/
-(BOOL)updateAlertStatus:(NSString *)alertId WithStatus:(NSString *)status{
    if(!alertId || !status){
        NSLog(@"%@:Alert ID or status cannot be null",TAG);
        return false;
    }
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.updateAlertStatus urlSlugValueList:[NSDictionary dictionaryWithObjectsAndKeys:alertId,ALERTID,status,STATUSNAME,nil]];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:UPDATEALERTSTATUS
                                                                     AndRequestBody:nil
                                                                  AndHttpMethodType:HTTPPUT
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: addCommentsToTheAlert
 *
 * DESCRIPTION: add comment on user alert id at given time stamp
 *
 * RETURNS: true/false
 *
 * PARAMETERS : 1)alertId
                2)user
                3)timeStamp
                4)comment
 **************************************************************************************************************************/
-(BOOL)addCommentsToTheAlert:(NSString *)alertId OnUser:(NSString *)user AtTime:(long)timeStamp
                 WithComment:(NSString *)comment{
    if(!alertId || !user || !comment){
        NSLog(@"%@:Alert ID or user or comment cannot be null",TAG);
        return false;
    }
    NSData *data = [self createHttpBodyToAddCommentsToAlertOnUser:user AtTime:timeStamp WithComment:comment];
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.addCommentToAlert urlSlugValueList:[NSDictionary dictionaryWithObjectsAndKeys:alertId,ALERTID,nil]];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:ADDCOMMENTSTOALERT
                                                                     AndRequestBody:data
                                                                  AndHttpMethodType:HTTPPOST
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: createAlert
 *
 * DESCRIPTION: request for creating new alert
 *
 * RETURNS: true/false
 *
 * PARAMETERS :new alert object
 **************************************************************************************************************************/
-(BOOL)createAlert:(CreateNewAlert *)newAlert{
    if(!newAlert){
        NSLog(@"%@:CreateNewAlert object cannot be null",TAG);
        return false;
    }
    NSData *data = [self createHttpBodyToCreateAlert:newAlert];
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.createNewAlert urlSlugValueList:nil];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:CREATENEWALERT
                                                                     AndRequestBody:data
                                                                  AndHttpMethodType:HTTPPOST
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: createHttpBodyToCreateAlert
 *
 * DESCRIPTION: method to create http Body on creating alert
 *
 * RETURNS: data stream of request body
 *
 * PARAMETERS : newAlert object
 **************************************************************************************************************************/
-(NSData*)createHttpBodyToCreateAlert:(CreateNewAlert *)newAlert {
    
    NSMutableDictionary *createAlertJson = [NSMutableDictionary dictionary];
    
    if(newAlert.msgType){
        [createAlertJson setObject:newAlert.msgType forKey:@"msgType"];
    }else {
        [createAlertJson setObject:@"alertsPush" forKey:@"msgType"];
    }
    
    if(newAlert.alertDataList){
        NSMutableArray *alertDataArray = [NSMutableArray array];
        for (CreateNewAlertData *newAlertData in newAlert.alertDataList) {
            NSMutableDictionary *newAlertDataJson = [NSMutableDictionary dictionary];
            if (newAlertData.accountId) {
                [newAlertDataJson setObject:newAlertData.accountId forKey:@"accountId"];
            } else {
                [newAlertDataJson setObject:self.getAccountId forKey:@"accountId"];
            }
            if (newAlertData.deviceId) {
                [newAlertDataJson setObject:newAlertData.deviceId forKey:@"deviceId"];
            } else {
                [newAlertDataJson setObject:self.getDeviceId forKey:@"deviceId"];
            }
            if (newAlertData.alertId != -1) {
                [newAlertDataJson setObject:[NSNumber numberWithInteger:newAlertData.alertId] forKey:@"alertId"];
            }
            if (newAlertData.ruleId != -1) {
                [newAlertDataJson setObject:[NSNumber numberWithInteger:newAlertData.ruleId] forKey:@"ruleId"];
            }
            if (newAlertData.alertStatus) {
                [newAlertDataJson setObject:newAlertData.alertStatus forKey:@"alertStatus"];
            }
            if (newAlertData.timestamp > 0L) {
                [newAlertDataJson setObject:[NSNumber numberWithLong:newAlertData.timestamp] forKey:@"timestamp"];
                
            }
            if (newAlertData.resetTimestamp > 0L) {
                [newAlertDataJson setObject:[NSNumber numberWithLong:newAlertData.resetTimestamp] forKey:@"resetTimestamp"];
            }
            if (newAlertData.resetType) {
                [newAlertDataJson setObject:newAlertData.resetType forKey:@"resetType"];
            }
            if (newAlertData.ruleName) {
                [newAlertDataJson setObject:newAlertData.ruleName forKey:@"ruleName"];
            }
            if (newAlertData.lastUpdateDate > 0L) {
                [newAlertDataJson setObject:[NSNumber numberWithLong:newAlertData.lastUpdateDate]  forKey:@"lastUpdateDate"];
            }
            if (newAlertData.rulePriority) {
                [newAlertDataJson setObject:newAlertData.rulePriority forKey:@"rulePriority"];
            }
            
            if (newAlertData.naturalLangAlert) {
                [newAlertDataJson setObject:newAlertData.naturalLangAlert forKey:@"naturalLangAlert"];
            }
            if (newAlertData.ruleExecutionTimestamp > 0L) {
                [newAlertDataJson setObject:[NSNumber numberWithLong:newAlertData.ruleExecutionTimestamp] forKey:@"ruleExecutionTimestamp"];
            }
            if(newAlertData.alertDataConditionsList){
                NSMutableArray *conditionsArray = [NSMutableArray array];
                for (CreateNewAlertDataConditions *newAlertDataConditions in newAlertData.alertDataConditionsList) {
                    NSMutableDictionary *newAlertDataConditionsJson = [NSMutableDictionary dictionary];
                    if (newAlertDataConditions.conditionSequence > -1) {
                        [newAlertDataConditionsJson setObject:[NSNumber numberWithInteger:
                                                     newAlertDataConditions.conditionSequence] forKey:@"conditionSequence"];
                    }
                    if (newAlertDataConditions.naturalLangCondition) {
                        [newAlertDataConditionsJson setObject:newAlertDataConditions.naturalLangCondition forKey:@"naturalLangCondition"];
                    }
                    if (newAlertDataConditions.alertDataConditionCmpsList) {
                        NSMutableArray *ConditionCmpsArray = [NSMutableArray array];
                        for (CreateNewAlertDataConditionComponents *newAlertDataConditionComponent in newAlertDataConditions.alertDataConditionCmpsList) {
                            NSMutableDictionary *newAlertDataConditionComponentJson = [NSMutableDictionary dictionary];
                            if (newAlertDataConditionComponent.cmpComponentId) {
                                [newAlertDataConditionComponentJson setObject:newAlertDataConditionComponent.cmpComponentId forKey:@"componentId"];
                            }
                            if (newAlertDataConditionComponent.cmpDataType) {
                                [newAlertDataConditionComponentJson setObject:newAlertDataConditionComponent.cmpDataType forKey:@"dataType"];
                            }
                            if (newAlertDataConditionComponent.cmpComponentName) {
                                [newAlertDataConditionComponentJson setObject:newAlertDataConditionComponent.cmpComponentName forKey:@"componentName"];
                            }
                            if (newAlertDataConditionComponent.conditionCmpsValuePointsList) {
                                NSMutableArray *valuePointsArray = [NSMutableArray array];
                                for (ConditionCmpsValuePoints *valuePoint in newAlertDataConditionComponent.conditionCmpsValuePointsList) {
                                    NSDictionary *valuePointJson = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithLong:valuePoint.timeStamp],@"timestamp",
                                                                    valuePoint.value,@"value", nil];
                                    [valuePointsArray addObject:valuePointJson];
                                }
                                [newAlertDataConditionComponentJson setObject:valuePointsArray forKey:@"valuePoints"];
                            }
                            [ConditionCmpsArray addObject:newAlertDataConditionComponentJson];
                        }
                        [newAlertDataConditionsJson setObject:ConditionCmpsArray forKey:@"components"];
                    }
                    [conditionsArray addObject:newAlertDataConditionsJson];
                }
                [newAlertDataJson setObject:conditionsArray forKey:@"conditions"];
            }
            [alertDataArray addObject:newAlertDataJson];
        }
        [createAlertJson setObject:alertDataArray forKey:@"data"];
    }
    NSError *error;
    return [NSJSONSerialization dataWithJSONObject:createAlertJson
                                           options:NSJSONWritingPrettyPrinted
                                             error:&error];
}
/***************************************************************************************************************************
 * FUNCTION NAME: createHttpBodyToAddCommentsToAlertOnUser
 *
 * DESCRIPTION: method to create http Body on addCommentsToAlert
 *
 * RETURNS: data stream of request body
 *
 * PARAMETERS : 1)user
                2)timeStamp
                3)comment
 **************************************************************************************************************************/
-(NSData*)createHttpBodyToAddCommentsToAlertOnUser:(NSString *)user AtTime:(long)timeStamp
                                       WithComment:(NSString *)comment{
    NSDictionary *addCommentToAlertJson = [NSDictionary dictionaryWithObjectsAndKeys:user,USER,[NSNumber numberWithLong:timeStamp],TIMESTAMP,comment,TEXT,nil];
    NSError *error;
    return [NSJSONSerialization dataWithJSONObject:[NSArray arrayWithObject:addCommentToAlertJson]
                                           options:NSJSONWritingPrettyPrinted
                                             error:&error];
}

@end
