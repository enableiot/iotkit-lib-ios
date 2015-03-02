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

#import "HttpRequestOperation.h"


#define TAG @"HttpRequestOperation"
#define CONTENTTYPE @"Content-Type"
#define CONTENTLENGTH @"Content-Length"
#define AUTHORIZATION @"Authorization"

@interface HttpRequestOperation()
{
    NSString *responseString;
    NSInteger responseCode;
    
}
@property(nonatomic,retain) NSString* url;
@property(nonatomic,retain) NSString *httpMethod;
@property(nonatomic,retain) NSString *contentType;
@property(nonatomic,retain) NSData *requestBody;
@property(nonatomic,retain) NSURLConnection *urlConnection;
@property(nonatomic,retain) NSMutableData *responseData;
@property(nonatomic,assign) NSInteger operationName;
@property(nonatomic,retain) NSString *authToken;
@property(nonatomic,retain) NSString *deviceToken;


@end

@implementation HttpRequestOperation

/***************************************************************************************************************************
 * FUNCTION NAME: initWithUrl
 *
 * DESCRIPTION:creates Http Request object to IoT server
 *
 * RETURNS: HttpRequestOperation object
 *
 * PARAMETERS : 1)Http url
                2)Http operationName
                3)Http requestBody
                4)Http method
                5)Http contentType
                6)Http authToken
                7)Http deviceToken
 
 **************************************************************************************************************************/
-(id)initWithUrl:(NSString*)url onOperation:(NSInteger)operationName AndRequestBody:(NSData*)requestBody
AndHttpMethodType:(NSString*)httpMethod AndContentType:(NSString*)contentType
       AuthToken:(NSString*)authToken DeviceToken:(NSString*)deviceToken{
    self = [super init];
    if(self){
        self.url = url;
        self.requestBody = requestBody;
        self.httpMethod = httpMethod;
        self.contentType = contentType;
        self.operationName = operationName;
        self.authToken = authToken;
        self.deviceToken = deviceToken;
    }
    return self;
}
/***************************************************************************************************************************
 * FUNCTION NAME: initiateRequest
 *
 * DESCRIPTION:initiates Http Request to IoT server
 *
 * RETURNS:true/false
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
- (BOOL)initiateRequest {
    // Do the main work of the operation here.
    if(!_url || !_httpMethod || !_contentType || _operationName <= 0){
        NSLog(@"%@:url/http method/content type/operation name cannot be empty",TAG);
        return false;
    }
    NSMutableURLRequest *requestUrl = nil;
    requestUrl = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_url]];
    [requestUrl setHTTPMethod :_httpMethod];
    [requestUrl setValue:_contentType forHTTPHeaderField:CONTENTTYPE];
    //gets auth/device token based on existence
    NSString *token = [self getHeaderToken];
    if(token){
        [requestUrl setValue:token forHTTPHeaderField:AUTHORIZATION];
    }
    
    [requestUrl setValue: [NSString stringWithFormat:@"%lu", (unsigned long)[_requestBody length]] forHTTPHeaderField : CONTENTLENGTH];
    [requestUrl setHTTPBody : _requestBody];
    
    //initiate url connection
    _urlConnection = [[NSURLConnection alloc] initWithRequest:requestUrl
                                                     delegate:self startImmediately:YES];
    if(!_urlConnection){
        NSLog(@"%@:not able to create url connection",TAG);
        return false;
    }
    NSLog(@"%@:Url connection success:%@",TAG,_urlConnection);
    return true;
    
}
/***************************************************************************************************************************
 * FUNCTION NAME: didReceiveResponse
 *
 * DESCRIPTION:delegate method gets called when server responds
 *
 * RETURNS:nothing
 *
 * PARAMETERS : 1)connection object
                2)response object
 **************************************************************************************************************************/
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _responseData = [NSMutableData data];
    [_responseData setLength:0];
    responseCode = ((NSHTTPURLResponse*)response).statusCode;
}
/***************************************************************************************************************************
 * FUNCTION NAME: didReceiveData
 *
 * DESCRIPTION:delegate method gets called multiple times to collect data
 *
 * RETURNS:nothing
 *
 * PARAMETERS : 1)connection object
                2)data object
 **************************************************************************************************************************/
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_responseData appendData:data];
}
/***************************************************************************************************************************
 * FUNCTION NAME: didFailWithError
 *
 * DESCRIPTION:delegate method gets called when server/network error comes
 *
 * RETURNS:nothing
 *
 * PARAMETERS : 1)connection object
                2)error object
 **************************************************************************************************************************/
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    responseCode = [error code];
    responseString = [error localizedDescription];
    NSLog(@"%@:ERROR:: %@", TAG,responseString);
    NSLog(@"%@:ERROR code %ld",TAG,(long)responseCode);
    [self.httpDelegate cloudResponseOnOperation:_operationName WithCode:responseCode response:responseString];
}
/***************************************************************************************************************************
 * FUNCTION NAME: connectionDidFinishLoading
 *
 * DESCRIPTION:delegate method gets called after collecting all data
 *
 * RETURNS:nothing
 *
 * PARAMETERS : 1)connection object
 **************************************************************************************************************************/
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if(_responseData && _responseData.length){
        responseString = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
    }
    else{
        NSLog(@"%@:empty data from server",TAG);
        responseString = @"empty data from server";
        
    }
    [self.httpDelegate cloudResponseOnOperation:_operationName WithCode:responseCode response:responseString];
    
}
/***************************************************************************************************************************
 * FUNCTION NAME: getHeaderToken
 *
 * DESCRIPTION:gets auth/device token
 *
 * RETURNS:auth or device token
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(NSString*)getHeaderToken{
    NSString *token = nil;
    if(_authToken && _deviceToken){
        NSLog(@"%@:auth token && dev token cannot be supplied",TAG);
    }
    else if(_authToken){
        token = _authToken;
    }else if (_deviceToken){
        token = _deviceToken;
    }else{
        NSLog(@"%@:token not supplied for this request",TAG);
    }
    return token;
}



@end
