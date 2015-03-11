//
//  AggregatedReportInterface.h
//  IoT
//
//  Created by RaghavendraX Gutta on 15/12/14.
//  Copyright (c) 2014 Intel. All rights reserved.
//

#import "DefaultConfiguration.h"
#import "AttributeFilter.h"

@interface AggregatedReportInterface : DefaultConfiguration

-(id) init __attribute__((unavailable("Must create object using \"initAggregatedReportInterfaceWithDefaults\" method")));

-(id) initAggregatedReportInterfaceWithDefaults;
-(void)setStartTimestamp:(long) startTimestamp;
-(void)setEndTimestamp:(long) endTimestamp;
-(void)addAggregationMethod:(NSString*) aggregation;
-(void)addDimension:(NSString*) dimension;
-(void)setOffset:(NSInteger) offset;
-(void)setLimit:(NSInteger) limit;
-(void)setCountOnly:(BOOL) countOnly;
-(void)setOutputType:(NSString*) outputType;
-(void)addDeviceId:(NSString*) deviceId;
-(void)addGatewayId:(NSString*) gatewayId;
-(void)addComponentId:(NSString*) componentId;
-(void)addSortInfo:(NSString*) name AndValue:(NSString*)value;
-(void)addFilter:(AttributeFilter*) attributeFilter;
-(BOOL)request;

@end
