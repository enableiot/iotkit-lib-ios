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
#define TAG @"HttpResponseDelegatee"

#import "HttpResponseDelegatee.h"
#import "HttpResponseMacros.h"
#import "HttpUrlBuilder.h"

@implementation HttpResponseDelegatee

/***************************************************************************************************************************
 * FUNCTION NAME: sharedInstance
 *
 * DESCRIPTION: Creates a shared instance of the class(singleton object creation)
 *
 * RETURNS: instance of the class HttpResponseDelegatee
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
+(id) sharedInstance{
    static HttpResponseDelegatee *objHttpResponseDelegatee;
    @synchronized(self){
        if(!objHttpResponseDelegatee){
            
            objHttpResponseDelegatee = [[HttpResponseDelegatee alloc] initSingleTon];
        }
    }
    return objHttpResponseDelegatee;
}
/***************************************************************************************************************************
 * FUNCTION NAME: initSingleTon
 *
 * DESCRIPTION: Creates instance of the class HttpResponseDelegatee
 *
 * RETURNS: instance of the class HttpResponseDelegatee
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
- (id)initSingleTon
{
    self = [super init];
    if (!self) {
        NSLog(@"%@:Not able to create Delegatee for response",TAG);
    }
    return self;
}
/***************************************************************************************************************************
 * FUNCTION NAME: cloudResponseOnOperation
 *
 * DESCRIPTION: Delegate method to handle responses
 *
 * RETURNS: nothing
 *
 * PARAMETERS : 1)operationName on which server responded
                2)responseCode from server
                3)responseContent from server
 **************************************************************************************************************************/
-(void)cloudResponseOnOperation:(NSInteger)operationName WithCode:(NSInteger)responseCode
                       response:(NSString*)responseContent{
    NSLog(@"%@:operationName:%ld,responseCode:%ld,responseContent:%@",TAG,(long)operationName,(long)responseCode,responseContent);
    switch (operationName) {
        case NEWAUTHTOKEN:
            [HttpUrlBuilder parseAndStoreAuthorizationToken:responseCode content:responseContent];
            break;
            
        case GETAUTHTOKENINFO:
            [HttpUrlBuilder parseAndStoreTokenRelatedInfo:responseCode content:responseContent];
            break;
        case VALIDATEAUTHTOKEN:
            NSLog(@"%@:validated auth token!!",TAG);
            break;
        case CREATEANACCOUNT:
            [HttpUrlBuilder parseAndStoreAccountDetails:responseCode content:responseContent];
            break;
        case GETACCOUNTINFO:
            NSLog(@"%@:got account info response!!",TAG);
            break;
        case GETACTIVATIONCODE:
            [HttpUrlBuilder parseAndStoreActivationCode:responseCode content:responseContent];
            break;
        case RENEWACTIVATIONCODE:
            [HttpUrlBuilder parseAndStoreActivationCode:responseCode content:responseContent];
            break;
        case UPDATEACCOUNT:
            [HttpUrlBuilder parseAndStoreAccountName:responseCode content:responseContent];
            break;
        case ADDUSERTOACCOUNT:
            NSLog(@"%@:got add another user to account response!!",TAG);
            break;
        case DELETEACCOUNT:
            NSLog(@"%@:got delete an account response!!",TAG);
            [HttpUrlBuilder deleteAccountInUserDefaults:responseCode];
            break;
        case LISTDEVICES:
            NSLog(@"%@:got list of devices response!!",TAG);
            break;
        case CREATEDEVICE:
            [HttpUrlBuilder parseAndStoreDeviceId:responseCode content:responseContent];
            break;
        case GETMYDEVICEINFO:
            NSLog(@"%@:got my device info response!!",TAG);
            break;
        case GETONEDEVICEINFO:
            NSLog(@"%@:got other device info response!!",TAG);
            break;
        case LISTALLTAGS:
            NSLog(@"%@:got list all tags response!!",TAG);
            break;
        case LISTALLATTRIBUTES:
            NSLog(@"%@:got  list all attributes response!!",TAG);
            break;
        case UPDATEDEVICE:
            NSLog(@"%@:got  update device response!!",TAG);
            break;
        case ACTIVATEDEVICE:
            [HttpUrlBuilder parseAndStoreDeviceToken:responseCode content:responseContent];
            break;
        case ADDCOMPONENT:
            [HttpUrlBuilder parseAndStoreComponentDetails:responseCode content:responseContent];
            break;
        case DELETECOMPONENT:
            [[HttpUrlBuilder sharedInstance] deleteComponentFromUserDefaults:responseCode];
            break;
        case DELETEDEVICE:
            [[HttpUrlBuilder sharedInstance] cleanUpDeviceFromDefaults:responseCode];
            NSLog(@"%@:got delete device response!!",TAG);
            break;
        case LISTALLCOMPONENTTYPESCATALOG:
            NSLog(@"%@:got list all component types catalog response!!",TAG);
            break;
        case LISTALLCOMPONENTTYPESCATALOGDETAILED:
            NSLog(@"%@:got list all detailed component types catalog  response!!",TAG);
            break;
        case COMPONENTTYPECATALOGDETAILS:
            NSLog(@"%@:got component type catalog details  response!!",TAG);
            break;
        case CREATECUSTOMCOMPONENT:
            NSLog(@"%@:got create custom component response!!",TAG);
            break;
        case UPDATECOMPONENT:
            NSLog(@"%@:got update custom component response!!",TAG);
            break;
        case SUBMITDATA:
            NSLog(@"%@:got submit data response!!",TAG);
            break;
        case RETRIEVEDATA:
            NSLog(@"%@:got retrieve data response!!",TAG);
            break;
        case CREATEUSER:
            [HttpUrlBuilder parseAndStoreUserDetails:responseCode content:responseContent];
            break;
        case GETUSERINFO:
            NSLog(@"%@:got get user info response!!",TAG);
            break;
        case UPDATEUSERATTRIBUTES:
            NSLog(@"%@:got retrieve data response!!",TAG);
            break;
        case ACCEPTTERMSANDCONDITIONS:
            NSLog(@"%@:got accept terms and conditions response!!",TAG);
            break;
        case DELETEUSER:
            [HttpUrlBuilder parseAndResetDefaults:responseCode];
            break;
        case REQUESTCHANGEPASSWORD:
            NSLog(@"%@:got request change password response!!",TAG);
            break;
        case UPDATEFORGOTPASSWORD:
            NSLog(@"%@:got update forgot password response!!",TAG);
            break;
        case CHANGEPASSWORD:
            NSLog(@"%@:got change password response!!",TAG);
            break;
        case GETINVITATIONLIST:
            NSLog(@"%@:got  list of invitations response!!",TAG);
            break;
        case GETINVITATIONLISTSENDTOSPECIFICUSER:
            NSLog(@"%@:got invitation list to specific user response!!",TAG);
            break;
        case CREATEINVITATION:
            NSLog(@"%@:got create invitation response!!",TAG);
            break;
        case DELETEINVITATIONS:
            NSLog(@"%@:got delete invitation response!!",TAG);
            break;
        case CREATERULE:
            [HttpUrlBuilder parseAndStoreRuleId:responseCode content:responseContent];
            break;
        case DELETEDRAFTRULE:
            [HttpUrlBuilder parseAndDeleteDraftRuleId:responseCode];
            break;
        case UPDATERULE:
            NSLog(@"%@:got update rule response!!",TAG);
            break;
        case CREATERULEASDRAFT:
            [HttpUrlBuilder parseAndStoreDraftRuleId:responseCode content:responseContent];
            break;
        case UPDATESTATUSOFRULE:
            NSLog(@"%@:got update rule status response!!",TAG);
            break;
        case GETLISTOFRULES:
            NSLog(@"%@:got rule list response!!",TAG);
            break;
        case GETINFOOFRULE:
            NSLog(@"%@:got rule info response!!",TAG);
            break;
        case CREATENEWALERT:
            NSLog(@"%@:got new alert creation response!!",TAG);
            break;
        case GETLISTOFALERTS:
            NSLog(@"%@:got list of alerts response!!",TAG);
            break;
        case GETALERTINFORMATION:
            NSLog(@"%@:got alert info response!!",TAG);
            break;
        case RESETALERT:
            NSLog(@"%@:got reset alert response!!",TAG);
            break;
        case UPDATEALERTSTATUS:
            NSLog(@"%@:got update alert status response!!",TAG);
            break;
        case ADDCOMMENTSTOALERT:
            NSLog(@"%@:got add comments to alert response!!",TAG);
            break;
        case ADVANCEDENQUIRYOFDATA:
            NSLog(@"%@:got advanced data search response!!",TAG);
            break;
        case AGGREGATEDREPORTINTERFACE:
            NSLog(@"%@:got aggregated report response!!",TAG);
            break;
        default:
            break;
            
    }
    NSLog(@"%@:user Default dictionary:%@",TAG,[[NSUserDefaults standardUserDefaults] objectForKey:IOTPREFERENCES]);
//    dispatch_async(dispatch_get_main_queue(), ^{
//        self.cloudResponse(responseCode,responseContent);
//    });
//    CFRunLoopStop(CFRunLoopGetCurrent());
    //handling over the response using background thread
    self.cloudResponse(responseCode,responseContent);
    
}

@end
