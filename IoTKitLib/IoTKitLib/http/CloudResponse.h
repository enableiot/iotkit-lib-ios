//
//  CloudResponse.h
//  IoTKitLib
//
//  Created by Dzung D Tran on 3/17/15.
//  Copyright (c) 2015 Intel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CloudResponse : NSObject
@property (readonly, nonatomic) BOOL status;
@property (readonly, nonatomic) NSUInteger responseCode;
@property (readonly, nonatomic) NSString *responseString;
+(id)createCloudResponseWithStatus:(BOOL)status andMessage:(NSString*) message;
@end
