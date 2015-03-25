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

#import "DefaultConfiguration.h"
#import "Device.h"

/*!
 * @brief The DeviceManagement object that is used to manage all aspects associated with devices
 */
@interface DeviceManagament : DefaultConfiguration

/*!
 * Get a list of all devices for the specified account, with minimal data for each device.
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 */
-(CloudResponse *) getDeviceList;

/*!
 * Create a new device with the device info.
 * @param deviceCreateObj the device info to create a new device with.
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 */
-(CloudResponse *) createNewDevice:(Device*) deviceCreateObj;

/*!
 * Update a single device. The device ID (deviceId) cannot be updated as it is the key.
 * If the device id does not exist, an error will be returned. The device id
 * that is used will be the current device that is cached usually after a create new device.
 * @param deviceUpdationObj the device info to update the device with.
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 */
-(CloudResponse *) updateADevice:(Device*)deviceUpdationObj;

/*!
 * Get full detail for newly created device for the specified account. The device id
 * that is used will be the current device that is cached usually after a create new device.
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 */
-(CloudResponse *) getMyDeviceInfo;

/*!
 * Get full detail for specific device for the specified account.
 * @param deviceId the identifier for the device to get details for.
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 */
-(CloudResponse *) getInfoOnDevice:(NSString*)deviceId;

/*!
 * Get a list of all tags from devices for the specified account.
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 */
-(CloudResponse *) getAllTags;

/*!
 * Get a list of all devices's attribute for the specified account.
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 */
-(CloudResponse *) getAllAttributes;

/*!
 * Activates a specific device for the specified account.
 * @param activationCode the activation code to be used for activating the device.
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 */
-(CloudResponse *) activateADevice:(NSString*)activationCode;

/*!
 * Add component to an specific device. A component represents either a time series or an
 * actuator. The type must already existing in the Component Type catalog.
 * @param componentName the name that identifies the component.
 * @param componentType the type of the component
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 */
-(CloudResponse *) addComponentToDevice:(NSString*)componentName WithType:(NSString*)componentType;

/*!
 * Delete a specific component for a specific device. All data will be unavailable. The device id
 * that is used will be the current device that is cached usually after a create new device.
 * @param componentName the name that identifies the component.
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 */
-(CloudResponse *) deleteAComponent:(NSString*)componentName;

/*!
 * Delete a specific device for this account. All data from all time series associated with
 * the device will be deleted.
 * @param deviceId the identifier for the device that will be deleted.
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 */
-(CloudResponse *) deleteADevice:(NSString*)deviceId;


@end



