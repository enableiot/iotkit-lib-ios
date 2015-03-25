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
 * @brief The AccountManagement object that is used to manage all aspects associated with an account
 */
@interface AccountManagement : DefaultConfiguration

/*!
 * Create an account with a name.
 *
 * @param accountName name of the account to be created.
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 */
-(CloudResponse *) createAnAccount:(NSString*)accountName;

/*!
 * Get the information about an account.
 *
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 */
-(CloudResponse *) getAccountInformation;

/*!
 * Get the account activation code which is the transient code that can be used to activate
 * devices for the account. It expires after one hour.
 *
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 */
-(CloudResponse *) getAccountActivationCode;

/*!
 * Force a renewal of the account activation code.
 *
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 */
-(CloudResponse *) renewAccountActivationCode;

/*!
 * Update the account with a list of attributes
 *
 * @param accountNameToUpdate the name that identifies the account to be updated
 * @param attributes the optional list of name value pair of attributes to be updated
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 */
-(CloudResponse *) updateAnAccount:(NSString*)accountNameToUpdate andOptionalAttributesWithSimpleKeyValues:(NSDictionary*)attributes;

/*!
 * Add another user to your account.
 *
 * @param accountId     The account id of the other user.
 * @param inviteeUserId The user id of the other user.
 * @param isAdmin       The role for this user in the current account.
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 * @throws JSONException
 */
-(CloudResponse *) addAnotherUserToAccount:(NSString*)accountId UserGettingInvited:(NSString*)inviteeUserId
                           Admin:(BOOL)isAdmin;
/*!
 * Delete the current account.
 *
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 */
-(CloudResponse *) deleteAnAccount;

@end
