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
 * @brief Module that handles invitations. Invitation to the account can be created by the user with
 * administrator permission. After created, invitation notification will be send as an email
 * message to the specific email account. Invited user has to login into IoT dashboard and
 * the accept/decline received invitation.
 */
@interface InvitationManagement : DefaultConfiguration

/*!
 * Get a list of invitations send to specific user.
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 */
-(CloudResponse *) getListOfInvitation;

/*!
 * Get the details about invitations send to specific user.
 * @param emailId The email that identifies the user
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 */
-(CloudResponse *) getInvitationListSendToSpecificUser:(NSString*)emailId;

/*!
 * Delete invitations to an account for a specific user
 * @param emailId identifier for the user
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 * @throws JSONException
 */
-(CloudResponse *) deleteInvitationsTo:(NSString*)emailId;

/*!
 * Create an invitation to send out to the user
 * @param emailId The email of the user to be invited
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 * @throws JSONException
 */
-(CloudResponse *) createInvitationTo:(NSString*)emailId;

@end
