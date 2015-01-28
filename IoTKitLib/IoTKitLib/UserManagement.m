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

#import "UserManagement.h"
#import "HttpRequestOperation.h"
#import "HttpResponseMacros.h"

#define TAG @"UserManagement"
#define PASSWORD @"password"
#define TERMSANDCONDITIONS @"termsAndConditions"
#define CURRENTPASSWORD @"currentpwd"


@implementation UserManagement
/***************************************************************************************************************************
 * FUNCTION NAME: createNewUserWith
 *
 * DESCRIPTION: requests to create new user with given mailID&password
 *
 * RETURNS: true/false
 *
 * PARAMETERS : 1)mailId
                2)password
 **************************************************************************************************************************/
-(BOOL) createNewUserWith:(NSString*)emailId AndPassword:(NSString*)password{
    NSData *data = [self validateAndCreateHttpBodyForNewUser:emailId AndPassword:password];
    if(!data){
        return false;
    }
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.createUser urlSlugValueList:nil];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:CREATEUSER
                                                                     AndRequestBody:data
                                                                  AndHttpMethodType:HTTPPOST
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:nil
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: deleteUser
 *
 * DESCRIPTION: requests to delete user with userId
 *
 * RETURNS: true/false
 *
 * PARAMETERS : userId **************************************************************************************************************************/
-(BOOL) deleteUser:(NSString*)userId{
    NSString *tempUserId = [self validateAndGetUserId:userId];
    if(!tempUserId){
        NSLog(@"%@:userID empty and cannot find from user defaults",TAG);
        return false;
    }
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.deleteUser urlSlugValueList:[NSDictionary dictionaryWithObjectsAndKeys:tempUserId,CONFIGUSERID,nil]];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:DELETEUSER
                                                                     AndRequestBody:nil
                                                                  AndHttpMethodType:HTTPDELETE
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: getUserInfo
 *
 * DESCRIPTION: requests to get user info on userId
 *
 * RETURNS: true/false
 *
 * PARAMETERS : userId **************************************************************************************************************************/
-(BOOL) getUserInfo:(NSString*)userId{
    NSString *tempUserId = [self validateAndGetUserId:userId];
    if(!tempUserId){
        NSLog(@"%@:userID empty and cannot find from user defaults",TAG);
        return false;
    }
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.getUserInfo urlSlugValueList:[NSDictionary dictionaryWithObjectsAndKeys:tempUserId,CONFIGUSERID,nil]];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:GETUSERINFO
                                                                     AndRequestBody:nil
                                                                  AndHttpMethodType:HTTPGET
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: updateUserAttributesOn
 *
 * DESCRIPTION: requests to update User attributes on given userId with given attributes
 *
 * RETURNS: true/false
 *
 * PARAMETERS : 1)userId
                2)listOfUserAttributes
 **************************************************************************************************************************/
-(BOOL) updateUserAttributesOn:(NSString*) userId AndListOfAttributes:(NSDictionary*)listOfUserAttributes{
    NSString *tempUserId = [self validateAndGetUserId:userId];
    if(!tempUserId){
        NSLog(@"%@:userID empty and cannot find from user defaults",TAG);
        return false;
    }
    if(!listOfUserAttributes || ![listOfUserAttributes count]){
        NSLog(@"%@:user Attributes cannot be empty",TAG);
        return false;
    }
    NSData *data = [self createBodyForUserAttributesUpdation:tempUserId AndListOfAttributes:listOfUserAttributes];
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.updateUserAttributes urlSlugValueList:[NSDictionary dictionaryWithObjectsAndKeys:tempUserId,CONFIGUSERID,nil]];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:UPDATEUSERATTRIBUTES
                                                                     AndRequestBody:data
                                                                  AndHttpMethodType:HTTPPUT
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: acceptTermsAndConditionsOn
 *
 * DESCRIPTION: requests to accept/dont accept terms and conditions on given userId
 *
 * RETURNS: true/false
 *
 * PARAMETERS : 1)userId
                2)isAccepted(true/false)
 **************************************************************************************************************************/
-(BOOL) acceptTermsAndConditionsOn:(NSString*)userId Acceptance:(BOOL)isAccepted{
    NSString *tempUserId = [self validateAndGetUserId:userId];
    if(!tempUserId){
        NSLog(@"%@:userID empty and cannot find from user defaults",TAG);
        return false;
    }
    NSData *data = [self createBodyForTermsAndConditionsAcceptance:userId Acceptance:isAccepted];
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.acceptTermsAndConditions urlSlugValueList:[NSDictionary dictionaryWithObjectsAndKeys:tempUserId,CONFIGUSERID,nil]];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:ACCEPTTERMSANDCONDITIONS
                                                                     AndRequestBody:data
                                                                  AndHttpMethodType:HTTPPUT
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: requestChangePasswordOn
 *
 * DESCRIPTION: requests to change password on mailId
 *
 * RETURNS: true/false
 *
 * PARAMETERS : mail Id **************************************************************************************************************************/
-(BOOL) requestChangePasswordOn:(NSString*)emailId{
    if(!emailId){
        NSLog(@"%@:email Id cannot be empty",TAG);
        return false;
    }
    NSData *data = [self createBodyForRequestingChangePassword:emailId];
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.requestChangePassword urlSlugValueList:nil];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:REQUESTCHANGEPASSWORD
                                                                     AndRequestBody:data
                                                                  AndHttpMethodType:HTTPPOST
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: updateForgotPassword
 *
 * DESCRIPTION: requests to update forgotten password using token & new password
 *
 * RETURNS: true/false
 *
 * PARAMETERS : 1)mailToken
                2)newPassword
 **************************************************************************************************************************/
-(BOOL) updateForgotPassword:(NSString*)mailToken AndNewPassword:(NSString*)newPassword{
    if(!mailToken || !newPassword){
        NSLog(@"%@:neither token nor newPassword cannot be empty",TAG);
        return false;
    }
    NSData *data = [self createBodyForUpdatingForgotPassword:mailToken AndNewPassword:newPassword];
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.requestChangePassword urlSlugValueList:nil];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:UPDATEFORGOTPASSWORD
                                                                     AndRequestBody:data
                                                                  AndHttpMethodType:HTTPPUT
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];

}
/***************************************************************************************************************************
 * FUNCTION NAME: changePasswordOn
 *
 * DESCRIPTION: requests to change password for the mailId(user) with current & new passwords
 *
 * RETURNS: true/false
 *
 * PARAMETERS : 1)mail Id
                2)currentPassword
                3)newPassword
 **************************************************************************************************************************/
-(BOOL) changePasswordOn:(NSString*)emailId AndCurrentPassword:(NSString*)currentPassword
          AndNewPassword:(NSString*)newPassword{
    if(!emailId || !currentPassword || !newPassword){
        NSLog(@"%@:email or currentPassword or newPassword cannot be empty",TAG);
        return false;
    }
    NSData *data = [self createBodyForChangePassword:currentPassword AndNewPassword:newPassword];
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.changePassword urlSlugValueList:[NSDictionary dictionaryWithObjectsAndKeys:emailId,EMAIL,nil]];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:CHANGEPASSWORD
                                                                     AndRequestBody:data
                                                                  AndHttpMethodType:HTTPPUT
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: createHttpBodyToCreateInvitation
 *
 * DESCRIPTION: method to create http Body to create invitation
 *
 * RETURNS: data stream of request body
 *
 * PARAMETERS : emailId
 **************************************************************************************************************************/
-(NSData*)createBodyForChangePassword:(NSString*)currentPassword AndNewPassword:(NSString*)newPassword{
    NSDictionary *changePasswordJson = [NSDictionary dictionaryWithObjectsAndKeys:currentPassword,CURRENTPASSWORD,newPassword,PASSWORD,nil];
    NSError *error;
    return [NSJSONSerialization dataWithJSONObject:changePasswordJson options:NSJSONWritingPrettyPrinted
                                             error:&error];
}
/***************************************************************************************************************************
 * FUNCTION NAME: createBodyForUpdatingForgotPassword
 *
 * DESCRIPTION: method to create http Body to update forgotten password
 *
 * RETURNS: data stream of request body
 *
 * PARAMETERS : 1)mailToken
                2)newPassword
 **************************************************************************************************************************/
-(NSData*)createBodyForUpdatingForgotPassword:(NSString*)mailToken AndNewPassword:(NSString*)newPassword{
    NSDictionary *updateForgotPasswordJson = [NSDictionary dictionaryWithObjectsAndKeys:mailToken,TOKEN,newPassword,PASSWORD,nil];
    NSError *error;
    return [NSJSONSerialization dataWithJSONObject:updateForgotPasswordJson options:NSJSONWritingPrettyPrinted
                                             error:&error];
}
/***************************************************************************************************************************
 * FUNCTION NAME: createBodyForRequestingChangePassword
 *
 * DESCRIPTION: method to create http Body to request changePassword
 *
 * RETURNS: data stream of request body
 *
 * PARAMETERS : emailId
 **************************************************************************************************************************/
-(NSData*)createBodyForRequestingChangePassword:(NSString*)emailId{
   NSDictionary *changePasswordJson = [NSDictionary dictionaryWithObjectsAndKeys:emailId,EMAIL,nil];
    NSError *error;
    return [NSJSONSerialization dataWithJSONObject:changePasswordJson options:NSJSONWritingPrettyPrinted
                                             error:&error];
}
/***************************************************************************************************************************
 * FUNCTION NAME: createBodyForTermsAndConditionsAcceptance
 *
 * DESCRIPTION: method to create http Body to accpet terms&conditions
 *
 * RETURNS: data stream of request body
 *
 * PARAMETERS : 1)userId
                2)isAccepted(true/false)
 **************************************************************************************************************************/
-(NSData*)createBodyForTermsAndConditionsAcceptance:(NSString*)userId Acceptance:(BOOL)isAccepted{
    NSDictionary *termsAndConditionsJson = [NSDictionary dictionaryWithObjectsAndKeys:userId,ID,[NSNumber numberWithBool:isAccepted],TERMSANDCONDITIONS,nil];
    NSError *error;
    return [NSJSONSerialization dataWithJSONObject:termsAndConditionsJson options:NSJSONWritingPrettyPrinted
                                             error:&error];
}
/***************************************************************************************************************************
 * FUNCTION NAME: createBodyForUserAttributesUpdation
 *
 * DESCRIPTION: method to create http Body to update user attributes
 *
 * RETURNS: data stream of request body
 *
 * PARAMETERS : 1)userId
                2)listOfUserAttributes
 **************************************************************************************************************************/
-(NSData*)createBodyForUserAttributesUpdation:(NSString*) userId
                          AndListOfAttributes:(NSDictionary*)listOfUserAttributes{
    NSDictionary *userAttributeJson = [NSDictionary dictionaryWithObjectsAndKeys:userId,ID,listOfUserAttributes,ATTRIBUTES,nil];
    NSError *error;
    return [NSJSONSerialization dataWithJSONObject:userAttributeJson options:NSJSONWritingPrettyPrinted
                                             error:&error];
    
}
/***************************************************************************************************************************
 * FUNCTION NAME: validateAndCreateHttpBodyForNewUser
 *
 * DESCRIPTION: method to create http Body to create new user
 *
 * RETURNS: data stream of request body
 *
 * PARAMETERS : 1)mail Id
 2)password
 **************************************************************************************************************************/
-(NSData*)validateAndCreateHttpBodyForNewUser:(NSString*)emailId AndPassword:(NSString*)password{
    if(!emailId || !password){
        NSLog(@"%@:emailID and password are mandatory",TAG);
        return nil;
    }
    NSDictionary *newUserJson = [NSDictionary dictionaryWithObjectsAndKeys:emailId,EMAIL,password,PASSWORD,nil];
    NSError *error;
    return [NSJSONSerialization dataWithJSONObject:newUserJson options:NSJSONWritingPrettyPrinted error:&error];
}
/***************************************************************************************************************************
 * FUNCTION NAME: validateAndGetUserId
 *
 * DESCRIPTION: method to get check userId and get from defaults if not passed
 *
 * RETURNS: userId
 *
 * PARAMETERS : 1)userId provided/passed

 **************************************************************************************************************************/
-(NSString*)validateAndGetUserId:(NSString*)userIdProvided{
    NSString *tempUserId = userIdProvided;
    if(!tempUserId){
        tempUserId = [self getUserId];
    }
    return tempUserId;
}

@end
