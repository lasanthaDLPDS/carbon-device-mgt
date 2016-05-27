/*
 *   Copyright (c) 2016, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 *   WSO2 Inc. licenses this file to you under the Apache License,
 *   Version 2.0 (the "License"); you may not use this file except
 *   in compliance with the License.
 *   You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 *   Unless required by applicable law or agreed to in writing,
 *   software distributed under the License is distributed on an
 *   "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 *   KIND, either express or implied.  See the License for the
 *   specific language governing permissions and limitations
 *   under the License.
 *
 */
package org.wso2.carbon.device.mgt.jaxrs.service.api.admin;

import io.swagger.annotations.*;
import org.wso2.carbon.apimgt.annotations.api.API;
import org.wso2.carbon.device.mgt.jaxrs.beans.ApplicationWrapper;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

@API(name = "Application", version = "1.0.0", context = "/devicemgt_admin/applications", tags = {"devicemgt_admin"})

@Path("/applications")
@Api(value = "Application", description = "Application related operations are exposed through this API.")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public interface ApplicationManagementAdminService {

    @POST
    @Path("/install-application")
    @ApiOperation(
            consumes = MediaType.APPLICATION_JSON,
            produces = MediaType.APPLICATION_JSON,
            httpMethod = "POST",
            value = "Application installation API.(Internal API)",
            notes = "This is an internal API used for application installation on a device.")
    @ApiResponses(value = {
            @ApiResponse(code = 201, message = "Application wil be installed on the device."),
            @ApiResponse(code = 500, message = "Error while adding the application install operation.")
    })
    Response installApplication(
            @ApiParam(name = "applicationWrapper", value = "Application details of the application to be installed.",
                    required = true) ApplicationWrapper applicationWrapper);

    @POST
    @Path("/uninstall-application")
    @ApiOperation(
            consumes = MediaType.APPLICATION_JSON,
            produces = MediaType.APPLICATION_JSON,
            httpMethod = "POST",
            value = "Application uninstallation API.(Internal API)",
            notes = "This is an internal API used for application uninstallation on a device.")
    @ApiResponses(value = {
            @ApiResponse(code = 201, message = "Application wil be uninstalled on the device."),
            @ApiResponse(code = 500, message = "Error while adding the application uninstall operation.")
    })
    Response uninstallApplication(
            @ApiParam(name = "applicationWrapper", value = "Application details of the application to be uninstalled.",
                    required = true) ApplicationWrapper applicationWrapper);

}
