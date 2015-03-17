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

#import "AccountManagement.h"
#import "HttpRequestOperation.h"
#import "HttpResponseMacros.h"

#define TAG @"AccountManagement"
#define ACCOUNTS @"accounts"
#define ADMIN @"admin"
//default key-values needed to update account
#define HEALTHTIMEPERIOD @"healthTimePeriod"
#define EXECINTERVAL @"exec_interval"
#define BASELINEEXECINTERVAL @"base_line_exec_interval"
#define CDMODELFREQUENCY @"cd_model_frequency"
#define CDEXECUTIONFREQUENCY @"cd_execution_frequency"
#define DATARETENTION @"data_retention"
#define HEALTHTIMEPERIODVALUE 86400
#define EXECINTERVALVALUE 120
#define BASELINEEXECINTERVALVALUE 86400
#define CDMODELFREQUENCYVALUE 604800
#define CDEXECUTIONFREQUENCYVALUE 600
#define DATARETENTIONVALUE 0



@implementation AccountManagement

/***************************************************************************************************************************
 * FUNCTION NAME: createAnAccount
 *
 * DESCRIPTION: requests to create new account with given account name
 *
 * RETURNS: true/false
 *
 * PARAMETERS : accountName
 **************************************************************************************************************************/
-(CloudResponse *) createAnAccount:(NSString*)accountName{
    if(!accountName){
        NSLog(@"%@:Account Name cannot be empty",TAG);
        return false;
    }
    NSData *data = [self createBodyForAccountCreation:accountName];
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.createAnAccount urlSlugValueList:nil];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:CREATEANACCOUNT
                                                                     AndRequestBody:data
                                                                  AndHttpMethodType:HTTPPOST
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
    
}
/***************************************************************************************************************************
 * FUNCTION NAME: getAccountInformation
 *
 * DESCRIPTION: requests to get account information
 *
 * RETURNS: true/false
 *
 * PARAMETERS : nil **************************************************************************************************************************/
-(CloudResponse *) getAccountInformation {
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.getAccountInfo urlSlugValueList:nil];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:GETACCOUNTINFO
                                                                     AndRequestBody:nil
                                                                  AndHttpMethodType:HTTPGET
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
    
}
/***************************************************************************************************************************
 * FUNCTION NAME: getAccountActivationCode
 *
 * DESCRIPTION: requests to get account activation code
 *
 * RETURNS: true/false
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(CloudResponse *) getAccountActivationCode{
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.getActivationCode urlSlugValueList:nil];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:GETACTIVATIONCODE
                                                                     AndRequestBody:nil
                                                                  AndHttpMethodType:HTTPGET
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
    
}
/***************************************************************************************************************************
 * FUNCTION NAME: renewAccountActivationCode
 *
 * DESCRIPTION: requests to renew account activation code
 *
 * RETURNS: true/false
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(CloudResponse *) renewAccountActivationCode{
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.renewActivationCode urlSlugValueList:nil];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:RENEWACTIVATIONCODE
                                                                     AndRequestBody:nil
                                                                  AndHttpMethodType:HTTPPUT
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: updateAnAccount
 *
 * DESCRIPTION: requests to update an account with accountName&Optional attributes
 *
 * RETURNS: true/false
 *
 * PARAMETERS : 1)accountName
                2)optional attributes(can be nil)
 **************************************************************************************************************************/
-(CloudResponse *) updateAnAccount:(NSString*)accountNameToUpdate andOptionalAttributesWithSimpleKeyValues:(NSDictionary*)attributes{
    if(!accountNameToUpdate){
        NSLog(@"%@:Account Name mandatory,supply existing or new one",TAG);
        return false;
    }
    NSData *data = [self createBodyForAccountUpdation:accountNameToUpdate andOptionalAttributesWithSimpleKeyValues:attributes ];
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.updateAccount urlSlugValueList:nil];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:UPDATEACCOUNT
                                                                     AndRequestBody:data
                                                                  AndHttpMethodType:HTTPPUT
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: addAnotherUserToAccount
 *
 * DESCRIPTION: requests to add another user(given userId) to given accountId, setting admin based on passed bool value on isAdmin
 *
 * RETURNS: true/false
 *
 * PARAMETERS : 1)accountId
                2)inviteeUserId
                3)isAdmin
 **************************************************************************************************************************/
-(CloudResponse *) addAnotherUserToAccount:(NSString*)accountId UserGettingInvited:(NSString*)inviteeUserId
                          Admin:(BOOL)isAdmin{
    if(!accountId || !inviteeUserId){
        NSLog(@"%@:AccountId and InviteeUserId mandatory",TAG);
        return false;
    }
    NSData *data = [self createBodyForAddingUserToAccount:accountId UserGettingInvited:inviteeUserId
                                                    Admin:isAdmin ];
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.addUserToAccount urlSlugValueList:[NSDictionary dictionaryWithObjectsAndKeys:accountId,DATAACCOUNTID,inviteeUserId,INVITEEUSERID, nil]];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:ADDUSERTOACCOUNT
                                                                     AndRequestBody:data
                                                                  AndHttpMethodType:HTTPPUT
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: deleteAnAccount
 *
 * DESCRIPTION: requests to delete an user
 *
 * RETURNS: true/false
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(CloudResponse *) deleteAnAccount{
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.deleteAccount urlSlugValueList:nil];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:DELETEACCOUNT
                                                                     AndRequestBody:nil
                                                                  AndHttpMethodType:HTTPDELETE
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
    
}
/***************************************************************************************************************************
 * FUNCTION NAME: createBodyForAddingUserToAccount
 *
 * DESCRIPTION: method to create http Body to add user to given account
 *
 * RETURNS: data stream of request body
 *
 * PARAMETERS : 1)accountId
                2)inviteeUserId
                3)isAdmin
 **************************************************************************************************************************/
-(NSData*) createBodyForAddingUserToAccount:(NSString*)accountId UserGettingInvited:(NSString*)inviteeUserId
                                      Admin:(BOOL)isAdmin{
    NSError *error;
    NSString *role = USER;
    if(isAdmin){
        role = ADMIN;
    }
    NSDictionary *accountsDictionaryWithRole = [NSDictionary dictionaryWithObjectsAndKeys:role,accountId, nil];
    return [NSJSONSerialization dataWithJSONObject:[NSDictionary dictionaryWithObjectsAndKeys:inviteeUserId,
                                                    ID,accountsDictionaryWithRole,ACCOUNTS,nil] options:NSJSONWritingPrettyPrinted error:&error];
    
    
}
/***************************************************************************************************************************
 * FUNCTION NAME: createBodyForAccountCreation
 *
 * DESCRIPTION: method to create http Body to create an account
 *
 * RETURNS: data stream of request body
 *
 * PARAMETERS : accountName
 **************************************************************************************************************************/
-(NSData*) createBodyForAccountCreation:(NSString*)accountName {
    NSError *error;
    return [NSJSONSerialization dataWithJSONObject:[NSDictionary dictionaryWithObjectsAndKeys:accountName,
                                                    NAME,nil] options:NSJSONWritingPrettyPrinted error:&error];
}
/***************************************************************************************************************************
 * FUNCTION NAME: createBodyForAccountUpdation
 *
 * DESCRIPTION: method to create http Body to update an account
 *
 * RETURNS: data stream of request body
 *
 * PARAMETERS : 1)accountName
                2)attributes
 **************************************************************************************************************************/
-(NSData*) createBodyForAccountUpdation:(NSString*)accountNameToUpdate
andOptionalAttributesWithSimpleKeyValues:(NSDictionary*)attributes {
    NSError *error;
    NSMutableDictionary *jsonDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           accountNameToUpdate,NAME,self.getAccountId,ID,[NSNumber numberWithInt:HEALTHTIMEPERIODVALUE],HEALTHTIMEPERIOD,[NSNumber numberWithInt:EXECINTERVALVALUE],EXECINTERVAL,[NSNumber numberWithInt:BASELINEEXECINTERVALVALUE],BASELINEEXECINTERVAL,[NSNumber numberWithInt:CDMODELFREQUENCYVALUE],CDMODELFREQUENCY,[NSNumber numberWithInt:CDEXECUTIONFREQUENCYVALUE],CDEXECUTIONFREQUENCY,[NSNumber numberWithInt:DATARETENTIONVALUE],DATARETENTION,nil];
    if(attributes){
        [jsonDictionary setObject:attributes forKey:ATTRIBUTES];
    }
    
    return [NSJSONSerialization dataWithJSONObject:jsonDictionary options:NSJSONWritingPrettyPrinted error:&error];
    
}

@end
