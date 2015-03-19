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
#define IOTPREFERENCES @"IoTPreferences"
#define DATAACCOUNTID @"data_account_id"
#define INVITEEUSERID @"invitee_user_id"
#define DEVICEID @"deviceId"
#define DEVICENAME @"deviceName"
#define CONFIGDEVICEID @"device_id"
#define CONFIGOTHERDEVICEID @"other_device_id"
#define COMPONENTID @"cid"
//#define COMPONENTNAME @"componentName"
#define COMPONENTTYPE @"type"
#define COMPONENTCATALOGID @"cmp_catalog_id"
#define CURRENTTIME @"on"
#define ACCOUNTID @"accountId"
#define ATTRIBUTES @"attributes"
#define ID @"id"
#define CONFIGUSERID @"user_id"
#define TOKEN @"token"
#define EMAIL @"email"
#define RULEID @"rule_id"
#define DRAFTRULEID @"draft_rule_id"
#define EXTERNALRULEID @"externalId"
#define NAME @"name"
#define ALERTID @"alert_id"
#define STATUSNAME @"status_name"
#define USER @"user"
#define TIMESTAMP @"timestamp"
#define TEXT @"text"

@interface HttpUrlBuilder : NSObject

+(id) sharedInstance;
- (id) init __attribute__((unavailable("Must create singleton using \"sharedInstance\" method")));

@property (nonatomic,retain) NSString *baseUrl;
@property (nonatomic,assign) NSInteger thePort;
@property (nonatomic,assign) BOOL isSecured;
@property (nonatomic,retain) NSString *protocolType;

//Authorization Url strings
@property (nonatomic,retain) NSString *theNewAuthToken;
@property (nonatomic,retain) NSString *authTokenInfo;


//Account Management Url Strings
@property (nonatomic,retain) NSString *createAnAccount;
@property (nonatomic,retain) NSString *getAccountInfo;
@property (nonatomic,retain) NSString *getActivationCode;
@property (nonatomic,retain) NSString *renewActivationCode;
@property (nonatomic,retain) NSString *updateAccount;
@property (nonatomic,retain) NSString *deleteAccount;
@property (nonatomic,retain) NSString *addUserToAccount;


//Device Management Url Strings
@property (nonatomic,retain) NSString *listDevices;
@property (nonatomic,retain) NSString *listAllAttributes;
@property (nonatomic,retain) NSString *listAllTags;
@property (nonatomic,retain) NSString *createDevice;
@property (nonatomic,retain) NSString *deleteDevice;
@property (nonatomic,retain) NSString *activateDevice;
@property (nonatomic,retain) NSString *updateDevice;
@property (nonatomic,retain) NSString *addComponent;
@property (nonatomic,retain) NSString *deleteComponent;
@property (nonatomic,retain) NSString *getOneDeviceInfo;
@property (nonatomic,retain) NSString *getMyDeviceInfo;


//Component type catalog url strings
@property (nonatomic,retain) NSString *listAllComponentTypesCatalog;
@property (nonatomic,retain) NSString *listAllComponentTypesCatalogDetailed;
@property (nonatomic,retain) NSString *componentTypeCatalogDetails;
@property (nonatomic,retain) NSString *createCustomComponent;
@property (nonatomic,retain) NSString *updateComponent;


//data related url strings
@property (nonatomic,retain) NSString *submitData;
@property (nonatomic,retain) NSString *retrieveData;


//user Management Url Strings
@property (nonatomic,retain) NSString *createUser;
@property (nonatomic,retain) NSString *getUserInfo;
@property (nonatomic,retain) NSString *updateUserAttributes;
@property (nonatomic,retain) NSString *acceptTermsAndConditions;
@property (nonatomic,retain) NSString *deleteUser;
@property (nonatomic,retain) NSString *requestChangePassword;
@property (nonatomic,retain) NSString *changePassword;


//Invitation management URL strings
@property (nonatomic,retain) NSString *getInvitationList;
@property (nonatomic,retain) NSString *getInvitationListSendToSpecificUser;
@property (nonatomic,retain) NSString *createInvitation;
@property (nonatomic,retain) NSString *deleteInvitations;


//Rule Management URL strings
@property (nonatomic,retain) NSString *createRule;
@property (nonatomic,retain) NSString *updateRule;
@property (nonatomic,retain) NSString *deleteDraftRule;
@property (nonatomic,retain) NSString *createRuleAsDraft;
@property (nonatomic,retain) NSString *updateStatusOfRule;
@property (nonatomic,retain) NSString *getListOfRules;
@property (nonatomic,retain) NSString *getInfoOfRule;


//Alert Management Url Strings
@property (nonatomic,retain) NSString *createNewAlert;
@property (nonatomic,retain) NSString *getListOfAlerts;
@property (nonatomic,retain) NSString *getAlertInformation;
@property (nonatomic,retain) NSString *resetAlert;
@property (nonatomic,retain) NSString *updateAlertStatus;
@property (nonatomic,retain) NSString *addCommentToAlert;


//Advanced data enquiry
@property (nonatomic,retain) NSString *advancedEnquiryOfData;


//Aggregated Report Interface
@property (nonatomic,retain) NSString *aggregatedReportInterface;

-(NSString*) prepareUrlByAppendingUrl:(NSString*)appendUrlString
                     urlSlugValueList:(NSDictionary*)urlSlugDictionary;
+(void) parseAndStoreAuthorizationToken:(NSInteger)responseCode content:(NSString*)responseContent;
+(void) parseAndStoreTokenRelatedInfo:(NSInteger)responseCode content:(NSString*)responseContent;
+(void) parseAndStoreAccountDetails:(NSInteger)responseCode content:(NSString*)responseContent;
+(void) parseAndStoreUserDetails:(NSInteger)responseCode content:(NSString *)responseContent;
+(void) parseAndStoreAccountName:(NSInteger)responseCode content:(NSString*)responseContent;
+(void)parseAndStoreActivationCode:(NSInteger)responseCode content:(NSString*)responseContent;
+(void)parseAndStoreDeviceId:(NSInteger)responseCode content:(NSString*)responseContent;
+(void)parseAndStoreDeviceToken:(NSInteger)responseCode content:(NSString*)responseContent;
+(void)parseAndStoreComponentDetails:(NSInteger)responseCode content:(NSString*)responseContent;
+(void)parseAndStoreRuleId:(NSInteger)responseCode content:(NSString*)responseContent;
+(void)parseAndStoreDraftRuleId:(NSInteger)responseCode content:(NSString*)responseContent;
+(void)parseAndDeleteDraftRuleId:(NSInteger)responseCode;
-(void)deleteComponentFromUserDefaults:(NSInteger)responseCode;
-(void)cleanUpDeviceFromDefaults:(NSInteger)responseCode;
+(NSString*) createBasicHeadersWithBearerAuthToken;
+(NSString*) createBasicHeadersWithBearerDeviceToken;
+(NSString*)getAccountId;
+(NSString*)getAccountName;
+(NSString*)getAccountActivationCode;
+(NSString*)getDeviceId;
+(NSString*)getDeviceName;
+(NSString*)getUserId;
+(NSString*)getComponentId:(NSString*)componentName;
+(NSString*)getComponentName;
+(void)deleteAccountInUserDefaults:(NSInteger)responseCode;
+(void)resetUserDefaults;
+(void)parseAndResetDefaults:(NSInteger)responseCode;

@end
