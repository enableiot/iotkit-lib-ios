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

#ifndef IoT_Rule_h
#define IoT_Rule_h

#import "RuleActions.h"
#import "RuleConditionValues.h"

/*!
 * @brief The Rule object that encapsulated information about a rule
 */
@interface Rule:NSObject

/*!
 * Sets rule name
 * @param name The name of the rule
 */
-(void)setRuleName:(NSString*)name;

/*!
 * Sets rule Description
 * @param description The description of the rule.
 */
-(void)setRuleDescription:(NSString*)description;

/*!
 * Sets rule priority
 * @param priority The priority of the rule
 */
-(void)setRulePriority:(NSString*)priority;

/*!
 * Sets type of rule
 * @param type The type of rule
 */
-(void)setRuleType:(NSString*)type;

/*!
 * Sets status of rule
 * @param status The status of the rule
 */
-(void)setRuleStatus:(NSString*)status;

/*!
 * Sets resetType of rule
 * @param resetType The reset type
 */
-(void)setRuleResetType:(NSString*)resetType;

/*!
 * Sets population attributes on rule
 * @param attributes The population attributes
 */
-(void)setRulePopulationAttributes:(NSString*)attributes;

/*!
 * Sets rule opeartor name
 * @param opeartorName The name of the operator
 */
-(void)setRuleOperatorName:(NSString*)operatorName;

/*!
 * Adds rule action object to rule action list
 * @param ruleActionObj The rule action
 */
-(void)addRuleActions:(RuleActions*)ruleActionsObj;

/*!
 * Append population Id's to lsit of Id's
 * @param populationId The identifier for the population
 */
-(void)addRulePopulationId:(NSString*)populationId;

/*!
 * Append condition value obj to list of conditions
 * @param ruleConditionValuesObj The rule condition values
 */
-(void)addRuleConditionValues:(RuleConditionValues*)ruleConditionValuesObj;


@end

#endif
