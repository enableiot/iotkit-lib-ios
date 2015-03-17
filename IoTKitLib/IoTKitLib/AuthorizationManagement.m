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

#import "AuthorizationManagement.h"
#import "HttpRequestOperation.h"
#import "HttpResponseMacros.h"

#define USERNAME @"username"
#define PASSWORD @"password"
#define TAG @"AuthorizationManagement"

@implementation AuthorizationManagement

/***************************************************************************************************************************
 * FUNCTION NAME: getNewAuthorizationToken
 *
 * DESCRIPTION: requests to get new auth-token using given username&password
 *
 * RETURNS: true/false
 *
 * PARAMETERS : 1)userName
                2)password
 **************************************************************************************************************************/
-(CloudResponse *) getNewAuthorizationTokenWithUsername:(NSString*)username andPassword:(NSString*)password{
    if(!username || !password){
        NSLog(@"%@:username or password cannot be nil",TAG);
        return false;
    }
    //creating http body
    NSData *data = [self createBodyForNewAuthTokenRequestWithUsername:username andPassword:password];
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.theNewAuthToken urlSlugValueList:nil];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:NEWAUTHTOKEN
                                                                     AndRequestBody:data
                                                                  AndHttpMethodType:HTTPPOST
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:nil
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: getAuthorizationTokenInfo
 *
 * DESCRIPTION: requests to get token related info
 *
 * RETURNS: true/false
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(CloudResponse *) getAuthorizationTokenInfo{
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.authTokenInfo urlSlugValueList:nil];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:GETAUTHTOKENINFO
                                                                     AndRequestBody:nil
                                                                  AndHttpMethodType:HTTPGET
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: validateAuthorizationToken
 *
 * DESCRIPTION: requests to validate auth token
 *
 * RETURNS: true/false
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(CloudResponse *) validateAuthorizationToken{
    NSString *url = [self.objHttpUrlBuilder prepareUrlByAppendingUrl:self.objHttpUrlBuilder.authTokenInfo urlSlugValueList:nil];
    HttpRequestOperation *httpOperation = [[HttpRequestOperation alloc] initWithUrl:url
                                                                        onOperation:VALIDATEAUTHTOKEN
                                                                     AndRequestBody:nil
                                                                  AndHttpMethodType:HTTPGET
                                                                     AndContentType:CONTENTTYPEJSON
                                                                          AuthToken:self.getStoredAuthToken
                                                                        DeviceToken:nil];
    return [self initiateHttpOperation:httpOperation];
}
/***************************************************************************************************************************
 * FUNCTION NAME: createBodyForNewAuthTokenRequestWithUsername
 *
 * DESCRIPTION: method to create http Body to get new auth token
 *
 * RETURNS: data stream of request body
 *
 * PARAMETERS : 1)username
                2)password
 **************************************************************************************************************************/
-(NSData*) createBodyForNewAuthTokenRequestWithUsername:(NSString*)username andPassword:(NSString*)password {
    NSError *error;
    return [NSJSONSerialization dataWithJSONObject:[NSDictionary dictionaryWithObjectsAndKeys:username,
                                                    USERNAME,password,PASSWORD, nil] options:NSJSONWritingPrettyPrinted error:&error];
}

@end

