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
#import "ConfigureRetrieveData.h"

/*!
 * @brief The DataManagement object that is used to send and receive data for a device from the cloud.
 */
@interface DataManagement : DefaultConfiguration

/*!
 * Submit data for specific device and it's component. Device and component have to be
 * registered in the cloud before sending observations. The device id
 * that is used will be the current device that is cached usually after a create new device.
 *
 * @param componentName  the name of the component to look up the component id.
 * @param componentValue the value to set for the component.
 * @param latitude       lat location for the device in decimal
 * @param longitude      lon location for the device in decimal
 * @param height         altitude value in meters
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 */
-(CloudResponse *) submitDataOn:(NSString*) componentName AndValue:(NSString*) componentValue
         AndLatitide:(double) latitude AndLongitude:(double) longitude AndHeight:(double) height
       AndAttributes:(NSDictionary*)attributes;

/**
 * Retrieve data for an account.
 *
 * @param objRetrieveData time series data criteria for retrieve data from the cloud
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part {@link RequestStatusHandler#readResponse}.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 */
-(CloudResponse *) retrieveDataOn:(ConfigureRetrieveData*)objRetrieveData;

@end
