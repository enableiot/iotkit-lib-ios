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

#import "RuleManagement.h"
#import "HttpRequestOperation.h"
#import "HttpResponseMacros.h"
#define TAG @"RuleManagement"
#define STATUS @"status"
#define DESCRIPTION @"description"
#define PRIORITY @"priority"
#define TYPE @"type"
#define RESETTYPE @"resetType"
#define TARGET @"target"
#define ACTIONS @"actions"
#define IDS @"ids"
#define CONDITIONS @"conditions"
#define OPERATOR @"operator"
#define VALUES @"values"
#define COMPONENT @"component"
#define DATATYPE @"dataType"
#define POPULATION @"population"

//#####Rule#######
@interface Rule ()

@property (nonatomic,retain)NSString* name;
@property (nonatomic,retain)NSString* desc;
@property (nonatomic,retain)NSString* priority;
@property (nonatomic,retain)NSString* type;
@property (nonatomic,retain)NSString* status;
@property (nonatomic,retain)NSString* resetType;
@property (nonatomic,retain)NSMutableArray* ruleActionsList;
// population
@property (nonatomic,retain)NSMutableArray* populationIds;
@property (nonatomic,retain)NSString* populationAttributes;
//conditions
@property (nonatomic,retain)NSString* operatorName;
@property (nonatomic,retain)NSMutableArray* ruleConditionValuesList;

@end

@implementation Rule
/***************************************************************************************************************************
 * FUNCTION NAME: setRuleName
 *
 * DESCRIPTION: sets rule Name
 **************************************************************************************************************************/
-(void)setRuleName:(NSString*)name{
    _name = name;
}
/***************************************************************************************************************************
 * FUNCTION NAME: setRuleDescription
 *
 * DESCRIPTION: sets rule Description
 **************************************************************************************************************************/
-(void)setRuleDescription:(NSString*)description {
     _desc = description;
}
/***************************************************************************************************************************
 * FUNCTION NAME: setRulePriority
 *
 * DESCRIPTION: sets rule priority
 **************************************************************************************************************************/
-(void)setRulePriority:(NSString*)priority{
    _priority = priority;
}
/***************************************************************************************************************************
 * FUNCTION NAME: setRuleType
 *
 * DESCRIPTION: sets type of rule
 **************************************************************************************************************************/
-(void)setRuleType:(NSString*)ruleType{
    _type = ruleType;
}
/***************************************************************************************************************************
 * FUNCTION NAME: setRuleStatus
 *
 * DESCRIPTION: sets status of rule
 **************************************************************************************************************************/
-(void)setRuleStatus:(NSString*)status{
    self.status = status;
}
/***************************************************************************************************************************
 * FUNCTION NAME: setRuleResetType
 *
 * DESCRIPTION: sets resetType of rule
 **************************************************************************************************************************/
-(void)setRuleResetType:(NSString*)resetType{
    _resetType = resetType;
}
/***************************************************************************************************************************
 * FUNCTION NAME: setRulePopulationAttributes
 *
 * DESCRIPTION: sets population attributes on rule
 **************************************************************************************************************************/
-(void)setRulePopulationAttributes:(NSString*)attributes{
    _populationAttributes = attributes;
}
/***************************************************************************************************************************
 * FUNCTION NAME: setRuleOperatorName
 *
 * DESCRIPTION: sets rule opeartor name
 **************************************************************************************************************************/
-(void)setRuleOperatorName:(NSString*)operatorName{
    _operatorName = operatorName;
}
/***************************************************************************************************************************
 * FUNCTION NAME: addRuleActions
 *
 * DESCRIPTION: adds rule action object to rule action list
 **************************************************************************************************************************/
-(void)addRuleActions:(RuleActions*)ruleActionsObj{
    if(!_ruleActionsList){
        _ruleActionsList = [NSMutableArray array];
    }
    [_ruleActionsList addObject:ruleActionsObj];
}
/***************************************************************************************************************************
 * FUNCTION NAME: addRulePopulationId
 *
 * DESCRIPTION: append population Id's to lsit of Id's
 **************************************************************************************************************************/
-(void)addRulePopulationId:(NSString*)populationId{
    if(!_populationIds){
        _populationIds = [NSMutableArray array];
    }
    [_populationIds addObject:populationId];
}
/***************************************************************************************************************************
 * FUNCTION NAME: addRuleConditionValues
 *
 * DESCRIPTION: append condition value obj to list of conditions
 **************************************************************************************************************************/
-(void)addRuleConditionValues:(RuleConditionValues*)RuleConditionValuesObj{
    if(!_ruleConditionValuesList){
        _ruleConditionValuesList = [NSMutableArray array];
    }
    [_ruleConditionValuesList addObject:RuleConditionValuesObj];
}

@end


//#####RuleActions#######
@interface RuleActions ()

@property (nonatomic,retain)NSString* type;
@property (nonatomic,retain)NSMutableArray* targetList;

@end


@implementation RuleActions
/***************************************************************************************************************************
 * FUNCTION NAME: setRuleActionType
 *
 * DESCRIPTION: sets action type on rule
 **************************************************************************************************************************/
-(void)setRuleActionType:(NSString*)type{
    _type = type;
}
/***************************************************************************************************************************
 * FUNCTION NAME: addRuleActionTarget
 *
 * DESCRIPTION: append rule target type to list of targets
 **************************************************************************************************************************/
-(void)addRuleActionTarget:(NSString*)target{
    if(!_targetList){
        _targetList = [NSMutableArray array];
    }
    [_targetList addObject:target];
}

@end

//#####RuleConditionValues#######
@interface RuleConditionValues ()

@property (nonatomic,retain)NSMutableDictionary* component;
@property (nonatomic,retain)NSString* ruleConditionType;
@property (nonatomic,retain)NSMutableArray* values;
@property (nonatomic,retain)NSString* ruleConditionValuesOperatorName;

@end


@implementation RuleConditionValues
/***************************************************************************************************************************
 * FUNCTION NAME: addConditionComponentWithKey
 *
 * DESCRIPTION: append key-value pair to component list
 **************************************************************************************************************************/
-(void)addConditionComponentWithKey:(NSString*)keyName AndValue:(NSString*)keyValue{
    if(!_component){
        _component = [NSMutableDictionary dictionary];
    }
    [_component setObject:keyValue forKey:keyName];
}
/***************************************************************************************************************************
 * FUNCTION NAME: setConditionType
 *
 * DESCRIPTION: sets rule condition type
 **************************************************************************************************************************/
-(void)setConditionType:(NSString*)ruleConditionType{
    _ruleConditionType = ruleConditionType;
}
/***************************************************************************************************************************
 * FUNCTION NAME: addConditionValues
 *
 * DESCRIPTION: append condition value to the list of values
 **************************************************************************************************************************/
-(void)addConditionValues:(NSString*)value{
    if(!_values){
        _values = [NSMutableArray array];
    }
    [_values addObject:value];
}

/***************************************************************************************************************************
 * FUNCTION NAME: setConditionOperator
 *
 * DESCRIPTION: sets condition operator
 **************************************************************************************************************************/
-(void)setConditionOperator:(NSString*)ruleConditionValuesOperatorName{
    _ruleConditionValuesOperatorName = ruleConditionValuesOperatorName;
}

@end


//#####RuleManagement#######
@implementation RuleManagement

/***************************************************************************************************************************
 * FUNCTION NAME: getListOfRules
 *
 * DESCRIPTION: requests list of rules
 **************************************************************************************************************************/
-(CloudResponse *)getListOfRules{
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.getListOfRules urlSlugValueList:nil];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:GETLISTOFRULES
                                                                     AndRequestBody:nil
                                                                  AndHttpMethodType:HTTPGET
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: getInformationOnRule
 *
 * DESCRIPTION: requests info of given rule id
 **************************************************************************************************************************/
-(CloudResponse *)getInformationOnRule:(NSString*)ruleId{
    if(!ruleId){
        return [CloudResponse createCloudResponseWithStatus:false andMessage:[NSString stringWithFormat:@"%@:Rule Id cannot be null",TAG]];
    }
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.getInfoOfRule urlSlugValueList:[NSDictionary dictionaryWithObject:ruleId forKey:RULEID]];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:GETINFOOFRULE
                                                                     AndRequestBody:nil
                                                                  AndHttpMethodType:HTTPGET
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: deleteADraftRule
 *
 * DESCRIPTION: requests delete of given rule id
 **************************************************************************************************************************/
-(CloudResponse *)deleteADraftRule:(NSString*)ruleId{
    if(!ruleId){
        return [CloudResponse createCloudResponseWithStatus:false andMessage:[NSString stringWithFormat:@"%@:Rule Id cannot be null",TAG]];
    }
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.deleteDraftRule urlSlugValueList:[NSDictionary dictionaryWithObject:ruleId forKey:RULEID]];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:DELETEDRAFTRULE
                                                                     AndRequestBody:nil
                                                                  AndHttpMethodType:HTTPDELETE
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: updateStatusOfRule
 *
 * DESCRIPTION: requests status update of given rule id with given status
 **************************************************************************************************************************/
-(CloudResponse *)updateStatusOfRule:(NSString*)ruleId WithStatus:(NSString*)status{
    if(!ruleId || !status){
        return [CloudResponse createCloudResponseWithStatus:false andMessage:[NSString stringWithFormat:@"%@:Rule Id or status cannot be null",TAG]];
    }
    NSData *data = [self createHttpBodyToUpdateRuleStatus:status];
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.updateStatusOfRule urlSlugValueList:[NSDictionary dictionaryWithObject:ruleId forKey:RULEID]];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:UPDATESTATUSOFRULE
                                                                     AndRequestBody:data
                                                                  AndHttpMethodType:HTTPPUT
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: createRuleAsDraftUsing
 *
 * DESCRIPTION: requests creation of draft rule using given rule Name
 **************************************************************************************************************************/
-(CloudResponse *)createRuleAsDraftUsing:(NSString*)ruleName{
    if(!ruleName){
        return [CloudResponse createCloudResponseWithStatus:false andMessage:[NSString stringWithFormat:@"%@:Rule name cannot be null",TAG]];
    }
    NSData *data = [self createHttpBodyToCreateRuleAsDraft:ruleName];
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.createRuleAsDraft urlSlugValueList:nil];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:CREATERULEASDRAFT
                                                                     AndRequestBody:data
                                                                  AndHttpMethodType:HTTPPUT
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: createRule
 *
 * DESCRIPTION: requests to create a rule
 **************************************************************************************************************************/
-(CloudResponse *)createRule:(Rule*)ruleObj{
    if(!ruleObj){
        return [CloudResponse createCloudResponseWithStatus:false andMessage:[NSString stringWithFormat:@"%@:create rule object cannot null",TAG]];
    }
    NSData *data = [self createHttpBodyToCreateRule:ruleObj];
    NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.createRule urlSlugValueList:nil];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:CREATERULE
                                                                     AndRequestBody:data
                                                                  AndHttpMethodType:HTTPPOST
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: updateARule
 *
 * DESCRIPTION: requests update of given ruleId
 **************************************************************************************************************************/
-(CloudResponse *)updateARule:(Rule *)updateRuleObj OnRule:(NSString *)ruleId{
    if(!updateRuleObj || !ruleId){
        return [CloudResponse createCloudResponseWithStatus:false andMessage:[NSString stringWithFormat:@"%@:create rule object or rule Id cannot null",TAG]];
    }
    NSData *data = [self createHttpBodyToCreateRule:updateRuleObj];
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.updateRule urlSlugValueList:[NSDictionary dictionaryWithObject:ruleId forKey:RULEID]];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:UPDATERULE
                                                                     AndRequestBody:data
                                                                  AndHttpMethodType:HTTPPUT
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: createHttpBodyToCreateRule
 *
 * DESCRIPTION: method to create http Body to create rule
 *
 * RETURNS: data stream of request body
 *
 * PARAMETERS : create rule object
 **************************************************************************************************************************/
-(NSData*)createHttpBodyToCreateRule:(Rule*)ruleObj{
    
    NSMutableDictionary *createRuleDictionary = [NSMutableDictionary dictionary];
    [createRuleDictionary setObject:ruleObj.name forKey:NAME];
    [createRuleDictionary setObject:ruleObj.desc forKey:DESCRIPTION];
    [createRuleDictionary setObject:ruleObj.priority forKey:PRIORITY];
    [createRuleDictionary setObject:ruleObj.type forKey:TYPE];
    [createRuleDictionary setObject:ruleObj.status forKey:STATUS];
    [createRuleDictionary setObject:ruleObj.resetType forKey:RESETTYPE];
    //adding actions
    NSMutableArray *ruleActionsArray = [NSMutableArray array];
    for(RuleActions *ruleActionsObj in ruleObj.ruleActionsList){
        NSDictionary *actionDictionary = [NSDictionary dictionaryWithObjectsAndKeys:ruleActionsObj.type,TYPE,ruleActionsObj.targetList,TARGET, nil];
        [ruleActionsArray addObject:actionDictionary];
    }
    [createRuleDictionary setObject:ruleActionsArray forKey:ACTIONS];
    NSDictionary *populationDictionary;
    //adding population
    if(!ruleObj.populationAttributes){
        populationDictionary  = [NSDictionary dictionaryWithObjectsAndKeys:[NSNull null],ATTRIBUTES,ruleObj.populationIds,IDS,nil];
    }
    else{
        populationDictionary = [NSDictionary dictionaryWithObjectsAndKeys:ruleObj.populationAttributes,ATTRIBUTES,ruleObj.populationIds,IDS,nil];
    }
    [createRuleDictionary setObject:populationDictionary forKey:POPULATION];
    //adding conditions
    NSMutableDictionary *conditionsDictionary = [NSMutableDictionary dictionaryWithObject:ruleObj.operatorName forKey:OPERATOR];
    NSMutableArray *valuesArray = [NSMutableArray array];
    for (RuleConditionValues *ruleConditionValuesObj in ruleObj.ruleConditionValuesList) {
        NSDictionary *valuesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:ruleConditionValuesObj.ruleConditionType,
                                          TYPE,ruleConditionValuesObj.ruleConditionValuesOperatorName,OPERATOR,
                                          ruleConditionValuesObj.values,VALUES,ruleConditionValuesObj.component,COMPONENT,nil];
        [valuesArray addObject:valuesDictionary];
    }
    [conditionsDictionary setObject:valuesArray forKey:VALUES];
    [createRuleDictionary setObject:conditionsDictionary forKey:CONDITIONS];
    NSError *error;
    return [NSJSONSerialization dataWithJSONObject:createRuleDictionary options:NSJSONWritingPrettyPrinted
                                             error:&error];
}
/***************************************************************************************************************************
 * FUNCTION NAME: createHttpBodyToCreateRuleAsDraft
 *
 * DESCRIPTION: method to create http Body to create draft rule
 *
 * RETURNS: data stream of request body
 *
 * PARAMETERS : rule Name
 **************************************************************************************************************************/
-(NSData*)createHttpBodyToCreateRuleAsDraft:(NSString*)ruleName{
    NSDictionary *createDraftRuleJson = [NSDictionary dictionaryWithObjectsAndKeys:ruleName,NAME,nil];
    NSError *error;
    return [NSJSONSerialization dataWithJSONObject:createDraftRuleJson options:NSJSONWritingPrettyPrinted
                                             error:&error];
}
/***************************************************************************************************************************
 * FUNCTION NAME: createHttpBodyToUpdateRuleStatus
 *
 * DESCRIPTION: method to create http Body to update rule status
 *
 * RETURNS: data stream of request body
 *
 * PARAMETERS : status of rule
 **************************************************************************************************************************/
-(NSData*)createHttpBodyToUpdateRuleStatus:(NSString*)status{
    NSDictionary *ruleStatusJson = [NSDictionary dictionaryWithObjectsAndKeys:status,STATUS,nil];
    NSError *error;
    return [NSJSONSerialization dataWithJSONObject:ruleStatusJson options:NSJSONWritingPrettyPrinted
                                             error:&error];
}
@end
