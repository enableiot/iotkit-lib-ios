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

#ifndef IoT_ComponentCatalog_h
#define IoT_ComponentCatalog_h

/*!
 * @brief The Component Catalog object that encapsulated information about a component
 */
@interface ComponentCatalog : NSObject

-(id) init __attribute__((unavailable("Must create object using \"ComponentCatalog\" method")));

/*!
 * Creates custom instance of the class ComponentCatalog
 * @return instance of the class ComponentCatalog
 * @param componentName The name of the component
 * @param componentVersion The version of the component
 * @param componentType The type of the component
 * @param componentDataType The data type
 * @param componentFormat The format of the data type
 * @param componentUnit The unit of the data type
 * @param componentDisplay The display
 */
+(id) ComponentCatalogWith:(NSString*) componentName AndVersion: (NSString*) componentVersion
                                 AndType:(NSString*) componentType AndDataType:(NSString*) componentDataType
                               AndFormat:(NSString*) componentFormat AndUnit:(NSString*) componentUnit
                              AndDisplay:(NSString*) componentDisplay;

/*!
 * Sets minimum Name
 * @param min The mininum value
 */
-(void) setMinValue:(double) min ;

/*!
 * Sets maximum Name
 * @param max The maximum value
 */
-(void) setMaxValue:(double) max ;

/*!
 * Sets command string Name
 * @param command The name of the command
 */
-(void) setCommandName:(NSString*) command ;

/*!
 * Adds command name-value pair to command params list
 * @param commandName The name of the command
 * @param commandValue The value of the command
 */
-(void) addCommandParameters:(NSString*) commandName AndValue:(NSString*) commandValue ;

@end


#endif
