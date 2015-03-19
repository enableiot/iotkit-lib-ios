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

#import <Foundation/Foundation.h>
#import "HttpResponseDelegateHandler.h"
#import "CloudResponse.h"

@interface HttpRequestOperation:NSObject

@property (nonatomic,weak) id<HttpResponseDelegateHandler> httpDelegate;

-(id)initWithUrl:(NSString*)url onOperation:(NSInteger)operationName AndRequestBody:(NSData*)requestBody
                            AndHttpMethodType:(NSString*)httpMethod AndContentType:(NSString*)contentType
                            AuthToken:(NSString*)authToken DeviceToken:(NSString*)deviceToken;
- (id) init __attribute__((unavailable("Must create object using \"initWithUrl\" method")));
- (CloudResponse *)completeHandler:(NSURLResponse *)response onData:(NSData *)data AndError:(NSError *)error;
- (CloudResponse *)initiateAsyncRequest ;
- (CloudResponse *)initiateSyncRequest ;
@end
