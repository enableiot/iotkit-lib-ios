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

#import "HttpUrlBuilder.h"
#import "HttpUrlMacros.h"

#define HTTP_PROTOCOL @"http://"
#define HTTPS_PROTOCOL  @"https://"
#define HEADER_CONTENT_TYPE_NAME  @"Content-Type"
#define HEADER_CONTENT_TYPE_JSON  @"application/json"
#define HEADER_AUTHORIZATION  @"Authorization"
#define HEADER_AUTHORIZATION_BEARER  @"Bearer"
#define TAG  @"HttpUrlBuilder"
#define AUTHTOKEN @"AuthToken"
#define DEVICETOKEN @"deviceToken"
#define ACCOUNTS @"accounts"
#define ACCOUNTNAME @"accountName"
#define ACTIVATIONCODE @"activationCode"
#define USERID @"userId"
#define SUB @"sub"
#define COMPONENTDETAILS @"componentDetails"
#define NULLSTRING @""

#define LEFTCURLYBRACE @"{"
#define RIGHTCURLYBRACE @"}"


@interface HttpUrlBuilder ()
{
    NSString *componentNameToDeleteFromDefaults;
    BOOL isDeviceIdFromDefaults;
}
-(id)initSingleTon;

@end

@implementation HttpUrlBuilder

/***************************************************************************************************************************
 * FUNCTION NAME: sharedInstance
 *
 * DESCRIPTION: Creates a shared instance of the class(singleton object creation)
 *
 * RETURNS: instance of the class HttpUrlBuilder
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/

+(id) sharedInstance{
    static HttpUrlBuilder *httpUrlBuilder;
    @synchronized(self){
        if(!httpUrlBuilder){
            
            httpUrlBuilder = [[HttpUrlBuilder alloc] initSingleTon];
            
        }
    }
    return httpUrlBuilder;
}

/***************************************************************************************************************************
 * FUNCTION NAME: initSingleTon
 *
 * DESCRIPTION: custom init method updates URL strings and creates user defaults
 *
 * RETURNS: instance of the class
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
- (id)initSingleTon
{
    self = [super init];
    if (!self) {
        return nil;
    }
    //updates url strings with Http urls
    [self updateUrlStringsUsingUrlMacros];
    //create NSUserdefaults
    [HttpUrlBuilder createUserDefaults];
    //check on whether deviceId considered is from defaults or not
    isDeviceIdFromDefaults = false;
    return self;
}

/***************************************************************************************************************************
 * FUNCTION NAME: updateUrlStringsUsingUrlMacros
 *
 * DESCRIPTION: Use Http Url Macros to update URL strings
 *
 * RETURNS: nothing
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(void) updateUrlStringsUsingUrlMacros {
    
    self.isSecured = [ISSECURED boolValue];
    self.baseUrl = HOST;
    self.thePort = [PORT integerValue];
    //Authorization
    self.theNewAuthToken = NEW_AUTH_TOKEN;
    self.authTokenInfo = AUTH_TOKEN_INFO;
    //Account Management
    self.createAnAccount = CREATE_AN_ACCOUNT;
    self.getAccountInfo = GET_ACCOUNT_INFO;
    self.getActivationCode  = GET_ACCOUNT_ACTIVATION_CODE;
    self.renewActivationCode = RENEW_ACCOUNT_ACTIVATION_CODE;
    self.updateAccount = UPDATE_ACCOUNT_NAME;
    self.deleteAccount = DELETE_ACCOUNT_NAME;
    self.addUserToAccount = ADD_USER_TO_ACCOUNT;
    //Device Management
    self.createDevice = CREATE_DEVICE;
    self.listDevices = LIST_ALL_DEVICES;
    self.getOneDeviceInfo = GET_DEVICE_INFO;
    self.getMyDeviceInfo = GET_MY_DEVICE_INFO;
    self.updateDevice = UPDATE_DEVICE;
    self.deleteDevice = DELETE_DEVICE;
    self.activateDevice = ACTIVATE_DEVICE;
    self.addComponent = ADD_COMPONENT;
    self.deleteComponent = DELETE_COMPONENT;
    self.listAllTags = LIST_ALL_TAGS;
    self.listAllAttributes = LIST_ALL_ATTRIBUTES;
    //Component Types Catalog
    self.listAllComponentTypesCatalog = LIST_COMPONENTS;
    self.listAllComponentTypesCatalogDetailed = LIST_COMPONENTS_DETAILED;
    self.componentTypeCatalogDetails = COMPONENTDETAILS;
    self.createCustomComponent = CREATE_COMPONENT_CATALOG;
    self.updateComponent = UPDATE_COMPONENT_CATALOG;
    //Data management
    self.submitData = SUBMIT_DATA;
    self.retrieveData = RETRIEVE_DATA;
    //User Management
    self.createUser = CREATE_USER;
    self.getUserInfo = GET_USER_INFO;
    self.updateUserAttributes = UPDATE_USER_ATTRIBUTES;
    self.acceptTermsAndConditions = ACCEPT_TERMS_AND_CONDITIONS;
    self.deleteUser = DELETE_USER;
    self.requestChangePassword = REQUEST_CHANGE_PASSWORD;
    self.changePassword = CHANGE_PASSWORD;
    //Invitation manegement
    self.getInvitationList = GET_LIST_OF_INVITATION;
    self.getInvitationListSendToSpecificUser = GET_LIST_OF_INVITATION_SEND_TO_SPECIFIC_USER;
    self.createInvitation = CREATE_INVITATION;
    self.deleteInvitations = DELETE_INVITATIONS;
    //Rule Management
    self.createRule = CREATE_RULE;
    self.updateRule = UPDATE_RULE;
    self.getListOfRules = GET_LIST_OF_RULES;
    self.getInfoOfRule = GET_RULE_INFO;
    self.createRuleAsDraft = CREATE_DRAFT_RULE;
    self.updateStatusOfRule = UPDATE_RULE_STATUS;
    self.deleteDraftRule = DELETE_DRAFT_RULE;
    //Alert management
    self.createNewAlert = CREATE_NEW_ALERT;
    self.getListOfAlerts = GET_LIST_OF_ALERTS;
    self.getAlertInformation = GET_ALERT_INFO;
    self.resetAlert = RESET_ALERT;
    self.updateAlertStatus = UPDATE_ALERT_STATUS;
    self.addCommentToAlert = ADD_COMMENT_TO_ALERT;
    //advanced data enquiry
    self.advancedEnquiryOfData = ADVANCED_DATA_INQUIRY;
    //aggregated report interface
    self.aggregatedReportInterface = AGGREGATED_REPORT_INTERFACE;
    //creating base URL for all HTTP requests
    self.baseUrl = [self createBaseUrl];
}

/***************************************************************************************************************************
 * FUNCTION NAME: createBaseUrl
 *
 * DESCRIPTION: building base IoT Url
 *
 * RETURNS: baseUrl
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
//building base IoT Url
-(NSString*)createBaseUrl{
    NSString *finalUrl;
    if (self.baseUrl) {
        //Add Http/Https based on isSecured value
        finalUrl = [NSString stringWithFormat:@"%@%@:%ld",(self.isSecured ? HTTPS_PROTOCOL : HTTP_PROTOCOL),
                    self.baseUrl,(long)self.thePort];
    }
    else{
        NSLog(@"%@:baseUrl is empty",TAG);
    }
    return finalUrl;
}
/***************************************************************************************************************************
 * FUNCTION NAME: prepareUrlByAppendingUrl
 *
 * DESCRIPTION: method to update Http Url's at run time using userDefaults or passed Urlslug values
 *
 * RETURNS: Http Url to request IoT server
 *
 * PARAMETERS : 1)Url string to append on baseUrl
                2)urlSlugDictionary contains user input values to replace in Url.
 **************************************************************************************************************************/
-(NSString*) prepareUrlByAppendingUrl:(NSString*)appendUrlString
                     urlSlugValueList:(NSDictionary*)urlSlugDictionary{
    NSString *urlPrepared;
    //validating appendUrlString for nil value
    if(!appendUrlString){
        NSLog(@"%@:Url String empty to append,Cannot create Url",TAG);
        return nil;
    }
    //replacing account id slug with value
    if([appendUrlString containsString:DATAACCOUNTID]){
        //check whether account id has been passed from user
        if([[urlSlugDictionary allKeys]containsObject:DATAACCOUNTID]){
            appendUrlString = [appendUrlString stringByReplacingOccurrencesOfString:DATAACCOUNTID withString:[urlSlugDictionary objectForKey:DATAACCOUNTID]];
        }
        //taking account id from user defaults
        else{
            NSLog(@"%@:replacing account id value from prefs to url-slug",TAG);
            appendUrlString = [appendUrlString stringByReplacingOccurrencesOfString:DATAACCOUNTID withString:[HttpUrlBuilder getAccountId]];
        }
        //replacing INVITEEUSERID slug with user passed userId
        if([appendUrlString containsString:INVITEEUSERID]){
            appendUrlString = [appendUrlString stringByReplacingOccurrencesOfString:INVITEEUSERID withString:[urlSlugDictionary objectForKey:INVITEEUSERID]];
        }
        //replacing CONFIGOTHERDEVICEID slug with user passed deviceId
        if([appendUrlString containsString:CONFIGOTHERDEVICEID]){
            appendUrlString = [appendUrlString stringByReplacingOccurrencesOfString:CONFIGOTHERDEVICEID withString:[urlSlugDictionary objectForKey:CONFIGOTHERDEVICEID]];
            //checking whether deviceId is from userdefaults, if so check flag ,so that we can delete device details from user defaults if request is to delete device
            if([[urlSlugDictionary objectForKey:CONFIGOTHERDEVICEID] isEqual:[[[NSUserDefaults standardUserDefaults] objectForKey:IOTPREFERENCES] objectForKey:DEVICEID]]){
                isDeviceIdFromDefaults = true;
            }
        }
        //replacing deviceId string with deviceId from user defaults
        if([appendUrlString containsString:CONFIGDEVICEID]){
            appendUrlString = [appendUrlString stringByReplacingOccurrencesOfString:CONFIGDEVICEID withString:[HttpUrlBuilder getDeviceId]];
        }
        //replacing cid with value from user deafults
        if([appendUrlString containsString:COMPONENTID]){
            //getting user passed component name
            componentNameToDeleteFromDefaults = [urlSlugDictionary objectForKey:NAME];
            //getting component id from user passed component name
            NSString *stringToReplace = [HttpUrlBuilder getComponentId:componentNameToDeleteFromDefaults];
            if(stringToReplace){
                appendUrlString = [appendUrlString stringByReplacingOccurrencesOfString:COMPONENTID withString:stringToReplace];
            }
            else{
                NSLog(@"%@:component Id not found for the given component name in user defaults",TAG);
                return nil;
            }
        }
        //replacing COMPONENTCATALOGID slug with user passed componentId
        if([appendUrlString containsString:COMPONENTCATALOGID]){
            appendUrlString = [appendUrlString stringByReplacingOccurrencesOfString:COMPONENTCATALOGID withString:[urlSlugDictionary objectForKey:COMPONENTCATALOGID]];
        }
        //replacing EMAIL slug with user passed mailId
        if ([appendUrlString containsString:EMAIL]){
            appendUrlString = [appendUrlString stringByReplacingOccurrencesOfString:EMAIL withString:[urlSlugDictionary objectForKey:EMAIL]];
        }
        //replacing RULEID slug with user passed ruleId
        if ([appendUrlString containsString:RULEID]){
            appendUrlString = [appendUrlString stringByReplacingOccurrencesOfString:RULEID withString:[urlSlugDictionary objectForKey:RULEID]];
        }
        //replacing ALERTID slug with user passed alertId
        if ([appendUrlString containsString:ALERTID]){
            appendUrlString = [appendUrlString stringByReplacingOccurrencesOfString:ALERTID withString:[urlSlugDictionary objectForKey:ALERTID]];
        }
        //replacing STATUSNAME slug with user passed status
        if ([appendUrlString containsString:STATUSNAME]){
            appendUrlString = [appendUrlString stringByReplacingOccurrencesOfString:STATUSNAME withString:[urlSlugDictionary objectForKey:STATUSNAME]];
        }
    }
    //replacing CONFIGDEVICEID with deviceId value from defaults
    else if ([appendUrlString containsString:CONFIGDEVICEID]){
        appendUrlString = [appendUrlString stringByReplacingOccurrencesOfString:CONFIGDEVICEID withString:[HttpUrlBuilder getDeviceId]];
    }
    //replacing CONFIGUSERID slug with user passed userId
    else if ([appendUrlString containsString:CONFIGUSERID]){
        appendUrlString = [appendUrlString stringByReplacingOccurrencesOfString:CONFIGUSERID withString:[urlSlugDictionary objectForKey:CONFIGUSERID]];
    }
    //replacing EMAIL slug with user passed mailId
    else if ([appendUrlString containsString:EMAIL]){
        appendUrlString = [appendUrlString stringByReplacingOccurrencesOfString:EMAIL withString:[urlSlugDictionary objectForKey:EMAIL]];
    }
    //replacing slug curly braces
    if([appendUrlString containsString:LEFTCURLYBRACE]){
        appendUrlString = [appendUrlString stringByReplacingOccurrencesOfString:LEFTCURLYBRACE
                                                                     withString:NULLSTRING];
        appendUrlString = [appendUrlString stringByReplacingOccurrencesOfString:RIGHTCURLYBRACE
                                                                     withString:NULLSTRING];
        
    }
    //creating url to hit IoT server
    urlPrepared = [NSString stringWithFormat:@"%@%@",self.baseUrl, appendUrlString];
    return urlPrepared;
}
/***************************************************************************************************************************
 * FUNCTION NAME: createUserDefaults
 *
 * DESCRIPTION: create user defaults
 *
 * RETURNS: nothing
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
+(void)createUserDefaults{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if([userDefaults objectForKey:IOTPREFERENCES] == nil){
        [HttpUrlBuilder resetUserDefaults];
    }
    else{
        NSLog(@"%@:user defaults already created!!",TAG);
    }
}
/***************************************************************************************************************************
 * FUNCTION NAME: resetUserDefaults
 *
 * DESCRIPTION: reset user defaults
 *
 * RETURNS: nothing
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
+(void)resetUserDefaults{
    NSMutableDictionary *iotPreferences = [[NSMutableDictionary alloc]init];
    [iotPreferences setObject:NULLSTRING forKey:AUTHTOKEN];
    [iotPreferences setObject:NULLSTRING forKey:DEVICETOKEN];
    [iotPreferences setObject:NULLSTRING forKey:USERID];
    [iotPreferences setObject:NULLSTRING forKey:ACCOUNTID];
    [iotPreferences setObject:NULLSTRING forKey:ACCOUNTNAME];
    [iotPreferences setObject:NULLSTRING forKey:DEVICEID];
    //stroing dictionary to store components
    [iotPreferences setObject:[NSMutableDictionary dictionary] forKey:COMPONENTDETAILS];
    [[NSUserDefaults standardUserDefaults] setObject:iotPreferences forKey:IOTPREFERENCES];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
/***************************************************************************************************************************
 * FUNCTION NAME: storeValue
 *
 * DESCRIPTION: updates userDefaults with the given key-value
 *
 * RETURNS: nothing
 *
 * PARAMETERS : 1)value to update
                2)key on which update given value
 **************************************************************************************************************************/
+(void) storeValue:(id)value forKey:(NSString*)key{
    [HttpUrlBuilder createUserDefaults];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //getting mutable copy to update the value
    NSMutableDictionary *mutableDefaults = [[userDefaults objectForKey:IOTPREFERENCES] mutableCopy];
    [mutableDefaults setObject:value forKey:key];
    [userDefaults setObject:mutableDefaults forKey:IOTPREFERENCES];
    [userDefaults synchronize];
}
/***************************************************************************************************************************
 * FUNCTION NAME: storeSensorValue
 *
 * DESCRIPTION: stores component name&id(sensor) value
 *
 * RETURNS: nothing
 *
 * PARAMETERS : 1)value to update
 2)key on which update given value
 **************************************************************************************************************************/
+(void) storeSensorValue:(id)value forKey:(NSString*)key{
    [HttpUrlBuilder createUserDefaults];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *mutableDefaults = [[userDefaults objectForKey:IOTPREFERENCES] mutableCopy];
    //getting mutable component dictionary
    NSMutableDictionary *componentDictionary =  [[mutableDefaults objectForKey:COMPONENTDETAILS] mutableCopy];
    [componentDictionary setObject:value forKey:key];
    //updating component dictionary
    [mutableDefaults setObject:componentDictionary forKey:COMPONENTDETAILS];
    [userDefaults setObject:mutableDefaults forKey:IOTPREFERENCES];
    [userDefaults synchronize];
}
/***************************************************************************************************************************
 * FUNCTION NAME: removeSensorKeyAndValue
 *
 * DESCRIPTION: removes component id for the given key
 *
 * RETURNS: nothing
 *
 * PARAMETERS : key on which remove component details

 **************************************************************************************************************************/
+(void) removeSensorKeyAndValue:(NSString*)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *mutableDefaults = [[userDefaults objectForKey:IOTPREFERENCES] mutableCopy];
    NSMutableDictionary *componentDictionary =  [[mutableDefaults objectForKey:COMPONENTDETAILS] mutableCopy];
    [componentDictionary removeObjectForKey:key];
    [mutableDefaults setObject:componentDictionary forKey:COMPONENTDETAILS];
    [userDefaults setObject:mutableDefaults forKey:IOTPREFERENCES];
    [userDefaults synchronize];
}
/***************************************************************************************************************************
 * FUNCTION NAME: removeDeviceDataFromDefaults
 *
 * DESCRIPTION: removes device related key-values from user defaults
 *
 * RETURNS: nothing
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
+(void) removeDeviceDataFromDefaults{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *mutableDefaults = [[userDefaults objectForKey:IOTPREFERENCES] mutableCopy];
    [mutableDefaults setObject:NULLSTRING forKey:DEVICEID];
    [mutableDefaults setObject:NULLSTRING forKey:DEVICETOKEN];
    [mutableDefaults setObject:NULLSTRING forKey:DEVICENAME];
    NSMutableDictionary *componentDictionary =  [[mutableDefaults objectForKey:COMPONENTDETAILS] mutableCopy];
    if([componentDictionary count]){
        [componentDictionary removeAllObjects];
    }
    [mutableDefaults setObject:componentDictionary forKey:COMPONENTDETAILS];
    [userDefaults setObject:mutableDefaults forKey:IOTPREFERENCES];
    [userDefaults synchronize];
}
/***************************************************************************************************************************
 * FUNCTION NAME: createDictionaryFromJsonString
 *
 * DESCRIPTION:creates dictionary from server response
 *
 * RETURNS: dictionary
 *
 * PARAMETERS : response from server
 **************************************************************************************************************************/
+(NSDictionary*)createDictionaryFromJsonString:(NSString*)responseContent{
    return [NSJSONSerialization JSONObjectWithData: [responseContent dataUsingEncoding:NSUTF8StringEncoding]
                                           options: NSJSONReadingMutableContainers error: nil];
}
/***************************************************************************************************************************
 * FUNCTION NAME: parseAndStoreAuthorizationToken
 *
 * DESCRIPTION:parse server response for auth-token & store it to defaults
 *
 * RETURNS: nothing
 *
 * PARAMETERS : 1)responseCode from server
                2)responseContent to parse
 **************************************************************************************************************************/
+(void) parseAndStoreAuthorizationToken:(NSInteger)responseCode content:(NSString*)responseContent{
    if(responseCode != 200){
        NSLog(@"%@:invalid response for token request",TAG);
        return;
    }
    //creates dictionary from string
    NSDictionary *responseDictionary = [HttpUrlBuilder createDictionaryFromJsonString:responseContent];
    if(responseDictionary){
        NSString* value =  [responseDictionary objectForKey:TOKEN];
        if(!value){
            NSLog(@"%@:not found value for key \"token\"",TAG);
            return;
        }
        [HttpUrlBuilder storeValue:value forKey:AUTHTOKEN];
        NSLog(@"%@:token stored in shred prefs:%@",TAG,value);
    }
    else{
        NSLog(@"%@:response dictionary is empty for get token",TAG);
    }
    
}
/***************************************************************************************************************************
 * FUNCTION NAME: parseAndStoreTokenRelatedInfo
 *
 * DESCRIPTION:parse server response for toke related info(userid,accounts,etc..) & store it to defaults
 *
 * RETURNS: nothing
 *
 * PARAMETERS : 1)responseCode from server
                2)responseContent to parse
 **************************************************************************************************************************/
+(void) parseAndStoreTokenRelatedInfo:(NSInteger)responseCode content:(NSString*)responseContent{
    if(responseCode != 200){
        NSLog(@"%@:invalid response for tokenInfo request",TAG);
        return;
    }
    NSDictionary *responseDictionary = [HttpUrlBuilder createDictionaryFromJsonString:responseContent];
    if(responseDictionary){
        //extracting payload response
        NSDictionary* payLoadDictionary =  [responseDictionary objectForKey:@"payload"];
        if(!payLoadDictionary){
            NSLog(@"%@:not found payload json for key \"payload\"",TAG);
            return;
        }
        NSString *userId = [payLoadDictionary objectForKey:SUB];
        [HttpUrlBuilder storeValue:userId forKey:USERID];
        NSLog(@"%@:userID stored in shred prefs:%@",TAG,userId);
        //Block for storing account in user defaults,if exists in token info response
        if([[payLoadDictionary allKeys] containsObject:ACCOUNTS]){
            NSArray *accountsArray = [payLoadDictionary objectForKey:ACCOUNTS];
            //[HttpUrlBuilder storeValue:accountsArray forKey:ACCOUNTS];
            NSDictionary *accountDictionary = [accountsArray objectAtIndex:0];
            [HttpUrlBuilder storeAccountDetails:accountDictionary];
        }
        else{
            NSLog(@"%@:no accounts associated with this user",TAG);
        }
    }
    else{
        NSLog(@"%@:response dictionary is empty for token info",TAG);
    }
    
}
/***************************************************************************************************************************
 * FUNCTION NAME: parseAndStoreUserDetails
 *
 * DESCRIPTION:parse server response for user info & store it to defaults
 *
 * RETURNS: nothing
 *
 * PARAMETERS : 1)responseCode from server
                2)responseContent to parse
 **************************************************************************************************************************/
+(void) parseAndStoreUserDetails:(NSInteger)responseCode content:(NSString *)responseContent{
    if(responseCode != 201){
        NSLog(@"%@:invalid response for user details storage",TAG);
        return;
    }
    NSDictionary *responseDictionary = [HttpUrlBuilder createDictionaryFromJsonString:responseContent];
    [HttpUrlBuilder resetDefaultsAndStoreUserId:[responseDictionary objectForKey:ID]];
}
/***************************************************************************************************************************
 * FUNCTION NAME: resetDefaultsAndStoreUserId
 *
 * DESCRIPTION:store userId it to defaults
 *
 * RETURNS: nothing
 *
 * PARAMETERS : userId to store
 **************************************************************************************************************************/
+(void) resetDefaultsAndStoreUserId:(NSString*)userId{
    [HttpUrlBuilder resetUserDefaults];
    [HttpUrlBuilder storeValue:userId forKey:USERID];
}
/***************************************************************************************************************************
 * FUNCTION NAME: parseAndResetDefaults
 *
 * DESCRIPTION:reset defaults on success code
 *
 * RETURNS: nothing
 *
 * PARAMETERS : responseCode from server
 **************************************************************************************************************************/
+(void)parseAndResetDefaults:(NSInteger)responseCode{
    if(responseCode != 204){
        NSLog(@"%@:invalid response for delete user",TAG);
        return;
    }
    [HttpUrlBuilder resetUserDefaults];
}
/***************************************************************************************************************************
 * FUNCTION NAME: parseAndStoreAccountDetails
 *
 * DESCRIPTION:parse server response for account details & store it to defaults
 *
 * RETURNS: nothing
 *
 * PARAMETERS : 1)responseCode from server
                2)responseContent to parse
 **************************************************************************************************************************/
+(void) parseAndStoreAccountDetails:(NSInteger)responseCode content:(NSString*)responseContent{
    if(responseCode != 201){
        NSLog(@"%@:invalid response for account details storage",TAG);
        return;
    }
    NSDictionary *responseDictionary = [HttpUrlBuilder createDictionaryFromJsonString:responseContent];
    [HttpUrlBuilder storeAccountDetails:responseDictionary];
}
/***************************************************************************************************************************
 * FUNCTION NAME: storeAccountDetails
 *
 * DESCRIPTION: store account details to defaults
 *
 * RETURNS: nothing
 *
 * PARAMETERS : accountDictionary to extract account details
 **************************************************************************************************************************/
+(void)storeAccountDetails:(NSDictionary*)accountDictionary{
    if(accountDictionary){
        NSString *accountName = [accountDictionary objectForKey:@"name"];
        NSString *accountId = [accountDictionary objectForKey:@"id"];
        [HttpUrlBuilder storeValue:accountName forKey:ACCOUNTNAME];
        [HttpUrlBuilder storeValue:accountId forKey:ACCOUNTID];
    }
    else{
        NSLog(@"%@:accountDictionary  is empty for account details storage in defaults",TAG);
    }
}
/***************************************************************************************************************************
 * FUNCTION NAME: parseAndStoreAccountName
 *
 * DESCRIPTION:parse server response for account name & store it to defaults
 *
 * RETURNS: nothing
 *
 * PARAMETERS : 1)responseCode from server
                2)responseContent to parse
 **************************************************************************************************************************/
+(void)parseAndStoreAccountName:(NSInteger)responseCode content:(NSString*)responseContent{
    if(responseCode != 200){
        NSLog(@"%@:invalid response for account update details storage",TAG);
        return;
    }
    NSDictionary *responseDictionary = [HttpUrlBuilder createDictionaryFromJsonString:responseContent];
    if(responseDictionary){
        NSString *accountName = [responseDictionary objectForKey:@"name"];
        [HttpUrlBuilder storeValue:accountName forKey:ACCOUNTNAME];
    }
}
/***************************************************************************************************************************
 * FUNCTION NAME: parseAndStoreActivationCode
 *
 * DESCRIPTION:parse server response for account activation code & store it to defaults
 *
 * RETURNS: nothing
 *
 * PARAMETERS : 1)responseCode from server
                2)responseContent to parse
 **************************************************************************************************************************/
+(void)parseAndStoreActivationCode:(NSInteger)responseCode content:(NSString*)responseContent{
    if(responseCode != 200){
        NSLog(@"%@:invalid response for account activation code storage",TAG);
        return;
    }
    NSDictionary *responseDictionary = [HttpUrlBuilder createDictionaryFromJsonString:responseContent];
    if(responseDictionary){
        NSString *activationCode = [responseDictionary objectForKey:ACTIVATIONCODE];
        [HttpUrlBuilder storeValue:activationCode forKey:ACTIVATIONCODE];
    }
}
/***************************************************************************************************************************
 * FUNCTION NAME: parseAndStoreDeviceId
 *
 * DESCRIPTION:parse server response for device ID & store it to defaults
 *
 * RETURNS: nothing
 *
 * PARAMETERS : 1)responseCode from server
                2)responseContent to parse
 **************************************************************************************************************************/
+(void)parseAndStoreDeviceId:(NSInteger)responseCode content:(NSString*)responseContent{
    if(responseCode != 201){
        NSLog(@"%@:failure response for create device",TAG);
        return;
    }
    NSDictionary *responseDictionary = [HttpUrlBuilder createDictionaryFromJsonString:responseContent];
    [HttpUrlBuilder storeValue:[responseDictionary objectForKey:DEVICEID] forKey:DEVICEID];
    [HttpUrlBuilder storeValue:[responseDictionary objectForKey:NAME] forKey:DEVICENAME];
}
/***************************************************************************************************************************
 * FUNCTION NAME: parseAndStoreDeviceToken
 *
 * DESCRIPTION:parse server response for device token & store it to defaults
 *
 * RETURNS: nothing
 *
 * PARAMETERS : 1)responseCode from server
                2)responseContent to parse
 **************************************************************************************************************************/
+(void)parseAndStoreDeviceToken:(NSInteger)responseCode content:(NSString *)responseContent{
    if(responseCode != 200){
        NSLog(@"%@:failure response for device activation",TAG);
        return;
    }
    NSDictionary *responseDictionary = [HttpUrlBuilder createDictionaryFromJsonString:responseContent];
    [HttpUrlBuilder storeValue:[responseDictionary objectForKey:DEVICETOKEN] forKey:DEVICETOKEN];
}
/***************************************************************************************************************************
 * FUNCTION NAME: parseAndStoreComponentDetails
 *
 * DESCRIPTION:parse server response for component details & store it to defaults
 *
 * RETURNS: nothing
 *
 * PARAMETERS : 1)responseCode from server
                2)responseContent to parse
 **************************************************************************************************************************/
+(void)parseAndStoreComponentDetails:(NSInteger)responseCode content:(NSString*)responseContent{
    if(responseCode != 201){
        NSLog(@"%@:failure response for add component",TAG);
        return;
    }
    NSDictionary *responseDictionary = [HttpUrlBuilder createDictionaryFromJsonString:responseContent];
    [HttpUrlBuilder storeSensorValue:[responseDictionary objectForKey:COMPONENTID] forKey:[responseDictionary objectForKey:NAME]];
}
//rule-Id methods supported to store ruleId/draftRuleID/delete draftRuleId
/***************************************************************************************************************************
 * FUNCTION NAME: parseAndStoreRuleId
 *
 * DESCRIPTION:parse server response for Rule id & store it to defaults
 *
 * RETURNS: nothing
 *
 * PARAMETERS : 1)responseCode from server
                2)responseContent to parse
 **************************************************************************************************************************/
+(void)parseAndStoreRuleId:(NSInteger)responseCode content:(NSString *)responseContent{
    if(responseCode != 201){
        NSLog(@"%@:failure response for rule Id storage",TAG);
        return;
    }
    NSDictionary *responseDictionary = [HttpUrlBuilder createDictionaryFromJsonString:responseContent];
    [[NSUserDefaults standardUserDefaults] setObject:[responseDictionary objectForKey:EXTERNALRULEID]
                                              forKey:RULEID];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
/***************************************************************************************************************************
 * FUNCTION NAME: parseAndStoreDraftRuleId
 *
 * DESCRIPTION:parse server response for draft rule Id & store it to defaults
 *
 * RETURNS: nothing
 *
 * PARAMETERS : 1)responseCode from server
                2)responseContent to parse
 **************************************************************************************************************************/
+(void)parseAndStoreDraftRuleId:(NSInteger)responseCode content:(NSString *)responseContent{
    if(responseCode != 200){
        NSLog(@"%@:failure response for draft rule Id storage",TAG);
        return;
    }
    NSDictionary *responseDictionary = [HttpUrlBuilder createDictionaryFromJsonString:responseContent];
    [[NSUserDefaults standardUserDefaults] setObject:[responseDictionary objectForKey:EXTERNALRULEID]
                                              forKey:DRAFTRULEID];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
/***************************************************************************************************************************
 * FUNCTION NAME: parseAndDeleteDraftRuleId
 *
 * DESCRIPTION:check server response code for delete & update ruleId with empty value
 *
 * RETURNS: nothing
 *
 * PARAMETERS : responseCode from server

 **************************************************************************************************************************/
+(void)parseAndDeleteDraftRuleId:(NSInteger)responseCode {
    if(responseCode != 204){
        NSLog(@"%@:failure response for delete draft rule Id",TAG);
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:NULLSTRING
                                              forKey:DRAFTRULEID];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
/***************************************************************************************************************************
 * FUNCTION NAME: deleteAccountInUserDefaults
 *
 * DESCRIPTION:check server response code for delete & update account details with empty value
 *
 * RETURNS: nothing
 *
 * PARAMETERS : responseCode from server
 
 **************************************************************************************************************************/
+(void)deleteAccountInUserDefaults:(NSInteger)responseCode{
    
    if(responseCode != 204){
        NSLog(@"%@:failure response for delete account,Not deleting account from user defaults",TAG);
        return;
    }
    [HttpUrlBuilder storeValue:NULLSTRING forKey:ACCOUNTNAME];
    [HttpUrlBuilder storeValue:NULLSTRING forKey:ACCOUNTID];
    [HttpUrlBuilder storeValue:NULLSTRING forKey:ACTIVATIONCODE];
    //empty-ing associated device details
    [HttpUrlBuilder removeDeviceDataFromDefaults];
    
}
/***************************************************************************************************************************
 * FUNCTION NAME: deleteComponentFromUserDefaults
 *
 * DESCRIPTION:check server response code for delete & update component details with empty value
 *
 * RETURNS: nothing
 *
 * PARAMETERS : responseCode from server
 
 **************************************************************************************************************************/
-(void)deleteComponentFromUserDefaults:(NSInteger)responseCode{
    if(responseCode != 204){
        NSLog(@"%@:failure response for delete component,Not deleting component from user defaults",TAG);
        return;
    }
    [HttpUrlBuilder removeSensorKeyAndValue:componentNameToDeleteFromDefaults];
    componentNameToDeleteFromDefaults = nil;
}
/***************************************************************************************************************************
 * FUNCTION NAME: cleanUpDeviceFromDefaults
 *
 * DESCRIPTION:check server response code for delete & update device details with empty value
 *
 * RETURNS: nothing
 *
 * PARAMETERS : responseCode from server
 
 **************************************************************************************************************************/
-(void)cleanUpDeviceFromDefaults:(NSInteger)responseCode{
    if(responseCode != 204){
        NSLog(@"%@:failure response for delete device,Not deleting device from user defaults",TAG);
        return;
    }
    [HttpUrlBuilder removeDeviceDataFromDefaults];
    isDeviceIdFromDefaults = false;
}
/***************************************************************************************************************************
 * FUNCTION NAME: createBasicHeadersWithBearerAuthToken
 *
 * DESCRIPTION:creates Http header value with Bearer auth token
 *
 * RETURNS: bearer auth token string header
 *
 * PARAMETERS : nil
 
 **************************************************************************************************************************/
+(NSString*) createBasicHeadersWithBearerAuthToken{
    return [NSString stringWithFormat:@"%@ %@",HEADER_AUTHORIZATION_BEARER,[[[NSUserDefaults standardUserDefaults] objectForKey:IOTPREFERENCES] objectForKey:AUTHTOKEN]];
}
/***************************************************************************************************************************
 * FUNCTION NAME: createBasicHeadersWithBearerDeviceToken
 *
 * DESCRIPTION:creates Http header value with Bearer device token
 *
 * RETURNS: bearer device token string header
 *
 * PARAMETERS : nil
 
 **************************************************************************************************************************/
+(NSString*) createBasicHeadersWithBearerDeviceToken{
    return [NSString stringWithFormat:@"%@ %@",HEADER_AUTHORIZATION_BEARER,[[[NSUserDefaults standardUserDefaults] objectForKey:IOTPREFERENCES] objectForKey:DEVICETOKEN]];
}
/***************************************************************************************************************************
 * FUNCTION NAME: getAccountId
 *
 * DESCRIPTION:gets accountId from userdefaults
 *
 * RETURNS: accountId
 *
 * PARAMETERS : nil
 
 **************************************************************************************************************************/
+(NSString*)getAccountId{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:IOTPREFERENCES] objectForKey:ACCOUNTID];
}
/***************************************************************************************************************************
 * FUNCTION NAME: getAccountName
 *
 * DESCRIPTION:gets accountName from userdefaults
 *
 * RETURNS: accountName
 *
 * PARAMETERS : nil
 
 **************************************************************************************************************************/
+(NSString*)getAccountName{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:IOTPREFERENCES] objectForKey:ACCOUNTNAME];
}
/***************************************************************************************************************************
 * FUNCTION NAME: getAccountActivationCode
 *
 * DESCRIPTION:gets activationCode from userdefaults
 *
 * RETURNS: activationCode
 *
 * PARAMETERS : nil
 
 **************************************************************************************************************************/
+(NSString*)getAccountActivationCode{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:IOTPREFERENCES] objectForKey:ACTIVATIONCODE];
}
/***************************************************************************************************************************
 * FUNCTION NAME: getDeviceId
 *
 * DESCRIPTION:gets deviceId from userdefaults
 *
 * RETURNS: deviceId
 *
 * PARAMETERS : nil
 
 **************************************************************************************************************************/
+(NSString*)getDeviceId{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:IOTPREFERENCES] objectForKey:DEVICEID];
}
/***************************************************************************************************************************
 * FUNCTION NAME: getDeviceName
 *
 * DESCRIPTION:gets deviceName from userdefaults
 *
 * RETURNS: deviceName
 *
 * PARAMETERS : nil
 
 **************************************************************************************************************************/
+(NSString*)getDeviceName{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:IOTPREFERENCES] objectForKey:DEVICENAME];
}
/***************************************************************************************************************************
 * FUNCTION NAME: getUserId
 *
 * DESCRIPTION:gets userId from userdefaults
 *
 * RETURNS: userId
 *
 * PARAMETERS : nil
 
 **************************************************************************************************************************/
+(NSString*)getUserId{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:IOTPREFERENCES] objectForKey:USERID];
}
/***************************************************************************************************************************
 * FUNCTION NAME: getComponentId
 *
 * DESCRIPTION:gets componentId from userdefaults
 *
 * RETURNS: componentId
 *
 * PARAMETERS : nil
 
 **************************************************************************************************************************/
+(NSString*)getComponentId:(NSString*)componentName{
    
    return [[[[NSUserDefaults standardUserDefaults] objectForKey:IOTPREFERENCES]
             objectForKey:COMPONENTDETAILS]objectForKey:componentName];
    
}
/***************************************************************************************************************************
 * FUNCTION NAME: getComponentName
 *
 * DESCRIPTION:gets componentName from userdefaults
 *
 * RETURNS: componentName
 *
 * PARAMETERS : nil
 
 **************************************************************************************************************************/
+(NSString*)getComponentName{
    NSDictionary *componentDictionary = [[[NSUserDefaults standardUserDefaults] objectForKey:IOTPREFERENCES] objectForKey:COMPONENTDETAILS];
    NSString *componentName = [[componentDictionary allKeys] objectAtIndex:0];
    return componentName;
}

@end
