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

#import "ViewController.h"
#import "IoTKitLib/AuthorizationManagement.h"

//#import "HttpResponseDelegatee.h"
//#import "DeviceManagament.h"
//#import "ComponentTypesCatalog.h"
//#import "DataManagement.h"
//#import "UserManagement.h"
//#import "InvitationManagement.h"
//#import "RuleManagement.h"
//#import "AlertManagement.h"
//#import "AdvancedDataEnquiry.h"
//#import "AggregatedReportInterface.h"


@interface ViewController ()


@end

@implementation ViewController

/***************************************************************************************************************************
 * FUNCTION NAME: viewDidLoad
 *
 * DESCRIPTION: method gets called on loading of view
 *
 * RETURNS: nothing
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

/***************************************************************************************************************************
 * FUNCTION NAME: connectToIoTServerSyncButtonClicked
 *
 * DESCRIPTION: synchronous version of method gets called on click of button,
 *
 * RETURNS: button action instance
 *
 * PARAMETERS : sender object
 **************************************************************************************************************************/

- (IBAction)connectToIoTServerSyncButtonClicked:(id)sender {
    self.responseCodeTextField.text = @"";
    self.responseTextView.text = @"";
    
    //Authorization,Executing on UI thread, Blocks UI
    dispatch_async(dispatch_get_main_queue(), ^{
        AuthorizationManagement *auth = [[AuthorizationManagement alloc] init];
        CloudResponse *response = [auth getNewAuthorizationTokenWithUsername:@"intel.aricent.iot5@gmail.com" andPassword:@"Password2529"];
        self.responseCodeTextField.text = [NSString stringWithFormat:@"%ld",(long)response.responseCode];
        self.responseTextView.text = response.responseString;
        NSLog(@"ViewController: done sending request for authorization token code:%d msg:%@", response.status, response.responseString);
    });
    //Authorization,Executing on background thread, Does not blocks UI
    /*dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{//Executing on background thread
        AuthorizationManagement *auth = [[AuthorizationManagement alloc] init];
        CloudResponse *response = [auth getNewAuthorizationTokenWithUsername:@"intel.aricent.iot5@gmail.com" andPassword:@"Password2529"];
        dispatch_sync(dispatch_get_main_queue(), ^{//response showing on UI thread
            self.responseCodeTextField.text = [NSString stringWithFormat:@"%ld",(long)response.responseCode];
            self.responseTextView.text = response.responseString;
        });
        NSLog(@"ViewController: done sending request for authorization token code:%d msg:%@", response.status, response.responseString);
    });*/
}

/***************************************************************************************************************************
 * FUNCTION NAME: connectToIoTServerButtonClicked
 *
 * DESCRIPTION: Asynchronous version of method gets called on click of button,
 *
 * RETURNS: button action instance
 *
 * PARAMETERS : sender object
 **************************************************************************************************************************/

- (IBAction)connectToIoTServerButtonClicked:(id)sender {
    self.responseCodeTextField.text = @"";
    self.responseTextView.text = @"";
    
    HttpResponseDelegatee *obj = [HttpResponseDelegatee sharedInstance];
    obj.readResponse = ^(CloudResponse* cloudResponse)
    {
        NSLog(@"ViewController:responseCode:%ld,responseContent:%@",(long)cloudResponse.responseCode,cloudResponse.responseString);
        dispatch_async(dispatch_get_main_queue(), ^{//Executing on UI thread
            self.responseCodeTextField.text = [NSString stringWithFormat:@"%ld",(long)cloudResponse.responseCode];
            self.responseTextView.text = cloudResponse.responseString;
        });
    };
    
    //Authorization,Executing on UI thread, does not block UI as it is async http call
    //note:following request can be executed on background thread
    AuthorizationManagement *auth = [[AuthorizationManagement alloc] init];
    CloudResponse *response = [auth getNewAuthorizationTokenWithUsername:@"intel.aricent.iot5@gmail.com" andPassword:@"Password2529"];
    NSLog(@"ViewController: done sending request for authorization token code:%d msg:%@", response.status, response.responseString);
    self.responseCodeTextField.text = [NSString stringWithFormat:@"%ld",(long)response.responseCode];
    self.responseTextView.text = response.responseString;
}

/***************************************************************************************************************************
 * FUNCTION NAME: getCurrentTimeInMillis
 *
 * DESCRIPTION: gets current time in millis
 *
 * RETURNS: millisecond time
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
-(double)getCurrentTimeInMillis{
    return [[NSDate date] timeIntervalSince1970] * 1000;
}
/***************************************************************************************************************************
 * FUNCTION NAME: didReceiveMemoryWarning
 *
 * DESCRIPTION: method gets called on memory pressure
 *
 * RETURNS: nothing
 *
 * PARAMETERS : nil
 **************************************************************************************************************************/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
