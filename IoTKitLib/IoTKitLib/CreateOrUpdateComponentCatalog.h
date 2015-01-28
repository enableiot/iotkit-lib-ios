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

#ifndef IoT_CreateOrUpdateComponentCatalog_h
#define IoT_CreateOrUpdateComponentCatalog_h

@interface CreateOrUpdateComponentCatalog : NSObject

-(id) init __attribute__((unavailable("Must create object using \"CreateOrUpdateComponentCatalog\" method")));
+(id) CreateOrUpdateComponentCatalogWith:(NSString*) componentName AndVersion: (NSString*) componentVersion
                                 AndType:(NSString*) componentType AndDataType:(NSString*) componentDataType
                               AndFormat:(NSString*) componentFormat AndUnit:(NSString*) componentUnit
                              AndDisplay:(NSString*) componentDisplay;

-(void) setMinValue:(double) minValue ;
-(void) setMaxValue:(double) maxValue ;
-(void) setCommandString:(NSString*) commandString ;
-(void) addCommandParameters:(NSString*) commandName AndValue:(NSString*) commandValue ;

@end


#endif
