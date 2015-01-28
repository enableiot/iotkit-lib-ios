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

#define HOST @"dashboard.us.enableiot.com"
#define PORT @"443"
#define ISSECURED @"true"
//Authorization
#define NEW_AUTH_TOKEN @"/v1/api/auth/token"
#define AUTH_TOKEN_INFO @"/v1/api/auth/tokeninfo"
//Account Management
#define CREATE_AN_ACCOUNT @"/v1/api/accounts"
#define GET_ACCOUNT_INFO @"/v1/api/accounts/{data_account_id}"
#define GET_ACCOUNT_ACTIVATION_CODE @"/v1/api/accounts/{data_account_id}/activationcode"
#define UPDATE_ACCOUNT_NAME @"/v1/api/accounts/{data_account_id}"
#define DELETE_ACCOUNT_NAME @"/v1/api/accounts/{data_account_id}"
#define ADD_USER_TO_ACCOUNT @"/v1/api/accounts/{data_account_id}/users/{invitee_user_id}"
#define RENEW_ACCOUNT_ACTIVATION_CODE @"/v1/api/accounts/{data_account_id}/activationcode/refresh"
#define GET_USER_ASSOCIAED_WITH_ACCOUNT @"/v1/api/accounts/{data_account_id}/users"
#define UPDATE_USER_ASSOCIATED_WITH_ACCOUNT @"/v1/api/accounts/{data_account_id}/users/{user_account_id}"
//Device Management
#define LIST_ALL_DEVICES @"/v1/api/accounts/{data_account_id}/devices"
#define GET_DEVICE_INFO @"/v1/api/accounts/{data_account_id}/devices/{other_device_id}"
#define GET_MY_DEVICE_INFO @"/v1/api/accounts/{data_account_id}/devices/{device_id}"
#define CREATE_DEVICE @"/v1/api/accounts/{data_account_id}/devices"
#define UPDATE_DEVICE @"/v1/api/accounts/{data_account_id}/devices/{device_id}"
#define ACTIVATE_DEVICE @"/v1/api/accounts/{data_account_id}/devices/{device_id}/activation"
#define DELETE_DEVICE @"/v1/api/accounts/{data_account_id}/devices/{other_device_id}"
#define ADD_COMPONENT @"/v1/api/accounts/{data_account_id}/devices/{device_id}/components"
#define DELETE_COMPONENT @"/v1/api/accounts/{data_account_id}/devices/{device_id}/components/{cid}"
#define LIST_ALL_TAGS @"/v1/api/accounts/{data_account_id}/devices/tags"
#define LIST_ALL_ATTRIBUTES @"/v1/api/accounts/{data_account_id}/devices/attributes"
//Data Management
#define SUBMIT_DATA @"/v1/api/data/{device_id}"
#define RETRIEVE_DATA @"/v1/api/accounts/{data_account_id}/data/search"
//Component Types Catalog
#define LIST_COMPONENTS @"/v1/api/accounts/{data_account_id}/cmpcatalog"
#define LIST_COMPONENTS_DETAILED @"/v1/api/accounts/{data_account_id}/cmpcatalog?full=true"
#define GET_COMPONENT_DETAILS @"/v1/api/accounts/{data_account_id}/cmpcatalog/{cmp_catalog_id}"
#define CREATE_COMPONENT_CATALOG @"/v1/api/accounts/{data_account_id}/cmpcatalog"
#define UPDATE_COMPONENT_CATALOG @"/v1/api/accounts/{data_account_id}/cmpcatalog/{cmp_catalog_id}"
//Invitation management
#define GET_LIST_OF_INVITATION @"/v1/api/accounts/{data_account_id}/invites"
#define GET_LIST_OF_INVITATION_SEND_TO_SPECIFIC_USER @"/v1/api/invites/{email}"
#define CREATE_INVITATION @"/v1/api/accounts/{data_account_id}/invites"
#define DELETE_INVITATIONS @"/v1/api/accounts/{data_account_id}/invites/{email}"
//User Management
#define CREATE_USER @"/v1/api/users"
#define GET_USER_INFO @"/v1/api/users/{user_id}"
#define UPDATE_USER_ATTRIBUTES @"/v1/api/users/{user_id}"
#define ACCEPT_TERMS_AND_CONDITIONS @"/v1/api/users/{user_id}"
#define DELETE_USER @"/v1/api/users/{user_id}"
#define REQUEST_CHANGE_PASSWORD @"/v1/api/users/forgot_password"
#define CHANGE_PASSWORD @"/v1/api/users/{email}/change_password"
//Rule Management
#define CREATE_RULE @"/v1/api/accounts/{data_account_id}/rules"
#define UPDATE_RULE @"/v1/api/accounts/{data_account_id}/rules/{rule_id}"
#define GET_LIST_OF_RULES @"/v1/api/accounts/{data_account_id}/rules"
#define GET_RULE_INFO @"/v1/api/accounts/{data_account_id}/rules/{rule_id}"
#define CREATE_DRAFT_RULE @"/v1/api/accounts/{data_account_id}/rules/draft"
#define UPDATE_RULE_STATUS @"/v1/api/accounts/{data_account_id}/rules/{rule_id}/status"
#define DELETE_DRAFT_RULE @"/v1/api/accounts/{data_account_id}/rules/draft/{rule_id}"
//Alert Management
#define CREATE_NEW_ALERT @"/v1/api/alerts"
#define GET_LIST_OF_ALERTS @"/v1/api/accounts/{data_account_id}/alerts"
#define GET_ALERT_INFO @"/v1/api/accounts/{data_account_id}/alerts/{alert_id}"
#define RESET_ALERT @"/v1/api/accounts/{data_account_id}/alerts/{alert_id}/reset"
#define UPDATE_ALERT_STATUS @"/v1/api/accounts/{data_account_id}/alerts/{alert_id}/status/{status_name}"
#define ADD_COMMENT_TO_ALERT @"/v1/api/accounts/{data_account_id}/alerts/{alert_id}/comments"
//Advanced data Inquiry
#define ADVANCED_DATA_INQUIRY @"/v1/api/accounts/{data_account_id}/data/search/advanced"
//Aggregated Report Interface
#define AGGREGATED_REPORT_INTERFACE @"/v1/api/accounts/{data_account_id}/data/report"

