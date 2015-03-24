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

#ifndef IoT_Device_h
#define IoT_Device_h

/*!
 * @brief The Device object that encapsulated information about the device
 */
@interface Device : NSObject

-(id) init __attribute__((unavailable("Must create object using \"Device\" method")));

/*!
 * Creates custom instance of the class Device
 * @return an instance of the class Device
 * @param deviceName the device name
 * @param deviceId the device identifier
 * @param gatewayId the gateway identifier
 */
+(id)createDeviceWithDeviceName:(NSString*)deviceName andDeviceId:(NSString*) deviceId andGatewayId:(NSString*) gatewayId;

/*!
 * Adds location info of device using lat,long&height
 * @param latitude the current latitude where the device is located
 * @param longitude the current longitude where the device is located
 * @param height the current height of the device
 */
-(void)addLocationInfo:(double)latitude AndLongitude:(double) longitude ANdHeight:(double) height;

/*!
 * Adds tag name to list of tags
 * @param tagName the tag name to be associated with the device
 */
-(void)addTagName:(NSString*)tagName ;

/*!
 * Adds attribute name-value pair to attribute list
 * @param attributeName the name of the attribute to be associated with the device
 * @param attributeValue the value of the attribute to be associated with the device
 */
-(void)addAttributeName:(NSString*)attributeName  andValue:(NSString*)attributeValue;


@end

#endif
