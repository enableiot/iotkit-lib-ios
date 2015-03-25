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
#import "Rule.h"

/*!
 * @brief Module that manages rules. A rule is an association between one or more
 * device's components, a set of conditions for those components, and a number of actions
 * that have to be triggered in case those conditions are met.
 */
@interface RuleManagement : DefaultConfiguration

/*!
 * Get a list of all rules for the specified account.
 *
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 */
-(CloudResponse *)getListOfRules;

/*!
 * Get specific rule details for the account
 *
 * @param ruleId the identifier for the rule to retrieve info for.
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 */
-(CloudResponse *)getInformationOnRule:(NSString*)ruleId;

/*!
 * Delete a specific draft rule for account.
 *
 * @param ruleId the identifier for the rule to delete.
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 */
-(CloudResponse *)deleteADraftRule:(NSString*)ruleId;

/*!
 * Update the status of the rule. Cannot be used for changing the status of draft rule.
 * Status value should be one of the following: ["Active", "Archived", "On-hold"]
 *
 * @param ruleId the identifier for the rule to have the status updated.
 * @param status value should be one of the following: ["Active", "Archived", "On-hold"]
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 */
-(CloudResponse *)updateStatusOfRule:(NSString*)ruleId WithStatus:(NSString*)status;

/*!
 * Create a rule with a status - "Draft" for the specified account.
 *
 * @param ruleName the name of the rule to create a draft
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 */
-(CloudResponse *)createRuleAsDraftUsing:(NSString*)ruleName;

/*!
 * Create a rule.
 *
 * @param ruleObj the information needed to create a new rule with.
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 */
-(CloudResponse *)createRule:(Rule*)ruleObj;

/*!
 * Update the rule.
 *
 * @param updateRuleObj the information that is used to update the rule with.
 * @param ruleId        the identifier for the rule to be updated.
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 */
-(CloudResponse *)updateARule:(Rule*)updateRuleObj OnRule:(NSString*)ruleId;

@end
