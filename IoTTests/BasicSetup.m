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


#import "BasicSetup.h"
#import "IoTKitLib/HttpResponseDelegatee.h"
#define RANDOM_RANGE_MAX 10000
#define RANDOM_RANGE_MAX_READING 100

@interface BasicSetup ()

@property(nonatomic,assign)NSInteger expectedResponseCode;
@property(nonatomic,assign)NSInteger serverResponseCode;
@property(nonatomic,assign)BOOL isServerResponded;
@property(nonatomic,retain)NSString* serverResponseContent;
@property(nonatomic,retain)HttpResponseDelegatee *responseDelegate;

@end

@implementation BasicSetup

/***************************************************************************************************************************
 * FUNCTION NAME: waitForServerResponse
 *
 * DESCRIPTION: method waits(UI thread) in active loop until server responsds for given request
 *
 * RETURNS: nothing
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(void)waitForServerResponse{
    @synchronized(self){
        while(!_isServerResponded){}
        _isServerResponded = false;
        XCTAssertEqual(_expectedResponseCode, _serverResponseCode,@"Server Response:%@", _serverResponseContent);
    }
}

/***************************************************************************************************************************
 * FUNCTION NAME: notifyServerResponse
 *
 * DESCRIPTION: method which notifies(updates _isServerResponded flag) when server responsds
 *
 * RETURNS: nothing
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(void)notifyServerResponse{
    _isServerResponded = true;
    CFRunLoopStop(CFRunLoopGetCurrent());
}

/***************************************************************************************************************************
 * FUNCTION NAME: setUp
 *
 * DESCRIPTION: method gets called before test case gets called
 *
 * RETURNS: nothing
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
- (void)setUp {
    [super setUp];
    _isServerResponded = false;
    _responseDelegate = [HttpResponseDelegatee sharedInstance];
}

/***************************************************************************************************************************
 * FUNCTION NAME: tearDown
 *
 * DESCRIPTION: method gets called at the end of test case
 *
 * RETURNS: nothing
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
- (void)tearDown {
    [super tearDown];
}

/***************************************************************************************************************************
 * FUNCTION NAME: configureResponseDelegateWithExpectedResponseCode
 *
 * DESCRIPTION: method creates delegate receive server responses
 *
 * RETURNS: nothing
 *
 * PARAMETERS : expected response code
 **************************************************************************************************************************/
-(void)configureResponseDelegateWithExpectedResponseCode:(NSInteger)expectedResponseCode{
    __block BasicSetup *blockTest = self;
    __block HttpResponseDelegatee *blockResponseDelegate = _responseDelegate;
    blockResponseDelegate.cloudResponse = ^(NSInteger responseCode, NSString* responseContent)
    {
        _expectedResponseCode = expectedResponseCode;
        _serverResponseCode = responseCode;
        _serverResponseContent = responseContent;
        [blockTest notifyServerResponse];
    };
}

/***************************************************************************************************************************
 * FUNCTION NAME: getRandomValueString
 *
 * DESCRIPTION: method generate random value from 0 to RANDOM_RANGE_MAX
 *
 * RETURNS: random value
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(NSString*)getRandomValueString{
    NSInteger randomValue =  arc4random() % RANDOM_RANGE_MAX;
    return [NSString stringWithFormat:@"%ld",(long)randomValue];
}

/***************************************************************************************************************************
 * FUNCTION NAME: getRandomValue
 *
 * DESCRIPTION: method generate random value from 0 to RANDOM_RANGE_MAX_READING
 *
 * RETURNS: random value
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(NSString*)getRandomValue{
    NSInteger randomValue =  arc4random() % RANDOM_RANGE_MAX_READING;
    return [NSString stringWithFormat:@"%ld",(long)randomValue];
}

/***************************************************************************************************************************
 * FUNCTION NAME: getRandomAccountName
 *
 * DESCRIPTION: method creates random account name
 *
 * RETURNS: account name
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(NSString*)getRandomAccountName{
    return [@"DemoIoT" stringByAppendingString:[self getRandomValueString]];
}

/***************************************************************************************************************************
 * FUNCTION NAME: getRandomDeviceName
 *
 * DESCRIPTION: method creates random device name
 *
 * RETURNS: device name
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(NSString*)getRandomDeviceName{
    return [@"DemoIoTDevice" stringByAppendingString:[self getRandomValueString]];
}

/***************************************************************************************************************************
 * FUNCTION NAME: getRandomDeviceId
 *
 * DESCRIPTION: method creates random device id
 *
 * RETURNS: deviceId
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(NSString*)getRandomDeviceId{
    return [@"DemoIoTDevId" stringByAppendingString:[self getRandomValueString]];
}

/***************************************************************************************************************************
 * FUNCTION NAME: getRandomDeviceComponentName
 *
 * DESCRIPTION: method creates random device component name
 *
 * RETURNS: device component name
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(NSString*)getRandomDeviceComponentName{
    return [@"DeviceDemoComponent" stringByAppendingString:[self getRandomValueString]];
}

/***************************************************************************************************************************
 * FUNCTION NAME: getRandomCustomComponentName
 *
 * DESCRIPTION: method creates random component Name
 *
 * RETURNS: component name
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(NSString*)getRandomCustomComponentName{
    NSString *demoComponentName;
    demoComponentName =  [@"DemoComponent" stringByAppendingString:[self getRandomValueString]];
    [[NSUserDefaults standardUserDefaults] setObject:demoComponentName forKey:@"DemoComponent"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return demoComponentName;
}

/***************************************************************************************************************************
 * FUNCTION NAME: getCustomComponentName
 *
 * DESCRIPTION: method to get created component name from defaults,used only for unit testing
 *
 * RETURNS: component name
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(NSString*)getCustomComponentName{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"DemoComponent"];
}

/***************************************************************************************************************************
 * FUNCTION NAME: getRandomRuleName
 *
 * DESCRIPTION: method creates random rule Name
 *
 * RETURNS: rule Name
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(NSString*)getRandomRuleName{
    NSString *demoRuleName = [@"DemoIoTRule" stringByAppendingString:[self getRandomValueString]];
    [[NSUserDefaults standardUserDefaults] setObject:demoRuleName forKey:@"DemoIoTRule"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return demoRuleName;
}

/***************************************************************************************************************************
 * FUNCTION NAME: getCurrentTimeInMillis
 *
 * DESCRIPTION: method to get current time in millis
 *
 * RETURNS: millis second time
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(double)getCurrentTimeInMillis{
    return [[NSDate date] timeIntervalSince1970] * 1000;
}

/***************************************************************************************************************************
 * FUNCTION NAME: getRandomAlertId
 *
 * DESCRIPTION: method creates random alertId
 *
 * RETURNS: alertId
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(NSInteger)getRandomAlertId{
    NSInteger alertId = [[self getRandomValueString] integerValue];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",alertId] forKey:@"alert_Id"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return alertId;
}
@end
