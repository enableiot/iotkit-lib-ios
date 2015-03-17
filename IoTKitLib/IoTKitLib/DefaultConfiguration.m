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

#import "DefaultConfiguration.h"
#define TAG @"DefaultConfiguration"

@implementation DefaultConfiguration
/***************************************************************************************************************************
 * FUNCTION NAME: init
 *
 * DESCRIPTION: Creates instance of the class
 *
 * RETURNS: instance of the class DefaultConfiguration
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
- (id)init
{
    self = [super init];
    if (self) {
        //basic setup needed for http request
        self.objHttpUrlBuilder = [HttpUrlBuilder sharedInstance];
        self.objHttpResponseDelegatee = [HttpResponseDelegatee sharedInstance];
        //assert method
        [self validateBasicObjects];
    }
    return self;
}
/***************************************************************************************************************************
 * FUNCTION NAME: dealloc
 *
 * DESCRIPTION: method called before release object memory
 *
 * RETURNS: nothing
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(void)dealloc{
    
    NSLog(@"%@:dealloc  called in parent",TAG);
    
}
/***************************************************************************************************************************
 * FUNCTION NAME: validateBasicObjects
 *
 * DESCRIPTION: method validates object allocations
 *
 * RETURNS: nothing
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(void) validateBasicObjects{
    assert(self.objHttpUrlBuilder);
    assert(self.objHttpResponseDelegatee);
}

/***************************************************************************************************************************
 * FUNCTION NAME: initiateHttpOperation
 *
 * DESCRIPTION: method which initiates operation on secondary thread
 *
 * RETURNS: true/false
 *
 * PARAMETERS : httpOperation Object
 **************************************************************************************************************************/
-(BOOL)initiateHttpOperation:(HttpRequestOperation*)httpOperation{
    [httpOperation setHttpDelegate:(id)self.objHttpResponseDelegatee];

    if([httpOperation initiateAsyncRequest]){
        return true;
    }
    else{
        return false;
    }
}

/***************************************************************************************************************************
 * FUNCTION NAME: getStoredAuthToken
 *
 * DESCRIPTION: gets auth token from defaults
 *
 * RETURNS: auth token
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(NSString*)getStoredAuthToken{
    return [HttpUrlBuilder createBasicHeadersWithBearerAuthToken];
}
/***************************************************************************************************************************
 * FUNCTION NAME: getStoredDeviceToken
 *
 * DESCRIPTION: gets device token from defaults
 *
 * RETURNS: device token
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(NSString*)getStoredDeviceToken{
    return [HttpUrlBuilder createBasicHeadersWithBearerDeviceToken];
}
/***************************************************************************************************************************
 * FUNCTION NAME: getAccountId
 *
 * DESCRIPTION: gets accountId from defaults
 *
 * RETURNS: accountId
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(NSString*)getAccountId{
    return [HttpUrlBuilder getAccountId];
}
/***************************************************************************************************************************
 * FUNCTION NAME: getComponentId
 *
 * DESCRIPTION: gets componentId from defaults on given name
 *
 * RETURNS: componentId
 *
 * PARAMETERS : componentName
 **************************************************************************************************************************/
-(NSString*)getComponentId:(NSString*)componentName{
    return [HttpUrlBuilder getComponentId:componentName];
}
/***************************************************************************************************************************
 * FUNCTION NAME: getDeviceId
 *
 * DESCRIPTION: gets deviceId from defaults
 *
 * RETURNS: deviceId
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(NSString*)getDeviceId{
    return [HttpUrlBuilder getDeviceId];
}
/***************************************************************************************************************************
 * FUNCTION NAME: getUserId
 *
 * DESCRIPTION: gets userId from defaults
 *
 * RETURNS: userId
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(NSString*)getUserId{
    return [HttpUrlBuilder getUserId];
}
/***************************************************************************************************************************
 * FUNCTION NAME: getCurrentTimeInMillis
 *
 * DESCRIPTION: calculates current time in millis
 *
 * RETURNS: current time
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(double)getCurrentTimeInMillis{
    return [[NSDate date] timeIntervalSince1970] * 1000;
}
@end
