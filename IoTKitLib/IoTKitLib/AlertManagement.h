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

/*!
 * @brief The AlertManagement object that is used to manage all aspects associated with alerts
 */
@interface AlertManagement : DefaultConfiguration

/*!
 * Get a list of all alerts for the specified account.
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 */
-(CloudResponse *)getListOfAlerts;

/*!
 * Get specific alert details connected with the account.
 * @param alertId the identifier for the alert to retrieve details.
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 */
-(CloudResponse *)getInfoOnAlert:(NSString*)alertId;

/*!
 * Change the alert status to "Closed". Alert won't be active any more.
 * @param alertId the identifier for the alert to reset.
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 */
-(CloudResponse *)resetAlert:(NSString*)alertId;

/*!
 * Change the status of the alert.
 * @param alertId the identifier for the alert to change the status on.
 * @param status the status to change to. The value should be one of the following values:
 *               ['New', 'Open', 'Closed'].
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 */
-(CloudResponse *)updateAlertStatus:(NSString*)alertId WithStatus:(NSString*)status;

/*!
 * Add a comment to the alert.
 * @param alertId the identifier for the alert that the comment will be attached to.
 * @param user the user that made the comment.
 * @param timeStamp the timestamp when the comment was made.
 * @param comment the comment text.
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 * @throws JSONException
 */
-(CloudResponse *)addCommentsToTheAlert:(NSString*)alertId OnUser:(NSString*)user
                      AtTime:(long)timeStamp WithComment:(NSString*)comment;
@end
