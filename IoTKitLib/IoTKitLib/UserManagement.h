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
 * @brief The UserManagement object that is used to manage all the aspects associated with an user
 */
@interface UserManagement : DefaultConfiguration

/*!
 * Create a new user
 *
 * @param emailId  the email id for the user which is used as an identifier
 * @param password the password for the user
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 * @throws JSONException
 */
-(CloudResponse *) createNewUserWith:(NSString*)emailId AndPassword:(NSString*)password;

/*!
 * Delete a user
 *
 * @param userId the identifier for the user to be deleted from the cloud
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 */
-(CloudResponse *) deleteUser:(NSString*)userId;

/*!
 * Get user information
 *
 * @param userId the identifier for the user for retrieving user information for
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 */
-(CloudResponse *) getUserInfo:(NSString*)userId;

/*!
 * Update the user attributes for a given user
 *
 * @param userId         The identifier for the user to update the attributes for
 * @param listOfUserAttributes A list of name value pairs that specify the user attributes for the user
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 * @throws JSONException
 */
-(CloudResponse *) updateUserAttributesOn:(NSString*) userId AndListOfAttributes:(NSDictionary*)listOfUserAttributes;

/*!
 * Request for change of password
 *
 * @param emailId The email address of the user that requests for a change of password
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 * @throws JSONException
 */
-(CloudResponse *) requestChangePasswordOn:(NSString*)emailId;

/*!
 * Update the password
 *
 * @param mailToken       The token that is used access the cloud backend for updating the password
 * @param newPassword The new password for the user
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 * @throws JSONException
 */

-(CloudResponse *) updateForgotPassword:(NSString*)mailToken AndNewPassword:(NSString*)newPassword;

/*!
 * Change the password for the user
 *
 * @param emailId    The email address of the user
 * @param currentPassword The current password for the user
 * @param newPassword     The new password for the user
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 * @throws JSONException
 */
-(CloudResponse *) changePasswordOn:(NSString*)emailId AndCurrentPassword:(NSString*)currentPassword
          AndNewPassword:(NSString*)newPassword;

@end
