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

#import "BasicSetup.h"
#import "IoTKitLib/RuleManagement.h"

@interface Module_008_RuleManagementTests : BasicSetup

@property(nonatomic,retain)RuleManagement *ruleObject;

@end

@implementation Module_008_RuleManagementTests

- (void)setUp {
    [super setUp];
    _ruleObject = [[RuleManagement alloc]init];
}

- (void)tearDown {
    _ruleObject = nil;
    [super tearDown];
}

- (void)test_801_CreateARule{
    Rule *ruleObj = [[Rule alloc] init];
    RuleActions *ruleActionObj = [[RuleActions alloc] init];
    RuleConditionValues *ruleConditionValuesObj = [[RuleConditionValues alloc] init];
    
    [ruleObj setRuleName:[self getRandomRuleName]];
    [ruleObj setRuleDescription:@"This is a iotkit_wrapper rule"];
    [ruleObj setRulePriority:@"Medium"];
    [ruleObj setRuleType:@"Regular"];
    [ruleObj setRuleStatus:@"Active"];
    [ruleObj setRuleResetType:@"Automatic"];
    
    [ruleActionObj setRuleActionType:@"mail"];
    [ruleActionObj addRuleActionTarget:@"gutha.raghu@gmail.com"];
    [ruleActionObj addRuleActionTarget:@"intel.aricent.iot1@gmail.com"];
    
    [ruleObj addRuleActions:ruleActionObj];
    [ruleObj addRulePopulationId:@"685.1.1.1"];
    
    [ruleConditionValuesObj addConditionComponentWithKey:@"dataType" AndValue:@"Number"];
    [ruleConditionValuesObj addConditionComponentWithKey:@"name" AndValue:@"Temp.01.1"];
    [ruleConditionValuesObj setConditionType:@"basic"];
    [ruleConditionValuesObj addConditionValues:@"25"];
    [ruleConditionValuesObj setConditionOperator:@">"];
    
    [ruleObj setRuleOperatorName:@"OR"];
    [ruleObj addRuleConditionValues:ruleConditionValuesObj];
    
    CloudResponse *response = [_ruleObject createRule:ruleObj];
    XCTAssertEqual(response.responseCode, 201);
}
- (void)test_802_UpdateRule{
    Rule *updateRuleObj = [[Rule alloc] init];
    RuleActions *updateRuleActionObj = [[RuleActions alloc] init];
    RuleConditionValues *updateRuleConditionValuesObj = [[RuleConditionValues alloc] init];
    
    [updateRuleObj setRuleName:[self getRandomRuleName]];
    [updateRuleObj setRuleDescription:@"This is a iotkit_wrapper rule update"];
    [updateRuleObj setRulePriority:@"Medium"];
    [updateRuleObj setRuleType:@"Regular"];
    [updateRuleObj setRuleStatus:@"Active"];
    [updateRuleObj setRuleResetType:@"Automatic"];
    
    [updateRuleActionObj setRuleActionType:@"mail"];
    [updateRuleActionObj addRuleActionTarget:@"gutha.raghu@gmail.com"];
    [updateRuleActionObj addRuleActionTarget:@"intel.aricent.iot1@gmail.com"];
    
    [updateRuleObj addRuleActions:updateRuleActionObj];
    [updateRuleObj addRulePopulationId:@"685.3.1.3"];
    
    [updateRuleConditionValuesObj addConditionComponentWithKey:@"dataType" AndValue:@"Number"];
    [updateRuleConditionValuesObj addConditionComponentWithKey:@"name" AndValue:@"Temp"];
    [updateRuleConditionValuesObj setConditionType:@"basic"];
    [updateRuleConditionValuesObj addConditionValues:@"10"];
    [updateRuleConditionValuesObj setConditionOperator:@">"];
    
    [updateRuleObj setRuleOperatorName:@"OR"];
    [updateRuleObj addRuleConditionValues:updateRuleConditionValuesObj];
    CloudResponse *response = [_ruleObject updateARule:updateRuleObj OnRule:[[NSUserDefaults standardUserDefaults] objectForKey:RULEID]];
    XCTAssertEqual(response.responseCode, 201);
}
- (void)test_803_CreateRuleAsDraft{
    CloudResponse *response = [_ruleObject createRuleAsDraftUsing:
                               [NSString stringWithFormat:@"%@-Draft",[self getRandomRuleName]]];
    XCTAssertEqual(response.responseCode, 200);
}
- (void)test_804_DeleteADraftRule{
    CloudResponse *response = [_ruleObject deleteADraftRule:[[NSUserDefaults standardUserDefaults]
                                                             objectForKey:DRAFTRULEID]];
    XCTAssertEqual(response.responseCode, 204);
}
- (void)test_805_GetInformationOnRule{
    CloudResponse *response = [_ruleObject getInformationOnRule:[[NSUserDefaults standardUserDefaults]
                                                                 objectForKey:RULEID]];
    XCTAssertEqual(response.responseCode, 200);
}
- (void)test_806_GetListOfRules{
    CloudResponse *response = [_ruleObject getListOfRules];
    XCTAssertEqual(response.responseCode, 200);
}
@end
