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

#import "InvitationManagement.h"
#import "HttpResponseMacros.h"
#import "HttpRequestOperation.h"

#define TAG @"InvitationManagement"

@implementation InvitationManagement
/***************************************************************************************************************************
 * FUNCTION NAME: getListOfInvitation
 *
 * DESCRIPTION: requests list of invitations
 *
 * RETURNS: true/false
 *
 * PARAMETERS : nil **************************************************************************************************************************/
-(BOOL) getListOfInvitation{
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.getInvitationList urlSlugValueList:nil];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:GETINVITATIONLIST
                                                                     AndRequestBody:nil
                                                                  AndHttpMethodType:HTTPGET
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: getInvitationListSendToSpecificUser
 *
 * DESCRIPTION: requests list of invitations send to specific user
 *
 * RETURNS: true/false
 *
 * PARAMETERS : emailId **************************************************************************************************************************/
-(BOOL) getInvitationListSendToSpecificUser:(NSString*)emailId{
    if(!emailId){
        NSLog(@"%@:email Id cannot be null",TAG);
        return false;
    }
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.getInvitationListSendToSpecificUser urlSlugValueList:[NSDictionary dictionaryWithObject:emailId
                                                                                         forKey:EMAIL]];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:GETINVITATIONLISTSENDTOSPECIFICUSER
                                                                     AndRequestBody:nil
                                                                  AndHttpMethodType:HTTPGET
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: createInvitationTo
 *
 * DESCRIPTION: requests to create invitation for given mailId
 *
 * RETURNS: true/false
 *
 * PARAMETERS :mailId **************************************************************************************************************************/
-(BOOL) createInvitationTo:(NSString *)emailId{
    if(!emailId){
        NSLog(@"%@:email Id cannot be null",TAG);
        return false;
    }
    NSData *data = [self createHttpBodyToCreateInvitation:emailId];
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.createInvitation urlSlugValueList:nil];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:CREATEINVITATION
                                                                     AndRequestBody:data
                                                                  AndHttpMethodType:HTTPPOST
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: deleteInvitationsTo
 *
 * DESCRIPTION: requests to delete Invitations to mailId
 *
 * RETURNS: true/false
 *
 * PARAMETERS : mail Id **************************************************************************************************************************/
-(BOOL) deleteInvitationsTo:(NSString*)emailId{
    if(!emailId){
        NSLog(@"%@:email Id cannot be null",TAG);
        return false;
    }
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.deleteInvitations urlSlugValueList:[NSDictionary dictionaryWithObject:emailId
                                                                                                                                                                             forKey:EMAIL]];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:DELETEINVITATIONS
                                                                     AndRequestBody:nil
                                                                  AndHttpMethodType:HTTPDELETE
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
-(NSData*)createHttpBodyToCreateInvitation:(NSString*)emailId{
    NSDictionary *createInvitationJson = [NSDictionary dictionaryWithObjectsAndKeys:emailId,EMAIL,nil];
    NSError *error;
    return [NSJSONSerialization dataWithJSONObject:createInvitationJson options:NSJSONWritingPrettyPrinted
                                             error:&error];
}
@end
