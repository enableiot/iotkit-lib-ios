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

#define TAG @"AlertManagement"


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
-(CloudResponse *)getListOfAlerts{
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
-(CloudResponse *)getInfoOnAlert:(NSString *)alertId{
    if(!alertId){
        return [CloudResponse createCloudResponseWithStatus:false andMessage:[NSString stringWithFormat:@"%@:Alert ID cannot be null",TAG]];
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
-(CloudResponse *)resetAlert:(NSString *)alertId{
    if(!alertId){
        return [CloudResponse createCloudResponseWithStatus:false andMessage:[NSString stringWithFormat:@"%@:Alert ID cannot be null",TAG]];
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
-(CloudResponse *)updateAlertStatus:(NSString *)alertId WithStatus:(NSString *)status{
    if(!alertId || !status){
        return [CloudResponse createCloudResponseWithStatus:false andMessage:[NSString stringWithFormat:@"%@:Alert ID or status cannot be null",TAG]];
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
-(CloudResponse *)addCommentsToTheAlert:(NSString *)alertId OnUser:(NSString *)user AtTime:(long)timeStamp
                 WithComment:(NSString *)comment{
    if(!alertId || !user || !comment){
        return [CloudResponse createCloudResponseWithStatus:false andMessage:[NSString stringWithFormat:@"%@:Alert ID or user or comment cannot be null",TAG]];
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
