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
-(BOOL)getAggregatedReportInterface;
-(void)setReportMessageType:(NSString*) msgType;
-(void)setReportStartTimestamp:(long) startTimestamp;
-(void)setReportEndTimestamp:(long) endTimestamp;
-(void)addAggregationMethods:(NSString*) aggregation;
-(void)addDimensions:(NSString*) dimension;
-(void)setOffset:(NSInteger) offset;
-(void)setLimit:(NSInteger) limit;
-(void)setReportCountOnly:(BOOL) countOnly;
-(void)setOutputType:(NSString*) outputType;
-(void)addReportDeviceIds:(NSString*) deviceId;
-(void)addReportGatewayIds:(NSString*) gatewayId;
-(void)addReportComponentIds:(NSString*) componentId;
-(void)addReportSortInfo:(NSString*) name AndValue:(NSString*)value;
-(void)addFilters:(AttributeFilter*) attributeFilter;


@end
