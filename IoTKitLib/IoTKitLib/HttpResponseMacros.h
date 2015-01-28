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

#ifndef IoT_HttpResponseMacros_h
#define IoT_HttpResponseMacros_h
//Authorization response matching macros
#define NEWAUTHTOKEN 100
#define GETAUTHTOKENINFO 101
#define VALIDATEAUTHTOKEN 102

//Account Management response matching macros
#define CREATEANACCOUNT 200
#define GETACCOUNTINFO 201
#define GETACTIVATIONCODE 202
#define RENEWACTIVATIONCODE 203
#define UPDATEACCOUNT 204
#define DELETEACCOUNT 205
#define ADDUSERTOACCOUNT 206

//Device Management response matching macros
#define LISTDEVICES 300
#define LISTALLATTRIBUTES 301
#define LISTALLTAGS 302
#define CREATEDEVICE 303
#define DELETEDEVICE 304
#define ACTIVATEDEVICE 305
#define UPDATEDEVICE 306
#define ADDCOMPONENT 307
#define DELETECOMPONENT 308
#define GETONEDEVICEINFO 309
#define GETMYDEVICEINFO 310

//Component type catalog response matching macros
#define LISTALLCOMPONENTTYPESCATALOG 400
#define LISTALLCOMPONENTTYPESCATALOGDETAILED 401
#define COMPONENTTYPECATALOGDETAILS 402
#define CREATECUSTOMCOMPONENT 403
#define UPDATECOMPONENT 404
//data response matching macros
#define SUBMITDATA 500
#define RETRIEVEDATA 501

//user Management response matching macros
#define CREATEUSER 600
#define GETUSERINFO 601
#define UPDATEUSERATTRIBUTES 602
#define ACCEPTTERMSANDCONDITIONS 603
#define DELETEUSER 604
#define REQUESTCHANGEPASSWORD 605
#define UPDATEFORGOTPASSWORD 606
#define CHANGEPASSWORD 607

//Invitation management response matching macros
#define GETINVITATIONLIST 700
#define GETINVITATIONLISTSENDTOSPECIFICUSER 701
#define CREATEINVITATION 702
#define DELETEINVITATIONS 703

//Rule management response matching macros
#define CREATERULE 800
#define UPDATERULE 801
#define DELETEDRAFTRULE 802
#define CREATERULEASDRAFT 803
#define UPDATESTATUSOFRULE 804
#define GETLISTOFRULES 805
#define GETINFOOFRULE 806

//Alert management response matching macros
#define CREATENEWALERT 900
#define GETLISTOFALERTS 901
#define GETALERTINFORMATION 902
#define RESETALERT 903
#define UPDATEALERTSTATUS 904
#define ADDCOMMENTSTOALERT 905

//Advanced data enquiry response matching macros
#define ADVANCEDENQUIRYOFDATA 1000

//Aggregated Report Interface matching macros
#define AGGREGATEDREPORTINTERFACE 1001

#endif
