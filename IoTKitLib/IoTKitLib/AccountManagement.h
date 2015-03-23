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

-(CloudResponse *) createAnAccount:(NSString*)accountName;
-(CloudResponse *) getAccountInformation;
/*!
 * Get the account activation code which is the transient code that can be used to activate
 * devices for the account. It expires after one hour.
 *
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part {@link RequestStatusHandler#readResponse}.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 */
-(CloudResponse *) getAccountActivationCode;
-(CloudResponse *) renewAccountActivationCode;
-(CloudResponse *) updateAnAccount:(NSString*)accountNameToUpdate andOptionalAttributesWithSimpleKeyValues:(NSDictionary*)attributes;
-(CloudResponse *) addAnotherUserToAccount:(NSString*)accountId UserGettingInvited:(NSString*)inviteeUserId
                           Admin:(BOOL)isAdmin;
-(CloudResponse *) deleteAnAccount;

@end
