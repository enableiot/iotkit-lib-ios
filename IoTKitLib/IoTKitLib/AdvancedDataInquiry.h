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

#import "DefaultConfiguration.h"
#import "AttributeFilter.h"

@interface AdvancedDataInquiry : DefaultConfiguration

-(id) init __attribute__((unavailable("Must create object using \"initAdvancedDataInquiryWithDefaults\" method")));
-(id)initAdvancedDataInquiryWithDefaults;
-(void)addGatewayId:(NSString*)gatewayId;
-(void)addDeviceId:(NSString*)deviceId;
-(void)addComponentId:(NSString*)componentId;
-(void)setStartTimestamp:(long)startTimestamp;
-(void)setEndTimestamp:(long)endTimestamp;
-(void)addReturnedMeasureAttributes:(NSString*)attribute;
-(void)setShowMeasureLocation:(BOOL)measureLocation;
-(void)addDevCompAttributeFilter:(AttributeFilter*)attributeFilter;
-(void)addMeasurementAttributeFilter:(AttributeFilter*)attributeFilter;
-(void)addValueFilter:(AttributeFilter*)attributeFilter;
-(void)setComponentRowLimit:(NSInteger)componentRowLimit;
-(void)setCountOnly:(BOOL)countOnly;
-(void)addSortInfo:(NSString*)name WithValue:(NSString*)value;
-(CloudResponse *)request;


@end
