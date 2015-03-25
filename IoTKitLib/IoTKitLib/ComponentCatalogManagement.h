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
#import "ComponentCatalog.h"

/*!
 * @brief The ComponentCatalogManagement object that is used to manage all aspects associated with
 * maintaining a list of capabilities that component connected to the enableiot cloud exposes.
 */
@interface ComponentCatalogManagement : DefaultConfiguration

/**
 * Get a list of all component types with minimal information.
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 */
-(CloudResponse *)listAllComponentTypesCatalog;

/**
 * Get a list of all component types with full detailed information.
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 */
-(CloudResponse *)listAllDetailsOfComponentTypesCatalog;

/**
 * Get a complete description of a component type for a specific component.
 * @param componentId the identifier for the component to get information for.
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 */
-(CloudResponse *)listComponentTypeDetails:(NSString*)componentId;

/**
 * Create a new custom component. The dimension and version attributes are used for determining
 * if the component exists. If not, a new component is created which auto-generated id results
 * the concatenation of dimension and version values.
 * @param createComponentCatalog the component type to be added to the catalog
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 */
-(CloudResponse *)createCustomComponent:(ComponentCatalog*) createComponentCatalog;

/**
 * Update a component type definition by creating a brand new component which definition is
 * composed by the origin component data plus the requested changes having in mind that minor
 * version info (version attribute) is incremented by 1.
 * @param createComponentCatalog the component type to be updated in the catalog.
 * @param componentId the identifier for the component to be updated.
 * @return For async model, return CloudResponse which wraps true if the request of REST
 * call is valid; otherwise false. The actual result from
 * the REST call is return asynchronously as part HttpResponseDelegatee of DefaultConfiguration.
 * For synch model, return CloudResponse which wraps HTTP return code and response.
 */
-(CloudResponse *)updateAComponent:(ComponentCatalog*) createComponentCatalog OnComponent:(NSString*)componentId;


@end
